import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/auth/login_view_model.dart';
import '../items/item_appbar_logo.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final TextEditingController textEditingControllerEmail =
      TextEditingController();
  final TextEditingController textEditingControllerPassword =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, LoginViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return PopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorMain,
          body: SizedBox(
            child: Stack(
              children: <Widget>[
                ItemAppbarLogo(
                  isLogo: false,
                  isCenter: false,
                  isTop: false,
                  appbarHeight: height * 0.12,
                ),
                SizedBox(
                  child: SizedBox(
                    child: Column(
                      children: [
                        Stack(
                      children: [
                        Container(
                          height: height * 0.12,
                          width: width,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(width: 10,),
                              IconButton(
                                  onPressed: () {
                                    model.onBackClicked(context);
                                  },
                                  icon: SvgPicture.asset(
                                    ImageUtils.imgIcBackCircle,
                                    colorFilter: ColorFilter.mode(
                                        ColorUtils.appColorWhite, BlendMode.srcIn),
                                    width: 35,
                                  )).visible(false),
                              Container(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: textView(
                                    StringUtils.txtSignIn,
                                    textColor: ColorUtils.appColorWhite,
                                    fontSize: SizeUtils.textSizeLarge,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ],
                          )
                        ),
                      ],
                    ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: height * 0.2,
                                alignment: Alignment.center,
                                child: Image.asset(
                                  ImageUtils.imgIcLogo,
                                  height: height * 0.1,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              EditTextField(
                                hintText: StringUtils.txtEmail,
                                isPassword: false,
                                isSecure: false,
                                mController: textEditingControllerEmail,
                                borderColor: ColorUtils.appColorBlack_50,
                                backgroundColor: ColorUtils.appColorWhite,
                                labelColor: ColorUtils.appColorBlack_50,
                                borderRadius: 5,
                                prefixIcon: Container(
                                  color: ColorUtils.appColorAccent_5,
                                  padding: const EdgeInsets.all(15),
                                  child: SvgPicture.asset(
                                    ImageUtils.imgIcEmail,
                                    colorFilter: ColorFilter.mode(ColorUtils.appColorBlack_50, BlendMode.srcIn),
                                  ),
                                ),
                                autoFocus: false,
                              ),
                              EditTextField(
                                hintText: StringUtils.txtPassword,
                                isPassword: true,
                                isSecure: true,
                                mController: textEditingControllerPassword,
                                borderColor: ColorUtils.appColorBlack_50,
                                backgroundColor: ColorUtils.appColorWhite,
                                labelColor: ColorUtils.appColorBlack_50,
                                borderRadius: 5,
                                prefixIcon: Container(
                                  color: ColorUtils.appColorAccent_5,
                                  padding: const EdgeInsets.all(13),
                                  child: SvgPicture.asset(
                                    ImageUtils.imgIcPassword,
                                    colorFilter: ColorFilter.mode(ColorUtils.appColorBlack_50, BlendMode.srcIn),
                                  ),
                                ),
                                autoFocus: false,
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Theme(
                                        data: ThemeData(
                                            unselectedWidgetColor: ColorUtils.appColorWhite,
                                            checkboxTheme: CheckboxThemeData(
                                              shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
                                            )
                                          ),
                                        child: Checkbox(
                                          value: model.isRememberMe,
                                          onChanged: (bool? value) {
                                            model.onSetRemember(value!);
                                          },
                                          activeColor: ColorUtils.appColorAccent,
                                        ),
                                      ),
                                      textView(StringUtils.txtRememberMe,
                                          textColor: ColorUtils.appColorWhite,
                                          fontSize: SizeUtils.textSizeSMedium)
                                    ],
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      color: ColorUtils.appColorTransparent,
                                      child: textViewUnderline(
                                        StringUtils.txtForgotPassword,
                                        textColor: ColorUtils.appColorWhite,
                                        fontSize: SizeUtils.textSizeSMedium,
                                        fontWeight: FontWeight.w400,
                                        isCentered: false),
                                    ),
                                    onTap: () {
                                      model.onClickResetPass(context);
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.fromLTRB(
                                    5, 15, 5, 15),
                                child: RoundButton(
                                    backgroundColor: ColorUtils.appColorAccent,
                                    isStroked: false,
                                    textContent: StringUtils.txtSignIn,
                                    textSize: SizeUtils.textSizeMedium,
                                    textColor: ColorUtils.appColorPrimary,
                                    radius: 5,
                                    onPressed: () {
                                      model.onClickLogin(
                                          context,
                                          textEditingControllerEmail.text,
                                          textEditingControllerPassword.text,
                                        );
                                    }),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: textView(
                                  StringUtils.txtDontHaveAnAccount,
                                      textColor: ColorUtils.appColorWhite,
                                      fontSize: SizeUtils.textSizeSMedium),
                              ),
                              GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  color: ColorUtils.appColorTransparent,
                                  child: textViewUnderline(
                                    StringUtils.txtSignUp,
                                    textColor: ColorUtils.appColorAccent,
                                    fontSize: SizeUtils.textSizeNormal,
                                    fontWeight: FontWeight.w400,
                                    isCentered: false),
                                ),
                                onTap: () {
                                  model.onClickSignUp(context);
                                },
                              ),
                            ],
                          ),
                          )
                          
                        )
                      ],
                    ),
                    
                  )
                )
                
              ]
            ),
          ),
        ),
        onPopInvokedWithResult: (isInvoke, result) {});
  }
}
