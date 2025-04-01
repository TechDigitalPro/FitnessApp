import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nxtlvl_app/utils/string_utils.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/system_utils.dart';
import '../../view_models/other/news_list_view_model.dart';
import '../items/item_appbar_logo_h.dart';
import '../items/item_news_list_view.dart';

// ignore: must_be_immutable
class NewsListView extends StatefulWidget {
  const NewsListView({super.key});

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsListViewModel>.reactive(
      viewModelBuilder: () => NewsListViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  buildWidget(
      BuildContext context, NewsListViewModel model, Widget? child) {
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
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.1,
                      width: width,
                    ),
                    Expanded(
                      child: ListView(
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
                          title: StringUtils.txtNews,
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

  getListView(NewsListViewModel model, BuildContext context) {
    return model.mList.map((item) {
      return ItemNewsListView(
        model: item,
        onClick: () {
          model.onItemClicked(context, item);
        },
      );
    }).toList();
  }
}
