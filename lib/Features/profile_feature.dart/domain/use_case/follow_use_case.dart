import 'package:dartz/dartz.dart';
import 'package:new_shorts_app/Features/profile_feature.dart/domain/repo/user_profile_videos_repo.dart';
import 'package:new_shorts_app/core/managers/error_manager/failure.dart';
import 'package:new_shorts_app/core/user_info/domain/user_entity/user_entity.dart';

class ToggleFollowUserUseCase {
  final UserProfileRepo repository;

  ToggleFollowUserUseCase({required this.repository});

  Future<Either<Failure, UserEntity>> call({
    required String currentUserId,
    required String targetUserId,
  }) async {
    return await repository.toggleFollow(
      currentUserId: currentUserId,
      targetUserId: targetUserId,
    );
  }
}
