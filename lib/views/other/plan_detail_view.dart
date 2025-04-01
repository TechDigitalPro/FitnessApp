import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nxtlvl_app/utils/string_utils.dart';
import 'package:stacked/stacked.dart';

import '../../model/common/plan_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/other/plan_detail_view_model.dart';
import '../items/item_appbar_logo_h.dart';
import '../items/item_main_header.dart';
import '../items/item_workout_view.dart';

// ignore: must_be_immutable
class PlanDetailView extends StatefulWidget {
  PlanDetailView({super.key, required this.plan});

  PlanModel plan;

  @override
  State<PlanDetailView> createState() => _PlanDetailViewState();
}

class _PlanDetailViewState extends State<PlanDetailView>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlanDetailViewModel>.reactive(
      viewModelBuilder: () => PlanDetailViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context, widget.plan),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  buildWidget(
      BuildContext context, PlanDetailViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return PopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorMain,
          body: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Stack(children: <Widget>[
              SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.1,
                      width: width,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: ItemMainHeader(
                              isHideAll: true,
                              content: StringUtils.txtInformation,
                              onClicked: () {},
                            )
                          ),
                          Container(
                            width: width,
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: textView(model.planModel.name,
                                textColor: ColorUtils.appColorWhite,
                                fontSize: SizeUtils.textSizeMedium,
                                fontWeight: FontWeight.bold,
                                isCentered: false,
                                maxLine: 5),
                          ),
                          model.planModel.description == null
                          ? Container()
                          : Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: textViewHtml(model.planModel.description,
                                  textColor: ColorUtils.appColorWhite_80,
                                  fontSize: SizeUtils.textSizeSMedium,
                                  maxLine: 50),
                            ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: ItemMainHeader(
                              isHideAll: true,
                              content: StringUtils.txtWorkout,
                              onClicked: () {},
                            )
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(0),
                        children: getListView(model, context),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(
                  child: SizedBox(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ItemAppbarLogoH(
                          isLogo: true,
                          isCenter: false,
                          isTop: false,
                          title: StringUtils.txtWorkoutPlans,
                        ),
                        Positioned(
                            right: 0,
                            top: 30,
                            bottom: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      finishView(context);
                                    },
                                    icon: SvgPicture.asset(
                                      ImageUtils.imgIcBackCircle,
                                      colorFilter: ColorFilter.mode(
                                          ColorUtils.appColorWhite,
                                          BlendMode.srcIn),
                                      width: 24,
                                      height: 24,
                                    )),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ))
            ]),
          ),
        ),
        onPopInvokedWithResult: (isInvoke, result) {});
  }

  getListView(PlanDetailViewModel model, BuildContext context) {
    return model.mList.map((item) {
      return ItemWorkoutView(
        model: item,
        onClick: () {
          model.onItemClicked(context, item);
        },
      );
    }).toList();
  }
}
