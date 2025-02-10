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
import '../../view_models/main/profile_view_model.dart';
import '../../view_models/main/trainer_view_model.dart';
import '../../view_models/main/workout_view_model.dart';
import '../items/item_workout_view.dart';

// ignore: must_be_immutable
class WorkoutView extends StatefulWidget {
  WorkoutView({super.key, this.setSelectedIndex});

  Function? setSelectedIndex;

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<WorkoutViewModel>.reactive(
      viewModelBuilder: () => WorkoutViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) =>
          model.initialize(context, widget.setSelectedIndex),
    );
  }

  buildWidget(BuildContext context, WorkoutViewModel model, Widget? child) {
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
            child: ListView(
              children: getListView(model, context),
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (isInvoke, result) {},
    );
  }

  getListView(WorkoutViewModel model, BuildContext context) {
    return model.mList.map((item) {
      return ItemWorkoutView(
        model: item,
        onClick: () {
          model.onItemClicked(context, item);
        },
      );
    }).toList();
  }

  @override
  bool get wantKeepAlive => true;
}
