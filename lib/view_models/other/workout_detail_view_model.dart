

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nxtlvl_app/utils/string_utils.dart';
import 'package:nxtlvl_app/utils/widget_utils.dart';
import '../../model/common/user_model.dart';
import '../../model/common/workout_model.dart';
import '../../views/other/video_player_view.dart';
import '../base_view_model.dart';

class WorkoutDetailViewModel extends BaseViewModel{
  UserModel? user;
  late WorkoutModel workoutModel = WorkoutModel();
  String? token;

  initialize(BuildContext context, WorkoutModel workout) async{
    token = await sharedService.getToken();
    user = await sharedService.getUser();
    workoutModel = workout;
    notifyListeners();
  }

  onItemClicked(BuildContext context) {
    if(workoutModel.videoUrl != null) {
      VideoPlayerView(url: workoutModel.videoUrl!,).launch(context);
    } else {
      showMessage(StringUtils.txtNoVideo, null);
    }
  }
}