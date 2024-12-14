import 'package:dartz/dartz.dart';
import 'package:new_shorts_app/Features/profile_feature.dart/domain/repo/user_profile_videos_repo.dart';
import 'package:new_shorts_app/Features/videos_feature/domain/video_entity/video_entity.dart';
import 'package:new_shorts_app/core/managers/error_manager/failure.dart';

class UserProfileVideosUseCase {
  final UserProfileRepo repository;

  UserProfileVideosUseCase({required this.repository});

  Future<Either<Failure, List<VideoEntity>>> call({
    required String userId,
  }) async {
    return await repository.getUserVideos(
      userId: userId,
    );
  }
}
