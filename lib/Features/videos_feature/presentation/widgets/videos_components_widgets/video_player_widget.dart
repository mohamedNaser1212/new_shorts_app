import 'package:flutter/material.dart';
import 'package:new_shorts_app/core/video_controller/video_controller.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({
    super.key,
    required this.videoProvider,
  });

  final VideoController videoProvider;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.fill,
        child: SizedBox(
          width: videoProvider.controller!.value.size.width,
          height: videoProvider.controller!.value.size.height * 2.9,
          child: VideoPlayer(videoProvider.controller!),
        ),
      ),
    );
  }
}
