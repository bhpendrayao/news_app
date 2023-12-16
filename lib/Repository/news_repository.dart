import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';

class NewsRepository{


  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(String ChannelName)async{
   // String url ='https://newsapi.org/v2/top-headlines?country=in&apiKey=c0f152e469194cb69fc242f7e8c53138' ;
    String url ='https://newsapi.org/v2/top-headlines?${ChannelName}&apiKey=a3c7fd9b2835472ea134c93fc6e2e0ee' ;
//sources=bbc-news
    final response =await http.get(Uri.parse(url));

    if(response.statusCode == 200)
      {
        final body= jsonDecode(response.body);
        return NewsChannelHeadlinesModel.fromJson(body);
      }
    throw Exception("Error");
  }


  Future<CategoriesNewsModel> fetchCategorynewsApi(String Category)async{
    String url ='https://newsapi.org/v2/everything?q=${Category}&apiKey=a3c7fd9b2835472ea134c93fc6e2e0ee';
    final response =await http.get(Uri.parse(url));

    if(response.statusCode == 200)
    {
      final body= jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception("Error");
  }

}