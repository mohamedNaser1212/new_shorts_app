import 'package:flutter/material.dart';
import 'package:new_shorts_app/core/widgets/custom_app_bar.dart';

class VideosScreenAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const VideosScreenAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(
      title: 'Videos',
      backColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
