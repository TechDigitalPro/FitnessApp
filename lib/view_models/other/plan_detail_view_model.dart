

import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import '../../model/common/plan_model.dart';
import '../../model/common/user_model.dart';
import '../../model/common/workout_model.dart';
import '../../model/response/get_workouts_res.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/login_view.dart';
import '../../views/other/workout_detail_view.dart';
import '../base_view_model.dart';

class PlanDetailViewModel extends BaseViewModel{
  UserModel? user;
  String? token;
  late PlanModel planModel = PlanModel();
  List<WorkoutModel> mList = [];

  initialize(BuildContext context, PlanModel plan) async{
    token = await sharedService.getToken();
    user = await sharedService.getUser();
    planModel = plan;

    try {
      showLoading();
      GetWorkoutsRes? res = await networkService.doGetWorkouts(token ?? '');
      hideLoading();
      if (res != null) {
        if (res.status ?? false) {
          mList =  [];
          if (res.list != null) {
            List<String> idList = planModel.workoutIds == null 
              ? [] : planModel.workoutIds!.split(',').where((e) => e.isNotEmpty).toList();

            for(int i = 0; i < res.list!.length; i++) {
              if (idList.contains(res.list![i].id)) {
                mList.add(res.list![i]);
              } 
            } 
          }
          
          notifyListeners();
        } else {
          Future.delayed(const Duration(milliseconds: 100)).then((value) {
            showMessage(res.message ?? StringUtils.txtSomethingWentWrong, null);
            sharedService.clear();
            sharedService.saveIsFirst(false);
            if(context.mounted) {
              LoginView().launch(context, isNewTask: true);
            }
          },);
        }
      } else {
        Future.delayed(const Duration(milliseconds: 100)).then((value) {
            showMessage(StringUtils.txtSomethingWentWrong, null);  
          },);
      }
    } catch (e) {
      hideLoading();
      debugPrint(e.toString());
    }
  }

  onItemClicked(BuildContext context, WorkoutModel item) {
    WorkoutDetailView(workout: item,).launch(context);
  }
}