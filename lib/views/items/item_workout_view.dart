import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../model/common/workout_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/widget_utils.dart';
import 'item_glass_card.dart';

class ItemWorkoutView extends StatefulWidget {
  const ItemWorkoutView({
    super.key,
    required this.model,
    required this.onClick,
  });

  final WorkoutModel model;
  final Function onClick;

  @override
  ItemWorkoutViewState createState() => ItemWorkoutViewState();
}

class ItemWorkoutViewState extends State<ItemWorkoutView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget image = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: widget.model.imageUrl == null ? Container()
      : widget.model.imageUrl!.contains('http') || widget.model.imageUrl!.contains('https') 
      ? CachedNetworkImage(
          imageUrl: widget.model.imageUrl!,
          width: width,
          height: width * 9 / 16,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )
      : Image.asset(widget.model.imageUrl!,
        width: width,
        height: width * 9 / 16,
        fit: BoxFit.cover,
      ),
    );
    
    return GestureDetector(
        onTap: () {
          widget.onClick();
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: ItemGlassCard(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget.model.videoUrl == null ? Container() :
                  Stack(
                    children: [
                      SizedBox(
                        height: width * 9 / 16,
                        child: image,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
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
                          fontSize: SizeUtils.textSizeMedium,
                          fontWeight: FontWeight.bold,
                          isCentered: false,
                          maxLine: 5),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      widget.model.description == null ? Container() :
                      Container(
                        child: textViewHtml(
                          widget.model.description,
                          textColor: ColorUtils.appColorWhite_80,
                          fontSize: SizeUtils.textSizeSMedium,),
                      )
                    ],
                  )),
                ],
              ),
          ),
        ));
  }
}
