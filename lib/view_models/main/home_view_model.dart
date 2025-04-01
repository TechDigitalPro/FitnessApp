

import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import '../../model/common/news_model.dart';
import '../../model/common/plan_model.dart';
import '../../model/common/user_model.dart';
import '../../model/request/get_my_plan_req.dart';
import '../../model/request/set_plan_req.dart';
import '../../model/response/common_res.dart';
import '../../model/response/get_news_res.dart';
import '../../model/response/get_plan_res.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/login_view.dart';
import '../../views/dialog/confirm_dlg.dart';
import '../../views/other/news_list_view.dart';
import '../../views/other/plan_detail_view.dart';
import '../base_view_model.dart';

class HomeViewModel extends BaseViewModel{
  UserModel? user;
  String? token;
  Function? setSelectedIndex;
  List<NewsModel> mList = [];
  List<PlanModel> mPlanList = [];

  initialize(BuildContext context, Function? setIndex) async{
    setSelectedIndex = setIndex;
    token = await sharedService.getToken();
    user = await sharedService.getUser();
    
    try {
      if(context.mounted) {
        getMyPlans(context);
      }
      
      showLoading();
      GetNewsRes? res = await networkService.doGetNews(token ?? '');
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

  getMyPlans(BuildContext context) async{
    user = await sharedService.getUser();
    if(user == null || user!.planId == null || user!.planId!.isEmpty) {
      return;
    }
    try {
      GetMyPlanReq req = GetMyPlanReq(planId: user!.planId);
      GetPlansRes? res = await networkService.doGetMyPlans(token ?? '', req);
      if (res != null) {
        if (res.status ?? false) {
          mPlanList = res.list ?? [];
          
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

  onNewsItemClicked(BuildContext context, NewsModel item) {

  }

  onClickAllNews(BuildContext context) {
    NewsListView().launch(context);
  }

  onClickStartPlan(BuildContext context, PlanModel item) {
    showDialog(
        context: context,
        builder: (BuildContext dlgContext) => ConfirmDlg(
            title: StringUtils.txtConfirm,
            descriptions: StringUtils.txtCancelPlan,
            buttonText: StringUtils.txtConfirm,
            onClickConfirm: () {
              onPlanStart(context, item, false);
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
            getMyPlans(context);
          }
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

  onPlanItemClicked(BuildContext context, PlanModel item) {
    PlanDetailView(plan: item,).launch(context);
  }
}