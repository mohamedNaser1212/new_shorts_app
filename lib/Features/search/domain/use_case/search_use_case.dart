import 'package:dartz/dartz.dart';
import 'package:new_shorts_app/core/managers/error_manager/failure.dart';
import 'package:new_shorts_app/core/user_info/domain/user_entity/user_entity.dart';

import '../repo/search_repo.dart';

class SearchUseCase {
  final SearchRepo searchRepo;

  SearchUseCase({
    required this.searchRepo,
  });

  Future<Either<Failure, List<UserEntity>>> call({
    required String search,
    required int page,
  }) async {
    return await searchRepo.search(query: search, page: page);
  }
}
