import 'package:dartz/dartz.dart';
import 'package:new_shorts_app/Features/comments_feature/domain/ccommeints_repo/comments_repo.dart';

import '../../../../core/managers/error_manager/failure.dart';

class GetCommentsCountUseCase {
  final CommentsRepo commentsRepo;

  GetCommentsCountUseCase({required this.commentsRepo});

  Future<Either<Failure, num>> getCommentsCount({
    required String videoId,
  }) async {
    return await commentsRepo.getCommentsCount(videoId: videoId);
  }
}
