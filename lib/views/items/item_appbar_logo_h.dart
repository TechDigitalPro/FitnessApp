import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/widget_utils.dart';

// ignore: must_be_immutable
class ItemAppbarLogoH extends StatelessWidget {
  bool isLogo;
  bool isCenter;
  bool isTop;
  double? appbarHeight;
  String? title;

  ItemAppbarLogoH({
    super.key,
    required this.isLogo,
    required this.isCenter,
    required this.isTop,
    this.appbarHeight,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: appbarHeight ?? height * 0.12,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              ColorUtils.appColorGradientStart,
              ColorUtils.appColorGradientEnd
            ]),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorUtils.appColorWhite_5,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30), // Add top padding here
        child: isLogo
          ? Container(
              padding: isCenter ? const EdgeInsets.all(0) : const EdgeInsets.fromLTRB(0, 0, 15, 0),
              alignment: isCenter
                ? (isTop ? Alignment.topCenter : Alignment.center)
                : (isTop ? Alignment.topLeft : Alignment.centerLeft),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  isTop ? const SizedBox(height: 10) : const SizedBox(width: 0, height: 0),
                  Padding(
                    padding: const EdgeInsets.only(left: 20), // Adjust the left margin as needed
                    child: Image.asset(
                      ImageUtils.imgIcLogoIconWhite,
                      width: isTop ? height * 0.05 : height * 0.05, // Adjusted width here
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20), // Adjust the left margin as needed
                    child: Container(
                      child: textView(
                        title ?? '',
                        textColor: ColorUtils.appColorWhite,
                        fontSize: SizeUtils.textSizeLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ],
              ),
            )
          : Container(),
      ),
    );
  }
}
