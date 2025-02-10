import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/main/home_view_model.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {
  HomeView({super.key, this.setSelectedIndex});

  Function? setSelectedIndex;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) =>
          model.initialize(context, widget.setSelectedIndex),
    );
  }

  buildWidget(BuildContext context, HomeViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var height = MediaQuery.of(context).size.height;
    return PopScope(
      child: Scaffold(
        backgroundColor: ColorUtils.appColorMain,
        body: RefreshIndicator(
          onRefresh: () {
            model.initialize(context, widget.setSelectedIndex);
            return Future.value();
          },
          child: SizedBox(
            child: SizedBox(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                              height: height * 0.16), // Reduced height here
                          // getWeekDealsView(model, context),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (isInvoke, result) {},
    );
  }

  // getWeekDealsView(HomeViewModel model, BuildContext context) {
  //   return model.weekDealList.isEmpty
  //       ? Container()
  //       : Container(
  //           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               ItemMainHeader(
  //                 image: ImageUtils.imgIcDeal,
  //                 content: StringUtils.txtDealsOfTheWeek,
  //                 onClicked: () {
  //                   model.onClickAllWeekDeal(context);
  //                 },
  //               ),
  //               FlutterCarousel(
  //                 options: CarouselOptions(
  //                   aspectRatio: 0.85,
  //                   disableCenter: true,
  //                   floatingIndicator: false,
  //                   showIndicator: true,
  //                   slideIndicator: CircularSlideIndicator(
  //                       slideIndicatorOptions: SlideIndicatorOptions(
  //                           indicatorBackgroundColor:
  //                               ColorUtils.appColorBlack_10,
  //                           currentIndicatorColor: ColorUtils.appColorPrimary)),
  //                 ),
  //                 items: model.weekDealList.map((item) {
  //                   return ItemWeekDealView(
  //                     model: item,
  //                     onClick: () {
  //                       model.onWeekDealItemClicked(context, item);
  //                     },
  //                     onFavoriteClicked: () {
  //                       model.onCampaignFavoriteClicked(context, item);
  //                     },
  //                   );
  //                 }).toList(),
  //               ),
  //             ],
  //           ),
  //         );
  // }

  @override
  bool get wantKeepAlive => true;
}
