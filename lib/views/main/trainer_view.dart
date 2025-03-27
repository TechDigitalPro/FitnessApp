import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/system_utils.dart';
import '../../view_models/main/trainer_view_model.dart';
import '../items/item_trainer_view.dart';

// ignore: must_be_immutable
class TrainerView extends StatefulWidget {
  TrainerView({super.key, this.setSelectedIndex});

  Function? setSelectedIndex;

  @override
  State<TrainerView> createState() => _TrainerViewState();
}

class _TrainerViewState extends State<TrainerView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<TrainerViewModel>.reactive(
      viewModelBuilder: () => TrainerViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) =>
          model.initialize(context, widget.setSelectedIndex),
    );
  }

  buildWidget(BuildContext context, TrainerViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
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

  getListView(TrainerViewModel model, BuildContext context) {
    return model.mList.map((item) {
      return ItemTrainerView(
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
