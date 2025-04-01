

import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import '../../model/common/news_model.dart';
import '../../model/common/plan_model.dart';
import '../../model/common/user_model.dart';
import '../../model/request/get_my_plan_req.dart';
import '../../model/response/get_news_res.dart';
import '../../model/response/get_plan_res.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/login_view.dart';
import '../../views/other/news_list_view.dart';
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

  onItemClicked(BuildContext context, NewsModel item) {

  }

  onClickAllNews(BuildContext context) {
    NewsListView().launch(context);
  }

  onClickPlanItem(BuildContext context, PlanModel item) {}
}