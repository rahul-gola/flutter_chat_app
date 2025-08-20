import 'package:data/src/source/auth_data_source/auth_ds.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:dartz/dartz.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.articleDataSource});

  final AuthDataSource articleDataSource;

  @override
  Future<Either<BaseError, UserDataModel>> getUserSignIn(
    String username,
    String password,
  ) {
    return articleDataSource.getUserSignIn(username, password);
  }

  @override
  Future<Either<BaseError, UserDataModel>> getUserSignUp(
    String username,
    String password,
    String name,
  ) {
    return articleDataSource.getUserSignUp(username, password, name);
  }
}
