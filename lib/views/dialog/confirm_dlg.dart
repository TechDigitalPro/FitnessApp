import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';

// ignore: must_be_immutable
class ConfirmDlg extends StatefulWidget {
  ConfirmDlg(
      {super.key,
      required this.title,
      required this.descriptions,
      required this.buttonText,
      this.onClickConfirm});
  final String title, descriptions, buttonText;
  Function? onClickConfirm;

  @override
  State<ConfirmDlg> createState() => _ConfirmDlgState();
}

class _ConfirmDlgState extends State<ConfirmDlg> {
  
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      backgroundColor: ColorUtils.appColorTransparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: ColorUtils.appColorMain,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: ColorUtils.appColorBlack_50,
                    offset: Offset(0, 10),
                    blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              textView(widget.title,
                  textColor: ColorUtils.appColorWhite,
                  fontSize: SizeUtils.textSizeNormal,
                  fontWeight: FontWeight.w600,
                  isCentered: true,
                  maxLine: 2),
              const SizedBox(height: 15,),
              textView(widget.descriptions,
                  textColor: ColorUtils.appColorWhite,
                  fontSize: SizeUtils.textSizeSMedium,
                  fontWeight: FontWeight.w400,
                  isCentered: true,
                  maxLine: 3),
              const SizedBox(height: 15,),
              RoundButton(
                isStroked: false,
                textContent: widget.buttonText,
                textSize: SizeUtils.textSizeMedium,
                textColor: ColorUtils.appColorMain,
                radius: 5,
                onPressed: (){
                  if(widget.onClickConfirm != null) {
                    widget.onClickConfirm!();
                  }
                  finishView(context);
                }),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  color: ColorUtils.appColorTransparent,
                  child: textViewUnderline(
                    StringUtils.txtCancel,
                    textColor: ColorUtils.appColorWhite,
                    fontSize: SizeUtils.textSizeSMedium,
                    fontWeight: FontWeight.w400,
                    isCentered: false),
                ),
                onTap: () {
                  finishView(context);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
