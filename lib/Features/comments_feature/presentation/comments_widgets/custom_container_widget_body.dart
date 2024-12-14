import 'package:flutter/material.dart';
import 'package:new_shorts_app/Features/comments_feature/domain/comments_entity/comments_entity.dart';
import 'package:new_shorts_app/Features/comments_feature/presentation/comments_widgets/user_name_and_date_widgets.dart';
import 'package:new_shorts_app/core/managers/styles_manager/color_manager.dart';
import 'package:new_shorts_app/core/widgets/custom_read_more_widget.dart';

class CustomAddMoreContainerWidgetbody extends StatelessWidget {
  const CustomAddMoreContainerWidgetbody({
    super.key,
    required this.comment,
  });

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserNameAndDateWidgets(
            comment: comment,
          ),
          const SizedBox(height: 16), // Adjusted spacing
          CustomReadMoreWidget(
            text: comment.content,
            style: const TextStyle(
              fontSize: 16,
              color: ColorController.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
