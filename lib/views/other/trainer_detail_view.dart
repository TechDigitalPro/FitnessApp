import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nxtlvl_app/utils/string_utils.dart';
import 'package:stacked/stacked.dart';

import '../../model/common/trainer_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/other/trainer_detail_view_model.dart';
import '../items/item_appbar_logo_h.dart';
import '../items/item_main_header.dart';
import '../items/item_plan_view.dart';

// ignore: must_be_immutable
class TrainerDetailView extends StatefulWidget {
  TrainerDetailView({super.key, required this.trainer});

  TrainerModel trainer;

  @override
  State<TrainerDetailView> createState() => _TrainerDetailViewState();
}

class _TrainerDetailViewState extends State<TrainerDetailView>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TrainerDetailViewModel>.reactive(
      viewModelBuilder: () => TrainerDetailViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context, widget.trainer),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  buildWidget(
      BuildContext context, TrainerDetailViewModel model, Widget? child) {
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
              model.user == null ? Container() :
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.1,
                      width: width,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                                child: ItemMainHeader(
                                  isHideAll: true,
                                  content: StringUtils.txtWorkoutPlans,
                                  onClicked: () {},
                                )
                              ),
                              model.mList.isEmpty ? Container(height: 20,) :
                              CarouselSlider(
                                options: CarouselOptions(
                                  height: width * 0.7,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: false,
                                  initialPage: 0,
                                  autoPlay: false,
                                  enlargeFactor: 0.2
                                ),
                                items: model.mList.map((item) {
                                  bool isSelected = (model.user!.planId?.isNotEmpty ?? false) && model.user!.planId!.split(',').contains(item.id);
                                  return ItemPlanView(
                                    model: item,
                                    isSelected: isSelected,
                                    onClick: () {
                                      model.onItemClicked(context, item, isSelected);
                                    },
                                  );
                                } ).toList(),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: ItemMainHeader(
                                  isHideAll: true,
                                  content: StringUtils.txtInformation,
                                  onClicked: () {},
                                ),
                              ),
                              SizedBox(
                                child: ClipRRect(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(5)),
                                  child: model.trainerModel.imageUrl == null
                                      ? Container()
                                      : model.trainerModel.imageUrl!
                                                  .contains('http') ||
                                              model.trainerModel.imageUrl!
                                                  .contains('https')
                                          ? CachedNetworkImage(
                                              imageUrl: model.trainerModel.imageUrl!,
                                              width: width,
                                              fit: BoxFit.fitWidth,
                                              errorWidget: (context, url, error) =>
                                                  const Icon(Icons.error),
                                            )
                                          : Image.asset(
                                              model.trainerModel.imageUrl!,
                                              width: width,
                                              height: width * 9 / 16,
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: width,
                                child: textView(model.trainerModel.name,
                                    textColor: ColorUtils.appColorWhite,
                                    fontSize: SizeUtils.textSizeMedium,
                                    fontWeight: FontWeight.bold,
                                    isCentered: false,
                                    maxLine: 5),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              model.trainerModel.bio == null
                                  ? Container()
                                  : Container(
                                      child: textViewHtml(model.trainerModel.bio,
                                          textColor: ColorUtils.appColorWhite_80,
                                          fontSize: SizeUtils.textSizeSMedium,
                                          maxLine: 50),
                                    )
                            ],
                          ),
                        )),
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
                          title: StringUtils.txtTrainer,
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
}
