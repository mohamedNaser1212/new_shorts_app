import 'package:flutter/material.dart';
import 'package:new_shorts_app/Features/videos_feature/presentation/widgets/videos_uploading_widgets/thumbnail_page.dart';
import 'package:new_shorts_app/core/functions/navigations_functions.dart';
import 'package:new_shorts_app/core/video_controller/video_controller.dart';
import 'package:provider/provider.dart';

class VideoThumbnailWidget extends StatelessWidget {
  const VideoThumbnailWidget({super.key, this.videoPath});
  final String? videoPath;

  @override
  Widget build(BuildContext context) {
    if (videoPath == null) {
      return const SizedBox.shrink();
    }

    return ChangeNotifierProvider(
      create: (_) => VideoController(videoUrl: videoPath!),
      child: Consumer<VideoController>(
        builder: (context, videoController, child) {
          final thumbnail = videoController.thumbnail;
          return thumbnail != null
              ? GestureDetector(
                  onTap: () => _navigateToThumbnailPage(context),
                  child: Image.memory(
                    thumbnail,
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                )
              : const CircularProgressIndicator();
        },
      ),
    );
  }

  void _navigateToThumbnailPage(BuildContext context) {
    if (videoPath != null) {
      NavigationManager.navigateTo(
        context: context,
        screen: ThumbnailPage(videoPath: videoPath!),
      );
    }
  }
}
