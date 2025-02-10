import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/auth/verification_view_model.dart';
import '../items/item_appbar_logo.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerificationViewModel>.reactive(
      viewModelBuilder: () => VerificationViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(
      BuildContext context, VerificationViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return PopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorMain,
          body: SizedBox(
            child: Stack(children: <Widget>[
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
                                    model.onClickBack(context);
                                  },
                                  icon: SvgPicture.asset(
                                    ImageUtils.imgIcBackCircle,
                                    colorFilter: ColorFilter.mode(
                                        ColorUtils.appColorWhite, BlendMode.srcIn),
                                    width: 35,
                                  )),
                              Container(
                                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: textView(
                                    StringUtils.txtVerifyEmail,
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
                            alignment: Alignment.center,
                            height: height * 0.15,
                            child: model.user == null ? Container() :
                            Container(
                              child: textView(model.user!.email,
                                textColor: ColorUtils.appColorPrimary,
                                fontSize: SizeUtils.textSizeNormal,
                                isCentered: true
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: textView(
                                StringUtils.txtEnterVerificationCode,
                                textColor: ColorUtils.appColorWhite,
                                fontSize: SizeUtils.textSizeSMedium),
                          ),
                          VerificationCode(
                            fullBorder: true,
                            textStyle: TextStyle(
                                fontSize: SizeUtils.textSizeLarge,
                                color: ColorUtils.appColorWhite),
                            keyboardType: TextInputType.number,
                            underlineColor: ColorUtils.appColorWhite,
                            itemSize: width * 0.15,
                            length: 4,
                            cursorColor: ColorUtils.appColorWhite,
                            onCompleted: (String value) {
                              model.setVerificationCode(value);
                            },
                            onEditing: (bool value) {},
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 15),
                            child: RoundButton(
                                backgroundColor: ColorUtils.appColorAccent,
                                isStroked: false,
                                textContent: StringUtils.txtVerify,
                                textSize: SizeUtils.textSizeMedium,
                                textColor: ColorUtils.appColorPrimary,
                                radius: 5,
                                onPressed: () {
                                  model.onClickVerify(
                                    context,
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 15),
                            child: RoundButton(
                                isStroked: true,
                                backgroundColor: ColorUtils.appColorPrimary,
                                strokeColor: ColorUtils.appColorAccent,
                                textColor: ColorUtils.appColorAccent,
                                textContent: StringUtils.txtReSendVerificationCode,
                                textSize: SizeUtils.textSizeMedium,
                                radius: 5,
                                onPressed: () {
                                  model.onClickReSend(
                                    context,
                                  );
                                }),
                          ),
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              color: ColorUtils.appColorTransparent,
                              child: textViewUnderline(StringUtils.txtSignIn,
                                  textColor: ColorUtils.appColorWhite,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.w400,
                                  isCentered: false),
                            ),
                            onTap: () {
                              model.onClickLogin(context);
                            },
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ))
            ]),
          ),
        ),
        onPopInvokedWithResult: (isInvoke, result) {
          model.onClickBack(context);
        });
  }
}
