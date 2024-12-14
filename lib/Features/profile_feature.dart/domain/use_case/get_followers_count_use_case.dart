import 'package:dartz/dartz.dart';
import 'package:new_shorts_app/Features/profile_feature.dart/domain/repo/user_profile_videos_repo.dart';
import 'package:new_shorts_app/core/managers/error_manager/failure.dart';

class GetFollowersCountUseCase {
  final UserProfileRepo repository;

  GetFollowersCountUseCase({required this.repository});

  Future<Either<Failure, int>> call({
    required String userId,
  }) async {
    return await repository.getFollowersCount(userId: userId);
  }
}
