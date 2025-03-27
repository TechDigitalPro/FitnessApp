import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/main/profile_view_model.dart';
import '../items/item_glass_card.dart';
import '../items/item_profile_view.dart';

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, ProfileViewModel model, Widget? child) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopScope(
        child: Scaffold(
          backgroundColor: ColorUtils.appColorMain,
          body: SizedBox(
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    height: height * 0.05,
                    child: IconButton(
                      splashRadius: 25,
                      icon: Icon(
                        Icons.edit_outlined,
                        color: ColorUtils.appColorWhite,
                      ),
                      onPressed: () {
                        model.onClickEdit(context);
                      },
                    ),
                  ),
                  model.user == null ? Container() :
                  Column(
                    children: [
                      Container(
                        height: height * 0.2,
                        width: height * 0.2,
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorUtils.appColorCard,
                            boxShadow: [
                              BoxShadow(
                                  color: ColorUtils.appColorBlack_10,
                                  blurRadius: 10,
                                  offset: Offset(0, 0)),
                            ]),
                        child: Stack(children: <Widget>[
                          model.imagePath.isNotEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                    size: Size.fromRadius(height * 0.1),
                                    child: Image.network(
                                      model.imagePath,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  )),
                                )
                              : Container(
                                  color: ColorUtils.appColorTransparent,
                                ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: ColorUtils.appColorWhite_50,
                                ),
                              ],
                            ),
                          ).visible(model.user == null ||
                              model.user!.imageUrl!.isEmpty),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: DottedBorder(
                                color: ColorUtils.appColorTextWhite,
                                strokeWidth: 1,
                                borderType: BorderType.Circle,
                                radius: const Radius.circular(10),
                                child: GestureDetector(
                                )),
                          ).visible(model.user == null ||
                              model.user!.imageUrl!.isEmpty),
                        ])),
                      ItemProfileView(
                          imageStr: ImageUtils.imgIcName,
                          titleStr: StringUtils.txtUserName,
                          contentStr: model.user!.name ?? ''),
                      ItemProfileView(
                          imageStr: ImageUtils.imgIcEmail,
                          titleStr: StringUtils.txtEmail,
                          contentStr: model.user!.email ?? '',
                          iconSize: 18,),
                      ItemProfileView(
                          imageStr: ImageUtils.imgIcPhone,
                          titleStr: StringUtils.txtMobileNumber,
                          contentStr: model.user!.mobile ?? '',
                          iconSize: 22,).visible(false),
                      ItemProfileView(
                          imageStr: ImageUtils.imgIcLogout,
                          titleStr: StringUtils.txtProfile,
                          contentStr: StringUtils.txtLogout,
                          iconSize: 22,
                          onTap: () {
                            model.onLogout(context);
                          },),
                      model.user!.bio == null ? Container() :
                      Container(
                        height: height * 0.2,
                        margin: EdgeInsets.all(5),
                        child: ItemGlassCard(
                          child: SizedBox(
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Container(
                                child: textViewHtml(
                                  model.user!.bio,
                                  textColor: ColorUtils.appColorWhite,
                                  fontSize: SizeUtils.textSizeMedium,
                                  maxLine: 50),
                              ),
                            )
                          )
                          
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      width: width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: GestureDetector(
                                    child: textViewUnderline(
                                      StringUtils.txtRemoveAccount,
                                      textColor: ColorUtils.appColorAccent,
                                      fontSize: SizeUtils.textSizeMedium,
                                      fontWeight: FontWeight.w500,
                                      isCentered: false,
                                    ),
                                    onTap: () {
                                      model.onClickDelete(context);
                                    }),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
          
        ),
        onPopInvokedWithResult: (isInvoke, result) {});
  }

  @override
  bool get wantKeepAlive => true;
}
