import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

abstract class UserRepository {
  Stream<Either<BaseError, List<UserDataModel>>> getAllUsers();
}
