

import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';

import '../../model/request/login_req.dart';
import '../../model/response/login_res.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/reset_password_view.dart';
import '../../views/auth/signup_view.dart';
import '../../views/auth/verification_view.dart';
import '../../views/main/main_view.dart';
import '../base_view_model.dart';

class LoginViewModel extends BaseViewModel{
  
  bool isRememberMe = false;

  initialize(BuildContext context){
    
  }

  onSetRemember(bool isSet) {
    isRememberMe = isSet;
    notifyListeners();
  }

  onClickResetPass(BuildContext context) {
    ResetPasswordView().launch(context);
  }

  onClickLogin(BuildContext context, String email, String password) async{

    if(!isValidEmail(email)){
      showMessage(StringUtils.txtPleaseEnterCorrectEmail, null);
      return;
    }
    // if(!isValidPassword(password)){
    //   showMessage(StringUtils.txtPleaseEnterCorrectPassword, null);
    //   return;
    // }
    LoginReq req = LoginReq(email: email, password: password);
    try{
      showLoading();
      LoginRes? res = await networkService.doLogin(req);
      hideLoading();
      if(res != null){
        if(res.status ?? false){
          sharedService.saveToken(res.token ?? '');
          sharedService.saveUser(res.user);
          Future.delayed(const Duration(milliseconds: 100)).then((value) {
            if(context.mounted) {
              if(res.user!.active == '1'){
                MainView().launch(context, isNewTask: true);
              }else {
                showMessage(res.message ?? StringUtils.txtSomethingWentWrong, null);  
                const VerificationView().launch(context);
              }
            }
          },);
        }else {
          showMessage(res.message ?? StringUtils.txtSomethingWentWrong, null);  
        }
      }else {
        showMessage(StringUtils.txtSomethingWentWrong, null);
      }
    }catch(e){
      hideLoading();
      showMessage(StringUtils.txtSomethingWentWrong, null);
      debugPrint(e.toString());
    }
  }

  onClickSignUp(BuildContext context) {
    SignUpView().launch(context);
  }

  onBackClicked(BuildContext context) {
    finishView(context);
  }
}