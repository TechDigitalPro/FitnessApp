import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nxtlvl_app/utils/string_utils.dart';
import 'package:stacked/stacked.dart';

import '../../model/common/workout_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/other/workout_detail_view_model.dart';
import '../items/item_appbar_logo_h.dart';

// ignore: must_be_immutable
class WorkoutDetailView extends StatefulWidget {
  WorkoutDetailView({super.key, required this.workout});

  WorkoutModel workout;

  @override
  State<WorkoutDetailView> createState() => _WorkoutDetailViewState();
}

class _WorkoutDetailViewState extends State<WorkoutDetailView>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WorkoutDetailViewModel>.reactive(
      viewModelBuilder: () => WorkoutDetailViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context, widget.workout),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  buildWidget(
      BuildContext context, WorkoutDetailViewModel model, Widget? child) {
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
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SizedBox(
                                    child: ClipRRect(
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(10)),
                                      child: model.workoutModel.imageUrl == null
                                          ? Container()
                                          : model.workoutModel.imageUrl!
                                                      .contains('http') ||
                                                  model.workoutModel.imageUrl!
                                                      .contains('https')
                                              ? CachedNetworkImage(
                                                  imageUrl: model.workoutModel.imageUrl!,
                                                  width: width,
                                                  fit: BoxFit.fitWidth,
                                                  errorWidget: (context, url, error) =>
                                                      const Icon(Icons.error),
                                                )
                                              : Image.asset(
                                                  model.workoutModel.imageUrl!,
                                                  width: width,
                                                  height: width * 9 / 16,
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0, right: 0, top: 0, bottom: 0,
                                    child: IconButton(
                                      onPressed: () {
                                        model.onItemClicked(context);
                                      },
                                      icon: Icon(Icons.play_circle,
                                        size: 50,
                                        color: ColorUtils.appColorAccent,
                                      )
                                    )
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: width,
                                child: textView(model.workoutModel.name,
                                    textColor: ColorUtils.appColorWhite,
                                    fontSize: SizeUtils.textSizeNormal,
                                    fontWeight: FontWeight.bold,
                                    isCentered: false,
                                    maxLine: 5),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              model.workoutModel.description == null
                                  ? Container()
                                  : Container(
                                      child: textViewHtml(model.workoutModel.description,
                                          textColor: ColorUtils.appColorWhite,
                                          fontSize: SizeUtils.textSizeMedium,
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
                          title: StringUtils.txtWorkout,
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
