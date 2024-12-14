import 'package:dartz/dartz.dart';
import 'package:new_shorts_app/Features/videos_feature/domain/video_entity/video_entity.dart';

import '../../../../core/managers/error_manager/failure.dart';
import '../../../../core/user_info/domain/user_entity/user_entity.dart';
import '../favourites_entity/favourite_entitiy.dart';

abstract class FavouritesRepo {
  Future<Either<Failure, List<FavouritesEntity>>> getFavouriteVideos({
    required UserEntity user,
  });
  Future<Either<Failure, bool>> toggleFavouriteVideo({
    required VideoEntity videoEntity,
    required UserEntity userModel,
  });
  Future<Either<Failure, num>> getFavouritesCount({
    required String videoId,
  });
}
