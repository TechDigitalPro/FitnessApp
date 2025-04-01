import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nxtlvl_app/utils/string_utils.dart';
import 'package:stacked/stacked.dart';

import '../../model/common/news_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/other/news_detail_view_model.dart';
import '../items/item_appbar_logo_h.dart';

// ignore: must_be_immutable
class NewsDetailView extends StatefulWidget {
  NewsDetailView({super.key, required this.news});

  NewsModel news;

  @override
  State<NewsDetailView> createState() => _NewsDetailViewState();
}

class _NewsDetailViewState extends State<NewsDetailView>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsDetailViewModel>.reactive(
      viewModelBuilder: () => NewsDetailViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context, widget.news),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  buildWidget(
      BuildContext context, NewsDetailViewModel model, Widget? child) {
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
                                          const BorderRadius.all(Radius.circular(5)),
                                      child: model.newsModel.imageUrl == null
                                          ? Container()
                                          : model.newsModel.imageUrl!
                                                      .contains('http') ||
                                                  model.newsModel.imageUrl!
                                                      .contains('https')
                                              ? CachedNetworkImage(
                                                  imageUrl: model.newsModel.imageUrl!,
                                                  width: width,
                                                  fit: BoxFit.fitWidth,
                                                  errorWidget: (context, url, error) =>
                                                      const Icon(Icons.error),
                                                )
                                              : Image.asset(
                                                  model.newsModel.imageUrl!,
                                                  width: width,
                                                  height: width * 9 / 16,
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: width,
                                child: textView(model.newsModel.title,
                                    textColor: ColorUtils.appColorWhite,
                                    fontSize: SizeUtils.textSizeMedium,
                                    fontWeight: FontWeight.bold,
                                    isCentered: false,
                                    maxLine: 5),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              model.newsModel.content == null
                                  ? Container()
                                  : Container(
                                      child: textViewHtml(model.newsModel.content,
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
}
