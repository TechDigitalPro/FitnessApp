


import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import '../../model/common/plan_model.dart';
import '../../model/common/trainer_model.dart';
import '../../model/common/user_model.dart';
import '../../model/request/get_plan_req.dart';
import '../../model/request/set_plan_req.dart';
import '../../model/response/common_res.dart';
import '../../model/response/get_plan_res.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/login_view.dart';
import '../../views/dialog/confirm_dlg.dart';
import '../../views/other/plan_detail_view.dart';
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
      GetPlansRes? res = await networkService.doGetPlans(token ?? '', GetPlanReq(userId: trainerModel.id));
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

  onItemStartClicked(BuildContext context, PlanModel item, bool isCurrent) {
    showDialog(
        context: context,
        builder: (BuildContext dlgContext) => ConfirmDlg(
            title: StringUtils.txtConfirm,
            descriptions: "${isCurrent ? StringUtils.txtCancelPlan : StringUtils.txtSurePlan}\nof\n${trainerModel.name}",
            buttonText: isCurrent ? StringUtils.txtConfirm : StringUtils.txtStart,
            onClickConfirm: () {
              onPlanStart(context, item, isCurrent ? false : true);
            }));
  }

  onPlanStart(BuildContext context, PlanModel item, bool isStart) async{
    try {
      showLoading();
      String planId = user!.planId ?? '';
      if(isStart) {
        planId = '${user!.planId},${item.id}';
      } else {
          List<String> list = planId.split(',');
          list.remove(item.id);
          planId = list.join(',');
      }

      SetPlanReq req = SetPlanReq(
        userId: user!.id,
        planId: planId,
      );
      CommonRes? res = await networkService.doSetPlans(token ?? '', req);
      hideLoading();
      if (res != null) {
        if (res.status ?? false) {
          user = res.user;
          sharedService.saveUser(user);
          
          if(context.mounted) {
            initialize(context, trainerModel);
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

  onItemClicked(BuildContext context, PlanModel item) {
    PlanDetailView(plan: item,).launch(context);
  }
}