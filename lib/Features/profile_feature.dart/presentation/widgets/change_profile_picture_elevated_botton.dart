import 'package:flutter/material.dart';
import 'package:new_shorts_app/Features/profile_feature.dart/presentation/screens/edit_profile_screen.dart';
import 'package:new_shorts_app/core/widgets/custom_elevated_botton.dart';

class ChangeProfilePictureElevatedBotton extends StatelessWidget {
  const ChangeProfilePictureElevatedBotton(
      {super.key, required this.editState});
  final EditProfileScreenState editState;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton.editProfileImagePickerButton(
      context: context,
      editState: editState,
    );
  }
}
