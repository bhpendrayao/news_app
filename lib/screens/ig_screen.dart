

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/ig_model.dart';
import 'package:news_app/view_model/ig_view_model.dart';

class IgScreen extends StatefulWidget {
  const IgScreen({super.key});

  @override
  State<IgScreen> createState() => _IgScreenState();
}

class _IgScreenState extends State<IgScreen> {

  IgViewModel igViewModel =IgViewModel();
  @override
  Widget build(BuildContext context) {
   final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ig',style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<igmodel>(
                future:igViewModel.fetchIgApi(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting)
                  {
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  }
                  else if(snapshot.hasError)
                  {
                    print('here');
                    return Center(
                      child: Text(
                        'Error ${snapshot.error}',
                        style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w700),
                      ),
                    );
                  }
                  else if(snapshot.data==null || snapshot.data.articles==null)
                  {
                    return Center(
                      child: Text(
                        'No Data Available :-( Try after 24 Hours',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w700),
                      ),
                    );
                  }
                  else{
                    return ListView.builder(
                        itemCount: snapshot.data!.points!.length,
                        itemBuilder: (context,index)
                        {

                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children: [
                                Expanded(child: Container(
                                  height: height*0.18,
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Text(snapshot.data![index].title.toString(),maxLines: 3,style: GoogleFonts.poppins(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w700),),
                                      Spacer(),
                                      Row(

                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(snapshot.data!.points![index].toString(),overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600),),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          );
                        }
                    );
                  }
                },

              ),
            ),
          ],
        ),
      ),
    );;
  }
}
