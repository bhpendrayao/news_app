


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_news_model.dart';

import '../view_model/news_view_model.dart';
import 'news_detail_screen.dart';

class Categoryscreen extends StatefulWidget {
  const Categoryscreen({super.key});

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen> {

  NewsViewModel newsViewModel =NewsViewModel();


  final format= DateFormat('dd/MM/yy');
  String Category='General';


  List<String> Categorylist=[
    'General',
    'Entertainment',
    'Cricket',
    'Sports',
    'Health',
    'Business',
    'Technology'

  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Category',style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Categorylist.length,
                  itemBuilder: (context,index){
                   return Center(
                     child: InkWell(
                       onTap: (){
                         Category=Categorylist[index];
                         setState(() {

                         });
                       },
                       child: Padding(
                         padding: const EdgeInsets.only(right: 12.0),
                         child: Container(
                           decoration: BoxDecoration(
                             color:  Category==Categorylist[index]?Colors.blueAccent:Colors.blueGrey,
                             borderRadius: BorderRadius.circular(20),
                           ),

                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 12.0),
                             child: Text(Categorylist[index].toString(),style: GoogleFonts.poppins(fontSize: 15,color: Colors.white),),
                           ),
                         ),
                       ),
                     ),
                   );
                  }),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future:newsViewModel.fetchCategorynewsApi(Category),
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
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context,index)
                        {

                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> NewsDetailScreen(
                                  newsImage: snapshot.data!.articles![index].urlToImage.toString(),
                                  newsTitle:snapshot.data!.articles![index].title.toString(),
                                  newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                                  author: snapshot.data!.articles![index].author.toString(),
                                  description: snapshot.data!.articles![index].description.toString(),
                                  content: snapshot.data!.articles![index].content.toString(),
                                  source:snapshot.data!.articles![index].source!.name.toString(),)));
                              },
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.fitHeight ,
                                      height: height*0.18,
                                      width: width*0.3,
                                      placeholder: (context, url)=>Container(child: SpinKitCircle(
                                        size: 50,
                                        color: Colors.blue,
                                      ),),
                                      errorWidget: (context,url,error)=>Icon(Icons.error_outline,color: Colors.redAccent,),
                                    ),
                                  ),
                                  Expanded(child: Container(
                                    height: height*0.18,
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      children: [
                                        Text(snapshot.data!.articles![index].title.toString(),maxLines: 3,style: GoogleFonts.poppins(fontSize: 15,color: Colors.black54,fontWeight: FontWeight.w700),),
                                        Spacer(),
                                        Row(

                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(snapshot.data!.articles![index].source!.name.toString(),overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600),),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
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
    );
  }
}
