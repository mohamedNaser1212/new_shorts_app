import 'package:dartz/dartz.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../repo/user_profile_videos_repo.dart';

class IsUserFollowedUseCase {
  final UserProfileRepo repository;

  IsUserFollowedUseCase({required this.repository});

  Future<Either<Failure, bool>> isUserFollowed({
    required String currentUserId,
    required String targetUserId,
  }) async {
    return await repository.isUserFollowed(
      currentUserId: currentUserId,
      targetUserId: targetUserId,
    );
  }
}
