import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_shorts_app/Features/videos_feature/presentation/widgets/videos_uploading_widgets/preview_Screen_body.dart';
import 'package:new_shorts_app/Features/videos_feature/presentation/widgets/videos_uploading_widgets/video_player_screen.dart';
import 'package:new_shorts_app/core/functions/navigations_functions.dart';
import 'package:video_player/video_player.dart';

class ThumbnailPreviewWidget extends StatefulWidget {
  const ThumbnailPreviewWidget({
    super.key,
    required this.widget,
  });

  final PreviewScreeBody widget;

  @override
  State<ThumbnailPreviewWidget> createState() => _ThumbnailPreviewWidgetState();
}

class _ThumbnailPreviewWidgetState extends State<ThumbnailPreviewWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(
      File(widget.widget.thumbnailFile?.path ??
          widget.widget.previewState.widget.outputPath),
    )..initialize();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: InkWell(
        onTap: _onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            widget.widget.thumbnailFile != null &&
                    widget.widget.thumbnailFile!.existsSync()
                ? Image.file(
                    widget.widget.thumbnailFile!,
                    fit: BoxFit.cover,
                    height: 320,
                    width: 320,
                  )
                : const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                  ),
            if (widget.widget.thumbnailFile != null)
              const Icon(
                Icons.play_circle_fill,
                size: 60,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    if (widget.widget.thumbnailFile != null) {
      NavigationManager.navigateTo(
        context: context,
        screen: VideoPlayerScreen(
          videoPath: widget.widget.previewState.widget.outputPath,
        ),
      );
    }
  }
}
