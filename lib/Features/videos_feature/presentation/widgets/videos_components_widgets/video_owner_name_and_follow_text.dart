import 'package:flutter/material.dart';
import 'package:new_shorts_app/Features/profile_feature.dart/presentation/screens/user_profile_screen.dart';
import 'package:new_shorts_app/Features/videos_feature/presentation/widgets/videos_components_widgets/video_contents_screen.dart';
import 'package:new_shorts_app/core/functions/navigations_functions.dart';
import 'package:new_shorts_app/core/managers/styles_manager/color_manager.dart';
import 'package:new_shorts_app/core/widgets/custom_title.dart';

class VideoOwnerNameWidget extends StatelessWidget {
  const VideoOwnerNameWidget({
    super.key,
    required this.userName,
    required this.state,
  });

  final String userName;
  final VideoContentsScreenState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => _onTap(context: context, state: state),
          child: CustomTitle(
            title: userName,
            style: TitleStyle.style16,
            color: ColorController.whiteColor,
          ),
        ),
        // const SizedBox(width: 10),
        // const FollowTextWidget(),
      ],
    );
  }

  void _onTap({
    required BuildContext context,
    required VideoContentsScreenState state,
  }) {
    NavigationManager.navigateTo(
      context: context,
      screen: UserProfileScreen(
        user: state.widget.videoEntity.user,
        // videoEntity: state.widget.videoEntity,
        // isShared: false,
      ),
    );
  }
}
