

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import '../../model/common/user_model.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/login_view.dart';
import '../../views/auth/verification_view.dart';
import '../base_view_model.dart';

class ProfileViewModel extends BaseViewModel{
  UserModel? user;
  String imagePath = '';

  initialize(BuildContext context) async{
    user = await sharedService.getUser();
    imagePath = user!.imageUrl!;

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
      LoginView().launch(context, isNewTask: true);
    }

  onLogout(BuildContext context) {
    sharedService.clear();
    sharedService.saveIsFirst(false);
    LoginView().launch(context, isNewTask: true);
  }

  onClickLogin(BuildContext context) {
    if(user == null){
      LoginView().launch(context);
    }else {
      const VerificationView().launch(context);
    }
  }

  onClickAddPhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      imagePath = image.path;
    }

    notifyListeners();
  }

  onClickEdit(BuildContext context) {

  }
}