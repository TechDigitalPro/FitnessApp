import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../model/common/news_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/widget_utils.dart';
import 'item_glass_card.dart';

class ItemNewsView extends StatefulWidget {
  const ItemNewsView({
    super.key,
    required this.model,
    required this.onClick,
  });

  final NewsModel model;
  final Function onClick;

  @override
  ItemNewsViewState createState() => ItemNewsViewState();
}

class ItemNewsViewState extends State<ItemNewsView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    Widget image = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
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
          padding: const EdgeInsets.all(10),
          child: ItemGlassCard(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  widget.model.imageUrl == null ? Container() :
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
                          widget.model.title,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeNormal,
                          fontWeight: FontWeight.bold,
                          isCentered: false,
                          maxLine: 2),
                      ),
                      const SizedBox(height: 10,),
                      widget.model.content == null ? Container() :
                      Container(
                        child: textViewHtml(
                          widget.model.content,
                          textColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeMedium,),
                      ),
                      const SizedBox(height: 10,),
                      
                    ],
                  )),
                ],
              ),
          ),
        ));
  }
}
