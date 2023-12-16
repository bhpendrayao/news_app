

import 'package:news_app/Repository/news_repository.dart';
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';

class  NewsViewModel{

  final _repo = NewsRepository();


  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(String ChannelName) async{
    final response= await _repo.fetchNewsChannelHeadlinesApi(ChannelName);
    return response;
  }
  Future<CategoriesNewsModel> fetchCategorynewsApi(String Category) async{
    final response= await _repo.fetchCategorynewsApi(Category);
    return response;
  }

}
