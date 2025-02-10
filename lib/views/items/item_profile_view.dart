import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/widget_utils.dart';

// ignore: must_be_immutable
class ItemProfileView extends StatelessWidget {
  ItemProfileView(
      {super.key,
      required this.imageStr,
      required this.titleStr,
      required this.contentStr,
      this.iconSize,
      this.onTap});

  final String imageStr;
  final String titleStr;
  final String contentStr;
  final double? iconSize;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(
                  imageStr, 
                  colorFilter: ColorFilter.mode(ColorUtils.appColorWhite, BlendMode.srcIn),
                  width: iconSize ?? 24,
                  height: iconSize ?? 24,
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: textView(titleStr,
                        textColor: ColorUtils.appColorWhite,
                        fontSize: SizeUtils.textSizeSmall,
                        isCentered: false),
                    ),
                    Container(
                      child: textView(contentStr,
                        textColor: ColorUtils.appColorWhite,
                        fontSize: SizeUtils.textSizeSMedium,
                        isCentered: false,
                        fontWeight: FontWeight.w500),
                    )
                  ],
                )),
              ],
            ),
          ),
          Container(
            height: 0.5,
            color: ColorUtils.appColorWhite_20,
            margin: const EdgeInsets.all(10),
          )
        ],
      ),
    );
  }
}