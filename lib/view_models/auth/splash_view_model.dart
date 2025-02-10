import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';

import '../../model/common/user_model.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/intro_view.dart';
import '../../views/auth/login_view.dart';
import '../../views/auth/verification_view.dart';
import '../../views/main/main_view.dart';
import '../base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  UserModel? userModel;
  String? token;

  initialize(BuildContext context) async {
    checkTrackingTransparency(context);
    bool isFirst = await sharedService.getIsFirst();
    userModel = await sharedService.getUser();
    token = await sharedService.getToken();

    if(!isFirst){
      await Future.delayed(const Duration(milliseconds: 100)).then((value) {
        if(context.mounted) {
          if(token != null && userModel != null) {
            if(userModel!.active == '1') {
                MainView().launch(context, isNewTask: true);
              } else {
                const VerificationView().launch(context);
              }
          }else {
            LoginView().launch(context, isNewTask: true);
          }
        }
      });
    }else {
      await Future.delayed(const Duration(seconds: 1)).then((value) {
        if(context.mounted) {
          const IntroView().launch(context, isNewTask: true);  
        }
      });
    }
  }

  checkTrackingTransparency(BuildContext context) async{
    final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 100)).then((_){
        if(context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext dlgContext) => CustomDialog(
              title: StringUtils.txtTrackingTransparencyTitle,
              description: StringUtils.txtTrackingTransparency,
              cancelButtonStr: StringUtils.txtCancel,
              okButtonStr: StringUtils.txtContinue,
              okClicked: () async {
                await AppTrackingTransparency.requestTrackingAuthorization();
                await AppTrackingTransparency.getAdvertisingIdentifier();
              },
              cancelClicked: () async {
                await AppTrackingTransparency.getAdvertisingIdentifier();
              },
            )
          ); 
        }
      });
    }
  }
}
