import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nxtlvl_app/utils/image_utils.dart';
import 'package:video_thumbnail_imageview/video_thumbnail_imageview.dart';
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
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: widget.model.videoUrl == null ? Container()
      : widget.model.videoUrl!.contains('http') || widget.model.videoUrl!.contains('https') 
      ? VTImageView(
          videoUrl: widget.model.videoUrl!,
          width: width,
          height: width * 9 / 16,
          fit: BoxFit.cover,
          errorBuilder: (context, url, error) => const Icon(Icons.error), 
          assetPlaceHolder: ImageUtils.imgIcLogoIconWhite,
        )
      : Image.asset(widget.model.videoUrl!,
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
          padding: const EdgeInsets.all(10),
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
                          fontSize: SizeUtils.textSizeNormal,
                          fontWeight: FontWeight.bold,
                          isCentered: false,
                          maxLine: 5),
                      ),
                      widget.model.description == null ? Container() :
                      Container(
                        child: textViewHtml(
                          widget.model.description,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeMedium,),
                      )
                    ],
                  )),
                ],
              ),
          ),
        ));
  }
}
