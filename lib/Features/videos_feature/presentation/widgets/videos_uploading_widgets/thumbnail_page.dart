import 'package:flutter/material.dart';
import 'package:new_shorts_app/Features/videos_feature/presentation/widgets/videos_components_widgets/video_preview_icon_widget.dart';
import 'package:new_shorts_app/core/video_controller/video_controller.dart';
import 'package:new_shorts_app/core/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class ThumbnailPage extends StatelessWidget {
  final String videoPath;

  const ThumbnailPage({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoController(videoUrl: videoPath),
      child: Consumer<VideoController>(
        builder: (context, videoController, child) {
          final controller = videoController.controller;

          return Scaffold(
            appBar: const CustomAppBar(title: 'Video Preview'),
            body: Center(
              child: controller != null && controller.value.isInitialized
                  ? VideoPreviewIconWidget(
                      controller: controller,
                      togglePlayPause: videoController.togglePlayPause,
                    )
                  : const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
