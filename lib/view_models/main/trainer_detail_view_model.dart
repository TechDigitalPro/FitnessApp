

import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import '../../model/common/plan_model.dart';
import '../../model/common/trainer_model.dart';
import '../../model/common/user_model.dart';
import '../../model/response/get_plan_res.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/login_view.dart';
import '../base_view_model.dart';

class TrainerDetailViewModel extends BaseViewModel{
  UserModel? user;
  late TrainerModel trainerModel = TrainerModel();
  String? token;
  List<PlanModel> mList = [];

  initialize(BuildContext context, TrainerModel trainer) async{
    token = await sharedService.getToken();
    user = await sharedService.getUser();
    trainerModel = trainer;
    
    try {
      showLoading();
      GetPlansRes? res = await networkService.doGetPlans(token ?? '');
      hideLoading();
      if (res != null) {
        if (res.status ?? false) {
          mList = res.list ?? [];
          
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

  onItemClicked(BuildContext context, PlanModel item) {
      
  }
}