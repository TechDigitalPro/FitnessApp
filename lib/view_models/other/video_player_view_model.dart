import 'package:flutter/material.dart';

import '../base_view_model.dart';

class VideoPlayerViewModel extends BaseViewModel{
  late String videoUrl = '';

  initialize(BuildContext context, String url) async{
    videoUrl = url;

    notifyListeners();
  }
}