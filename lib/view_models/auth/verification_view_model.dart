

import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';

import '../../model/common/user_model.dart';
import '../../model/request/resend_verification_req.dart';
import '../../model/request/verify_email_req.dart';
import '../../model/response/api_res.dart';
import '../../model/response/verify_email_res.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/login_view.dart';
import '../../views/main/main_view.dart';
import '../base_view_model.dart';

class VerificationViewModel extends BaseViewModel{
  UserModel? user;
  String verificationCode = '';

  initialize(BuildContext context) async{
    user = await sharedService.getUser();

    notifyListeners();
  }

  setVerificationCode(String code){
    verificationCode = code;
    notifyListeners();
  }

  onClickVerify(BuildContext context) async{
    if(verificationCode.length != 4){
      showMessage(StringUtils.txtEnterVerificationCode, null);
      return;
    }else {
      try{
        showLoading();
        VerifyEmailReq req = VerifyEmailReq(email: user!.email, verificationCode: verificationCode);
        VerifyEmailRes? res = await networkService.doVerifyEmail(req);
        hideLoading();
        if(res != null){
          showMessage(res.message ?? StringUtils.txtSomethingWentWrong, null); 
          if(res.status ?? false){
            sharedService.saveUser(res.user);
            Future.delayed(const Duration(milliseconds: 100)).then((value) {
              if(context.mounted) {
                MainView().launch(context, isNewTask: true);
              }
            },);
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
  }

  onClickReSend(BuildContext context) async{
    try{
        showLoading();
        ResendVerificationReq req = ResendVerificationReq(email: user!.email);
        ApiRes? res = await networkService.doResendVerifyEmail(req);
        hideLoading();
        if(res != null){
          showMessage(res.message ?? StringUtils.txtSomethingWentWrong, null); 
        }else {
          showMessage(StringUtils.txtSomethingWentWrong, null);
        }
      }catch(e){
        hideLoading();
        showMessage(StringUtils.txtSomethingWentWrong, null);
        debugPrint(e.toString());
      }
  }

  onClickBack(BuildContext context) {
    LoginView().launch(context, isNewTask: true);
  }

  onClickLogin(BuildContext context) {
    LoginView().launch(context, isNewTask: true);
  }
}