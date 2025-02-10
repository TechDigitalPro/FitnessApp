import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/dots_indicator/src/dots_decorator.dart';
import '../../utils/dots_indicator/src/dots_indicator.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/auth/intro_view_model.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IntroViewModel>.reactive(
      viewModelBuilder: () => IntroViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, IntroViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return PopScope(
      child: Scaffold(
        body: SizedBox(
          child: Stack(
            children: <Widget>[
              Container(
                width: width,
                height: height,
                color: ColorUtils.appColorPrimaryDark,
              ),
              SizedBox(
                width: width,
                height: height,
                child: PageView(
                  controller: model.pageController,
                  children: <Widget>[
                    WalkThrough(
                      textTitle: StringUtils.txtIntroTitle_1,
                      textContent: StringUtils.txtIntroDescription_1,
                      backImg: ImageUtils.imgIcIntro_1,
                    ),
                    WalkThrough(
                      textTitle: StringUtils.txtIntroTitle_2,
                      textContent: StringUtils.txtIntroDescription_2,
                      backImg: ImageUtils.imgIcIntro_2,
                    ),
                    WalkThrough(
                      textTitle: StringUtils.txtIntroTitle_3,
                      textContent: StringUtils.txtIntroDescription_3,
                      backImg: ImageUtils.imgIcIntro_3,
                    ),
                  ],
                  onPageChanged: (value) {
                    model.setCurrentIndex(value);
                  },
                ),
              ),
              Positioned(
                bottom: 20.0,
                left: 20.0,
                child: SizedBox(
                  width: width * 0.3,
                  child: RoundButton(
                    isStroked: false,
                    textContent: StringUtils.txtSkip,
                    textSize: SizeUtils.textSizeSMedium,
                    onPressed: () {
                      model.onClickSkip(context);
                    },
                    textColor: ColorUtils.appColorPrimary,
                    backgroundColor: ColorUtils.appColorAccent,
                    radius: 30,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: height * 0.2,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      DotsIndicator(
                        dotsCount: 3,
                        position: model.currentIndex,
                        decorator: DotsDecorator(
                          color: ColorUtils.appColorWhite_50,
                          activeColor: ColorUtils.appColorAccent,
                          activeSize: const Size.square(12.0),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Container(
                        width: width,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        alignment: Alignment.center,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorUtils.appColorWhite,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: ColorUtils.appColorBlack_10,
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                            child: IconButton(
                              color: ColorUtils.appColorWhite,
                              onPressed: () {
                                model.onClickNext(context);
                              },
                              icon: Icon(
                                Icons.navigate_next,
                                size: 30,
                                color: ColorUtils.appColorPrimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onPopInvokedWithResult: (isInvoke, result) {},
    );
  }
}
