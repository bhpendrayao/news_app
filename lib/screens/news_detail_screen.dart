import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newsImage,newsTitle,newsDate,author, description ,content ,source;
  const NewsDetailScreen({Key? key,
    required this.newsImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,

  }):super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format= DateFormat('dd/MM/yy');
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;
    DateTime dateTime =DateTime.parse(widget.newsDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Headlines',style: GoogleFonts.poppins(fontWeight: FontWeight.w700,fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            child: Container(
              height: height*0.45,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                   topRight: Radius.circular(30),
                ),
                child: CachedNetworkImage(imageUrl: widget.newsImage,
                  fit: BoxFit.cover,
                  placeholder: (context,ulr)=> Center(child: CircularProgressIndicator(),),
                ),
              ),
            ),
          ),
          Container(
            height: height*0.6,
            margin: EdgeInsets.only(top: height*0.4),
            padding: EdgeInsets.only(right: 20,top: 20,left: 20),
            decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
            ),
            child: ListView(
              children: [
                Text(widget.newsTitle,style: GoogleFonts.poppins(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w700),)
                 ,SizedBox(height: height*0.02,),
                Row(
                  children: [
                    Expanded(child: Text(widget.source,style: GoogleFonts.poppins(fontSize: 13,color: Colors.black87,fontWeight: FontWeight.w600),)),
                    Text(format.format(dateTime),style: GoogleFonts.poppins(fontSize: 13,color: Colors.black87,fontWeight: FontWeight.w500),),

                  ],
                ),
                SizedBox(height: height*0.03,),
                Text(widget.description,style: GoogleFonts.poppins(fontSize: 15,color: Colors.black87,fontWeight: FontWeight.w500),)
              ],
            ),
          )
        ],
      ) ,
    );
  }
}
