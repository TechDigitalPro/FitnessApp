import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/auth/reset_password_view_model.dart';
import '../items/item_appbar_logo.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final TextEditingController textEditingControllerEmail =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      viewModelBuilder: () => ResetPasswordViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, ResetPasswordViewModel model, Widget? child) {
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
                                    model.onClickBack(context);
                                  },
                                  icon: SvgPicture.asset(
                                    ImageUtils.imgIcBackCircle,
                                    colorFilter: ColorFilter.mode(
                                        ColorUtils.appColorWhite, BlendMode.srcIn),
                                    width: 35,
                                  )),
                              Container(
                                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: textView(
                                    StringUtils.txtResetPassword,
                                    textColor: ColorUtils.appColorWhite,
                                    fontSize: SizeUtils.textSizeLarge,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                            ],
                          )
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
                              const SizedBox(height: 50,),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: textView(
                                  StringUtils.txtSendPasswordResetLink,
                                      textColor: ColorUtils.appColorWhite,
                                      fontSize: SizeUtils.textSizeSMedium),
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.fromLTRB(
                                    5, 5, 5, 15),
                                child: RoundButton(
                                  backgroundColor: ColorUtils.appColorAccent,
                                    isStroked: false,
                                    textContent: StringUtils.txtSend,
                                    textSize: SizeUtils.textSizeMedium,
                                    textColor: ColorUtils.appColorPrimary,
                                    radius: 5,
                                    onPressed: () {
                                      model.onClickResetPass(
                                          context,
                                          textEditingControllerEmail.text,
                                        );
                                    }),
                              ),
                              GestureDetector(
                                child: Container(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                  color: ColorUtils.appColorTransparent,
                                  child: textViewUnderline(
                                    StringUtils.txtBack,
                                    textColor: ColorUtils.appColorAccent,
                                    fontSize: SizeUtils.textSizeNormal,
                                    fontWeight: FontWeight.w400,
                                    isCentered: false),
                                ),
                                onTap: () {
                                  model.onClickBack(context);
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
