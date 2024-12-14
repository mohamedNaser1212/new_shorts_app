import 'package:flutter/material.dart';
import 'package:new_shorts_app/core/widgets/custom_elevated_botton.dart';

class VideoPageElevatedButton extends StatelessWidget {
  const VideoPageElevatedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.videoPageButton(context: context);
  }
}