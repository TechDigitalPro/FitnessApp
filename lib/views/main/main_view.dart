import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/main/main_view_model.dart';
import '../items/item_appbar_logo.dart';
import '../items/item_appbar_logo_h.dart';

// ignore: must_be_immutable
class MainView extends StatefulWidget {
  MainView({super.key, this.index});

  int? index;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context, widget.index, tabController),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  buildWidget(BuildContext context, MainViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return PopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorMain,
          body: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom,),
            child: Stack(children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                    width: width,),
                  Expanded(
                    child: TabBarView(
                      controller: model.mTabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: model.navWidgets
                    )
                  ),
                  Material(
                      elevation: 0,
                      color: ColorUtils.appColorPrimary,
                      child: Column(
                        children: [
                          Container(
                            height: 1,
                            color: ColorUtils.appColorWhite_20,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 5, bottom: 5, left: width * 0.01, right: width * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: model.navIcons.map((item) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  child: GestureDetector(
                                    onTap: (){
                                      model.setSelectedIndex(model.navIcons.indexOf(item));
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: width * 0.2,
                                        color: ColorUtils.appColorTransparent,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: model.selectedIndex == model.navIcons.indexOf(item) ? 
                                              ColorUtils.appColorWhite_20 : ColorUtils.appColorTransparent,
                                              radius: 20,
                                              child: SvgPicture.asset(
                                                model.navIcons[model.navIcons.indexOf(item)],
                                                colorFilter: model.selectedIndex == model.navIcons.indexOf(item) ? 
                                                ColorFilter.mode( ColorUtils.appColorAccent, BlendMode.srcIn) : ColorFilter.mode( ColorUtils.appColorWhite, BlendMode.srcIn),
                                                width: model.selectedIndex == model.navIcons.indexOf(item) ? 20 : 24,
                                                height: model.selectedIndex == model.navIcons.indexOf(item) ? 20 : 24,
                                              ),
                                            ),
                                            const SizedBox(height: 5,),
                                            Container(
                                              child: textView(
                                                model.navTitles[model.navIcons.indexOf(item)],
                                                textColor: model.selectedIndex == model.navIcons.indexOf(item) ? 
                                                ColorUtils.appColorAccent : ColorUtils.appColorWhite,
                                                fontSize: SizeUtils.textSizeLSmall,
                                                isCentered: true,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                  )
                                );
                              }).toList(),
                            )
                          ),
                        ],
                      )
                    )
                ],
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
                          title: model.navTitles[model.selectedIndex],
                        ),
                        Positioned(
                          right: 0,
                          top: 30,
                          bottom: 0,
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: (){
                                model.onNotificationClicked(context);
                              }, 
                              icon: SvgPicture.asset(
                                ImageUtils.imgIcNotification, 
                                colorFilter: ColorFilter.mode(ColorUtils.appColorWhite, BlendMode.srcIn),
                                width: 24, height: 24, )
                            ),
                          ],
                        )
                        )
                      ],
                    ),
                    ],
                  ),
                ))
              ]),
            ),
          ),
          onPopInvokedWithResult: (isInvoke, result) {
            showDialog(
              context: context,
              builder: (BuildContext dlgContext) => const ExitDialog(),
            );
        });
  }
}
