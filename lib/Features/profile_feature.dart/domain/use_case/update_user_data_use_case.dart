import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:new_shorts_app/Features/profile_feature.dart/domain/repo/update_user_data_repo.dart';
import 'package:new_shorts_app/core/managers/error_manager/failure.dart';
import 'package:new_shorts_app/core/user_info/domain/user_entity/user_entity.dart';

import '../models/update_request_model.dart';

class UpdateUserDataUseCase {
  final UpdateUserDataRepo updateRepo;

  UpdateUserDataUseCase({required this.updateRepo});

  Future<Either<Failure, UserEntity>> call({
    required UpdateUserRequestModel updateUserRequestModel,
    required String userId,
    required File imageFile,
  }) async {
    return await updateRepo.updateUserData(
      updateUserRequestModel: updateUserRequestModel,
      userId: userId,
      imageFile: imageFile,
    );
  }
}
