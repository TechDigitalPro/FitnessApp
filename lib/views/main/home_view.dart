import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nxtlvl_app/views/items/item_plan_view.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../view_models/main/home_view_model.dart';
import '../items/item_main_header.dart';
import '../items/item_news_view.dart';

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    getPlanListView(model, context),
                    getNewsListView(model, context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      onPopInvokedWithResult: (isInvoke, result) {},
    );
  }

  getNewsListView(HomeViewModel model, BuildContext context) {
    return model.mList.isEmpty
        ? Container()
        : SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ItemMainHeader(
                    isHideAll: false,
                    content: StringUtils.txtNews,
                    onClicked: () {
                      model.onClickAllNews(context);
                    },
                  ),
                ),
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: model.mList.map((item) {
                      return ItemNewsView(
                        model: item,
                        onClick: () {
                          model.onItemClicked(context, item);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
  }

  getPlanListView(HomeViewModel model, BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return model.mPlanList.isEmpty
        ? Container()
        : SizedBox(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: ItemMainHeader(
                  isHideAll: true,
                  content: StringUtils.txtMyPlans,
                  onClicked: () {},
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                    height: width * 0.7,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    autoPlay: false,
                    enlargeFactor: 0.2),
                items: model.mPlanList.map((item) {
                  bool isSelected = (model.user!.planId?.isNotEmpty ?? false) &&
                      model.user!.planId!.split(',').contains(item.id);
                  return ItemPlanView(
                    model: item,
                    isSelected: isSelected,
                    onClick: () {
                      model.onClickPlanItem(context, item);
                    },
                  );
                }).toList(),
              )
            ],
          ),
        );
  }

  @override
  bool get wantKeepAlive => false;
}
