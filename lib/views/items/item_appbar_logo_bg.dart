import 'package:flutter/material.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';
import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';

// ignore: must_be_immutable
class ItemAppbarLogoBg extends StatelessWidget {
  bool isLogo;
  bool isCenter;
  bool isTop;
  double? appbarHeight;

  ItemAppbarLogoBg({
    super.key,
    required this.isLogo,
    required this.isCenter,
    required this.isTop,
    this.appbarHeight,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: appbarHeight ?? height * 0.18,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              ColorUtils.appColorGradientStart,
              ColorUtils.appColorGradientEnd
            ]),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorUtils.appColorTransparent,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 50), // Add top padding here
        child: isLogo
          ? Container(
              padding: isCenter ? const EdgeInsets.all(0) : const EdgeInsets.fromLTRB(0, 0, 15, 0),
              alignment: isCenter
                ? (isTop ? Alignment.topCenter : Alignment.center)
                : (isTop ? Alignment.topRight : Alignment.centerRight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  isTop ? const SizedBox(height: 10) : const SizedBox(width: 0, height: 0),
                  SizedBox(
                    child: Image.asset(
                      ImageUtils.imgIcLogo,
                      width: isTop ? height * 0.05 : height * 0.07, // Adjusted width here
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    child: textView(
                      StringUtils.txtAppName,
                      textColor: ColorUtils.appColorBlack,
                      fontSize: isTop ? SizeUtils.textSizeSmall : SizeUtils.textSizeMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ).visible(!isTop)
                ],
              ),
            )
          : Container(),
      ),
    );
  }
}
