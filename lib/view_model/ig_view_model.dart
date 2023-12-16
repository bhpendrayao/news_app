import 'package:news_app/models/ig_model.dart';

import '../Repository/ig_repository.dart';

class  IgViewModel{

  final _repo = IgRepository();


  Future<igmodel> fetchIgApi() async{
    final response= await _repo.fetchIgApi();
    return response;
  }
}