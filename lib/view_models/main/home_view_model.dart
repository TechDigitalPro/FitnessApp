

import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import '../../model/common/user_model.dart';
import '../../service/common_service.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/login_view.dart';
import '../base_view_model.dart';

class HomeViewModel extends BaseViewModel{
  UserModel? user;
  String? token;
  Function? setSelectedIndex;

  initialize(BuildContext context, Function? setIndex) async{
    setSelectedIndex = setIndex;
    token = await sharedService.getToken();
    user = await sharedService.getUser();
    try{
      // showLoading();
      // GetHomeRes? homeRes = await networkService.doGetHomeList(token ?? '');
      // hideLoading();
      // if(homeRes != null){
      //   if(homeRes.status ?? false){
          
      //   }else {
      //     showMessage(homeRes.message ?? StringUtils.txtSomethingWentWrong, null); 
      //     if(homeRes.message != null && homeRes.message!.toLowerCase().contains('token')){
      //       sharedService.clear();
      //       sharedService.saveIsFirst(false);
      //       Future.delayed(const Duration(milliseconds: 100)).then((value) {
      //         LoginView().launch(context, isNewTask: true);
      //       },);
      //     }
      //   }
      //   notifyListeners();
      // }else {
      //   showMessage(StringUtils.txtSomethingWentWrong, null);  
      // }
    }catch(e){
      hideLoading();
      showMessage(StringUtils.txtSomethingWentWrong, null);
      debugPrint(e.toString());
    }
  }
}