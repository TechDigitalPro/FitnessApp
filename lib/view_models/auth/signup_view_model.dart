import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../model/request/register_req.dart';
import '../../model/response/login_res.dart';
import '../../service/common_service.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../base_view_model.dart';

class SignUpViewModel extends BaseViewModel with WidgetsBindingObserver{
  bool isPrivacy = false;

  initialize(BuildContext context) {}

  onSetPrivacy(bool isSet) {
    isPrivacy = isSet;
    notifyListeners();
  }

  onClickPrivacy(BuildContext context) {
    launchURL(CommonService.privacyUrl);
  }

  onClickLogin(BuildContext context) {
    finishView(context);
  }

  onClickSignUp(BuildContext context, String userName, String email,
      String password, String confirmPassword) async {

    if (!isValidEmail(email)) {
      showMessage(StringUtils.txtPleaseEnterCorrectEmail, null);
      return;
    }
    if (!isValidPassword(password)) {
      showMessage(StringUtils.txtPleaseEnterCorrectPassword, null);
      return;
    }
    if (password != confirmPassword) {
      showMessage(StringUtils.txtPleaseEnterCorrectPassword, null);
      return;
    }
    if(!isPrivacy){
      showMessage(StringUtils.txtYouAgreeTermsPrivacy, null);
      return;
    }
    RegisterReq req = RegisterReq(
        name: userName,
        email: email,
        password: password,
        role: '0');
    try {
      showLoading();
      LoginRes? res = await networkService.doRegister(req);
      hideLoading();
      if (res != null) {
        if (res.status ?? false) {
          showMessage(res.message ?? StringUtils.txtSignIn, null);
          Future.delayed(const Duration(milliseconds: 200)).then((value) {
            if(context.mounted) {
              onBackClicked(context);
            }
          },);
        } else {
          showMessage(res.message ?? StringUtils.txtSomethingWentWrong, null);
        }
      } else {
        showMessage(StringUtils.txtSomethingWentWrong, null);
      }
    } catch (e) {
      hideLoading();
      showMessage(StringUtils.txtSomethingWentWrong, null);
      debugPrint(e.toString());
    }
  }

  launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {}
  }

  onBackClicked(BuildContext context) {
    finishView(context);
  }
}
