import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nxtlvl_app/extentions/widget_extensions.dart';

import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';

// ignore: must_be_immutable
class ItemMainHeader extends StatelessWidget {
  String? image;
  String content;
  final Function onClicked;
  bool? isHideAll;

  ItemMainHeader({
    super.key,
    this.image,
    required this.content,
    required this.onClicked,
    this.isHideAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        image == null ? Container() :
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
          child: SvgPicture.asset(
            image!,
            colorFilter: ColorFilter.mode(ColorUtils.appColorWhite, BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
        ),
        Container(
          child: textView(
            content,
            textColor: ColorUtils.appColorAccent,
            fontSize: SizeUtils.textSizeMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(child: Container()),
        GestureDetector(
          child: Container(
            color: ColorUtils.appColorTransparent,
            padding: const EdgeInsets.all(5),
            child: textView(
              StringUtils.txtViewAll,
              fontSize: SizeUtils.textSizeMedium,
              textColor: ColorUtils.appColorAccent,
            ),
          ),
          onTap: (){
            onClicked();
          },
        ).visible(isHideAll == null || isHideAll == false)
      ],
    );
  }
}
