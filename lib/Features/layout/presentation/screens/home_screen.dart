import 'package:flutter/material.dart';
import 'package:new_shorts_app/Features/layout/presentation/widgets/home_screen_body.dart';
import 'package:new_shorts_app/core/user_info/domain/user_entity/user_entity.dart';
import 'package:new_shorts_app/core/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.currentUser});
  final UserEntity currentUser;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Shorts',
        showLeadingIcon: false,
      ),
      body: HomeScreenBody(),
    );
  }
}
