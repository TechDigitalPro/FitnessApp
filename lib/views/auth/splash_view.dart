import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/auth/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, SplashViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return PopScope(
        child: Scaffold(
          body: Container(
              height: height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorUtils.appColorPrimaryDark,
                  ColorUtils.appColorPrimaryDark,
                  ColorUtils.appColorPrimary
                ],
              )),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          ImageUtils.imgIcLogo,
                          width: width * 0.3,
                          fit: BoxFit.fitWidth,
                        ),
                      ),                      
                    ],
                  )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: textView(StringUtils.txtCopyRight,
                        textColor: ColorUtils.appColorWhite,
                        fontSize: SizeUtils.textSizeLSmall),
                  ).visible(false),
                ],
              )),
        ),
        onPopInvokedWithResult: (isInvoke, result) {});
  }
}
