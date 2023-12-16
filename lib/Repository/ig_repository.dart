import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/ig_model.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';

class IgRepository{


  Future<igmodel> fetchIgApi()async{
    // String url ='https://newsapi.org/v2/top-headlines?country=in&apiKey=c0f152e469194cb69fc242f7e8c53138' ;
    String url ='https://campaverse-production.up.railway.app/api/v1/leaderboard_points' ;
//sources=bbc-news
    final response =await http.get(Uri.parse(url));
  print(url);
    if(response.statusCode == 200)
    {
      final body= jsonDecode(response.body);
      return igmodel.fromJson(body);
    }
    throw Exception("Error");
  }


}