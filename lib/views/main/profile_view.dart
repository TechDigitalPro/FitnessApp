import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/main/home_view_model.dart';
import '../../view_models/main/profile_view_model.dart';
import '../items/item_profile_view.dart';

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, ProfileViewModel model, Widget? child) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorMain,
          body: model.user != null && model.user!.active != '0' ?
            SizedBox(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.15,
                  ),
                  model.user == null ? Container() :
                  Column(
                    children: [
                      ItemProfileView(
                          imageStr: ImageUtils.imgIcName,
                          titleStr: StringUtils.txtUserName,
                          contentStr: model.user!.name ?? ''),
                      ItemProfileView(
                          imageStr: ImageUtils.imgIcEmail,
                          titleStr: StringUtils.txtEmail,
                          contentStr: model.user!.email ?? '',
                          iconSize: 18,),
                      ItemProfileView(
                          imageStr: ImageUtils.imgIcPhone,
                          titleStr: StringUtils.txtMobileNumber,
                          contentStr: model.user!.mobile ?? '',
                          iconSize: 22,).visible(false),
                      ItemProfileView(
                          imageStr: ImageUtils.imgIcLogout,
                          titleStr: StringUtils.txtProfile,
                          contentStr: StringUtils.txtLogout,
                          iconSize: 22,
                          onTap: () {
                            model.onLogout(context);
                          },),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                                child: GestureDetector(
                                    child: textViewUnderline(
                                      StringUtils.txtRemoveAccount,
                                      textColor: ColorUtils.appColorAccent,
                                      fontSize: SizeUtils.textSizeMedium,
                                      fontWeight: FontWeight.w500,
                                      isCentered: false,
                                    ),
                                    onTap: () {
                                      model.onClickDelete(context);
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
          : SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Center(
                      child: textView(
                        model.user == null
                            ? StringUtils.txtYouMustCreateOrLogin
                            : StringUtils.txtYouMustVerifyEmail,
                        textColor: ColorUtils.appColorBlack,
                        fontSize: SizeUtils.textSizeMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(
                        5, 25, 5, 15),
                    child: RoundButton(
                      backgroundColor: ColorUtils.appColorPrimary,
                        isStroked: false,
                        textContent:  model.user == null ?
                          StringUtils.txtSignIn : StringUtils.txtVerifyEmail,
                        textSize: SizeUtils.textSizeMedium,
                        radius: 5,
                        onPressed: () {
                          model.onClickLogin(
                              context,
                            );
                        }),
                  ),
                ]
              ),
            )
          ),
        ),
        onPopInvokedWithResult: (isInvoke, result) {});
  }

  @override
  bool get wantKeepAlive => true;
}
