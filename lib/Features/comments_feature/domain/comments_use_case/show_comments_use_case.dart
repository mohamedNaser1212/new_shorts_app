import 'package:dartz/dartz.dart';
import 'package:new_shorts_app/Features/comments_feature/domain/ccommeints_repo/comments_repo.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../comments_entity/comments_entity.dart';

class GetCommentsUseCase {
  final CommentsRepo commentsRepo;

  GetCommentsUseCase({required this.commentsRepo});

  Future<Either<Failure, List<CommentEntity>>> getVideoComments({
    required String videoId,
  }) async {
    return await commentsRepo.getVideoComments(
      videoId: videoId,
    );
  }
}
