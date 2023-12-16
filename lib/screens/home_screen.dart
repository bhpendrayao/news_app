

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/screens/news_detail_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

import '../models/categories_news_model.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}


enum FilterList{ bbcNews, aryNews , independent , timesofindia , cnn , alJazeera ,india}
class _HomescreenState extends State<Homescreen> {
  NewsViewModel newsViewModel =NewsViewModel();

  FilterList? selectedMenu;

  final format= DateFormat('dd/MM/yy');
  String name='sources=bbc-news';
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width*1;
    final height = MediaQuery.sizeOf(context).height*1;
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Categoryscreen()));
          },
          icon:Icon(Icons.menu),
        ),
        titleSpacing: 20,
        title: Text('News', style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.w700),),
        actions: [
         PopupMenuButton<FilterList>(
             initialValue: selectedMenu,
             onSelected: (FilterList item){
              if(FilterList.bbcNews.name == item.name)
                {
                  name='sources=bbc-news';
                }
              if(FilterList.aryNews.name == item.name)
              {
                name='sources=ary-news';
              }
              if(FilterList.alJazeera.name == item.name)
              {
                name='sources=al-jazeera-english';
              }
              if(FilterList.india.name == item.name)
              {
                name='country=in';
              }
              if(FilterList.timesofindia.name == item.name)
              {
                name='sources=the-times-of-india';
              }


              setState(() {
                selectedMenu=item;
              });
             },
             itemBuilder: (BuildContext context)=> <PopupMenuEntry<FilterList>>[
           PopupMenuItem<FilterList>(
               value: FilterList.bbcNews,
               child: Text('BBC News'),),
               PopupMenuItem<FilterList>(
                 value: FilterList.aryNews,
                 child: Text('Ary News'),),
               PopupMenuItem<FilterList>(
                 value: FilterList.alJazeera,
                 child: Text('Al-jazeera-english'),),
               PopupMenuItem<FilterList>(
                 value: FilterList.india,
                 child: Text('India'),),
               PopupMenuItem<FilterList>(
                 value: FilterList.timesofindia,
                 child: Text('Times of india'),),
         ])
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height*0.55,
              width: width,
              child: FutureBuilder<NewsChannelHeadlinesModel>(
                future:newsViewModel.fetchNewsChannelHeadlinesApi(name),
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
                  else{
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context,index)
                          {
                            DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                             return InkWell(
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
                               child: SizedBox(
                                 child: Stack(
                                   alignment: Alignment.center,
                                   children: [
                                     Container(
                                       width: width*0.9,
                                       height: height*.6,
                                       padding: EdgeInsets.symmetric(
                                         horizontal: height*.02
                                       ),
                                       child: ClipRRect(
                                         borderRadius: BorderRadius.circular(15),
                                         child: CachedNetworkImage(
                                           imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                           fit: BoxFit.fitHeight ,
                                           placeholder: (context, url)=>Container(child: spinkitty,),
                                           errorWidget: (context,url,error)=>Icon(Icons.error_outline,color: Colors.redAccent,),
                                         ),
                                       ),
                                     ),
                                     Positioned(
                                       bottom: 15,

                                       child: Card(
                                         elevation: 5,
                                         color: Colors.white,
                                         shape: RoundedRectangleBorder(
                                           borderRadius: BorderRadius.circular(12),
                                         ),
                                         child: Container(
                                          padding: EdgeInsets.all(10),
                                           alignment: Alignment.bottomCenter,
                                           height: height *.22,
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             children: [
                                               Container(
                                                 width: width*.7,
                                                 child: Text(snapshot.data!.articles![index].title.toString(),maxLines:3,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize: 17,fontWeight: FontWeight.w700),),
                                               ),
                                               Spacer(),
                                               Container(
                                                 width: width*.7,
                                                 child: Row(

                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Text(snapshot.data!.articles![index].source!.name.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w600),),
                                                     Text(format.format(dateTime),maxLines: 1,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w500),),
                                                   ],
                                                 ),
                                               )
                                             ],
                                           ),
                                         ),


                                       ),
                                     )
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
            SizedBox(height: 20,),
            Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: FutureBuilder<CategoriesNewsModel>(
                   future:newsViewModel.fetchCategorynewsApi('General'),
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
                           scrollDirection: Axis.vertical,
                           shrinkWrap: true,
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
                                               Text(snapshot.data!.articles![index].source!.name.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize: 10,fontWeight: FontWeight.w600),),
                                              // Text(format.format(dateTime),maxLines: 1,overflow: TextOverflow.ellipsis,style: GoogleFonts.poppins(fontSize: 11,fontWeight: FontWeight.w500),),
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
const spinkitty=SpinKitFadingCircle(
  size: 50,
  color: Colors.amber,
);