import 'package:flutter/material.dart';
import 'package:new_shorts_app/core/widgets/custom_icon_widget.dart';

class PauseIconWidget extends StatelessWidget {
  const PauseIconWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomIconWidget(
      icon: Icons.pause,
    );
  }
}
