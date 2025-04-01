

import 'package:flutter/material.dart';
import '../../model/common/news_model.dart';
import '../../model/common/user_model.dart';
import '../base_view_model.dart';

class NewsDetailViewModel extends BaseViewModel{
  UserModel? user;
  late NewsModel newsModel = NewsModel();
  String? token;

  initialize(BuildContext context, NewsModel news) async{
    token = await sharedService.getToken();
    user = await sharedService.getUser();
    newsModel = news;
    notifyListeners();
  }
}