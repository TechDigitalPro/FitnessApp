

import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import '../../model/common/user_model.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/login_view.dart';
import '../../views/auth/verification_view.dart';
import '../../views/main/main_view.dart';
import '../base_view_model.dart';

class ProfileViewModel extends BaseViewModel{
  UserModel? user;

  initialize(BuildContext context) async{
    user = await sharedService.getUser();

    notifyListeners();
  }

  onClickDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dlgContext) =>
        CustomDialog(
          title: StringUtils.txtWarning,
          description: StringUtils.txtDoYouWantToDeleteProfile,
          okButtonStr: StringUtils.txtDelete,
          cancelButtonStr: StringUtils.txtCancel,
          okClicked: (){
            onClickRemoveSend(context);
          },
          cancelClicked: (){

          },
        ),
    );
  }

  onClickRemoveSend(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dlgContext) => CustomDialog(
        title: StringUtils.txtConfirm,
        description: StringUtils.txtRemoveAccountResult,
        cancelButtonStr: StringUtils.txtCancel,
        okButtonStr: StringUtils.txtConfirm,
        isCancelShow: false,
        okClicked: (){
          gotoLogin(context,);
        }
      )
    );
  }

  gotoLogin(BuildContext context) {
      sharedService.clear();
      MainView().launch(context, isNewTask: true);
    }

  onLogout(BuildContext context) {
    sharedService.clear();
    sharedService.saveIsFirst(false);
    MainView().launch(context, isNewTask: true);
  }

  onClickLogin(BuildContext context) {
    if(user == null){
      LoginView().launch(context);
    }else {
      const VerificationView().launch(context);
    }
  }
}