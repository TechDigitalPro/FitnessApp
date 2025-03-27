import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../view_models/other/video_player_view_model.dart';
import 'package:video_player/video_player.dart';

import '../items/item_appbar_logo_h.dart';

// ignore: must_be_immutable
class VideoPlayerView extends StatefulWidget {
  VideoPlayerView({
    super.key,
    required this.url,
  });

  String url;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  VideoPlayerController? videoController;
  ChewieController? chewieController ;

  @override
  void initState() {
    super.initState();
    widget.url.contains('http') || widget.url.contains('https')
    ? videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url))
    : videoController = VideoPlayerController.asset(widget.url);

    videoController!.initialize().then((_) {
      chewieController = ChewieController(
          videoPlayerController: videoController!,
          autoPlay: true,
          looping: true,
          hideControlsTimer: const Duration(seconds: 3),
          fullScreenByDefault: false,
          showControlsOnInitialize: false,
      );

      setState(() {
        // chewieController!.enterFullScreen();
      });
    });
  }

  @override
  void dispose() {
    videoController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VideoPlayerViewModel>.reactive(
      viewModelBuilder: () => VideoPlayerViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context, widget.url),
    );
  }

  buildWidget(BuildContext context, VideoPlayerViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return PopScope(
      child: Scaffold(
        backgroundColor: ColorUtils.appColorPrimaryDark,
        body: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom,),
          child: Stack(children: <Widget>[
            Column(
              children: [
                  SizedBox(
                    height: height * 0.1,
                    width: width,
                  ),
                  Expanded(
                    child: Center(
                      child: chewieController != null && chewieController!.videoPlayerController.value.isInitialized
                      ? Chewie(
                          controller: chewieController!,
                        )
                      : SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: ColorUtils.appColorWhite,
                          ),
                      )
                    ),
                  ),
                ],
              ),
              SizedBox(
                  child: SizedBox(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ItemAppbarLogoH(
                          isLogo: true,
                          isCenter: false,
                          isTop: false,
                          title: StringUtils.txtWorkout,
                        ),
                        Positioned(
                            right: 0,
                            top: 30,
                            bottom: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      finishView(context);
                                    },
                                    icon: SvgPicture.asset(
                                      ImageUtils.imgIcBackCircle,
                                      colorFilter: ColorFilter.mode(
                                          ColorUtils.appColorWhite,
                                          BlendMode.srcIn),
                                      width: 24,
                                      height: 24,
                                    )),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ))
            ]),
          ),
        ),
    onPopInvokedWithResult: (isInvoke, result) {
      if(chewieController != null && chewieController!.isFullScreen){
        chewieController!.exitFullScreen();
      }
    });
  }
}
