import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

abstract class UserDataSource {
  Stream<Either<BaseError, List<UserDataModel>>> getAllUsers();

  Future<Either<BaseError, UserDataModel>> getCurrentUserName();

  Future<Either<BaseError, bool>> signOutUser();
}
