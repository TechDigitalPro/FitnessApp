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
    required this.onStartClick,
    required this.onItemClick,
    required this.isSelected,
  });

  final PlanModel model;
  final Function onStartClick;
  final Function onItemClick;
  bool isSelected = false;

  @override
  ItemPlanViewState createState() => ItemPlanViewState();
}

class ItemPlanViewState extends State<ItemPlanView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onItemClick();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: ItemGlassCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: textView(widget.model.name,
                              textColor: ColorUtils.appColorWhite,
                              fontSize: SizeUtils.textSizeNormal,
                              fontWeight: FontWeight.bold,
                              isCentered: false,
                              maxLine: 5),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        widget.model.description == null
                            ? Container()
                            : Container(
                                child: textView(
                                  widget.model.description,
                                  textColor: ColorUtils.appColorWhite_80,
                                  fontSize: SizeUtils.textSizeSMedium,
                                  maxLine: 5,
                                ),
                              ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                          child: RoundButton(
                              backgroundColor: widget.isSelected
                                  ? ColorUtils.appColorWhite_80
                                  : ColorUtils.appColorAccent,
                              isStroked: false,
                              textContent: widget.isSelected
                                  ? StringUtils.txtCurrentPlan
                                  : StringUtils.txtStart,
                              textSize: SizeUtils.textSizeSMedium,
                              textColor: ColorUtils.appColorPrimary,
                              radius: 5,
                              onPressed: () {
                                widget.onStartClick();
                              }),
                        ),
                      ],
                    )
                  ),
              ],
            ),
          ),
        ));
  }
}
