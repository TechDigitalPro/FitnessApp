import 'package:flutter/material.dart';
import '../../model/common/plan_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import 'item_glass_card.dart';

// ignore: must_be_immutable
class ItemPlanView extends StatefulWidget {
  ItemPlanView({
    super.key,
    required this.model,
    required this.onClick,
    required this.isSelected,
  });

  final PlanModel model;
  final Function onClick;
  bool isSelected = false;

  @override
  ItemPlanViewState createState() => ItemPlanViewState();
}

class ItemPlanViewState extends State<ItemPlanView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () {
          
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ItemGlassCard(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width,
                        child: textView(
                          widget.model.name,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeNormal,
                          fontWeight: FontWeight.bold,
                          isCentered: false,
                          maxLine: 5),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      widget.model.description == null ? Container() :
                      Container(
                        child: textViewHtml(
                          widget.model.description,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeSmall,),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(
                            5, 15, 5, 15),
                        child: RoundButton(
                            backgroundColor: 
                            widget.isSelected ?
                            ColorUtils.appColorWhite_80 : ColorUtils.appColorAccent,
                            isStroked: false,
                            textContent: 
                            widget.isSelected ?
                            StringUtils.txtCurrentPlan : StringUtils.txtStart,
                            textSize: SizeUtils.textSizeMedium,
                            textColor: ColorUtils.appColorPrimary,
                            radius: 5,
                            onPressed: () {
                              widget.onClick();
                            }),
                      ),
                    ],
                  )),
                ],
              ),
          ),
        ));
  }
}
