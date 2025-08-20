import 'package:dartz/dartz.dart';
import 'package:domain/src/model/error/base_error.dart';
import 'package:domain/src/model/user_data.dart';

abstract class AuthRepository {
  Future<Either<BaseError, UserDataModel>> getUserSignIn(
    String username,
    String password,
  );

  Future<Either<BaseError, UserDataModel>> getUserSignUp(
    String username,
    String password,
    String name,
  );
}
