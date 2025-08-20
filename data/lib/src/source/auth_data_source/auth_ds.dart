import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

abstract class AuthDataSource {
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
