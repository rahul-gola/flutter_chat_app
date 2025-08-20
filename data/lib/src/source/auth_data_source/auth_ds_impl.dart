import 'package:dartz/dartz.dart';
import 'package:data/src/network/firebase_service.dart';
import 'package:data/src/source/auth_data_source/auth_ds.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthDataSource)
class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl(this._retrofitService);

  final FirebaseService _retrofitService;

  @override
  Future<Either<BaseError, UserDataModel>> getUserSignIn(
    String username,
    String password,
  ) async {
    return await _retrofitService.getUserSignIn(username, password);
  }

  @override
  Future<Either<BaseError, UserDataModel>> getUserSignUp(
    String username,
    String password,
    String name,
  ) async {
    return await _retrofitService.getUserSignUp(username, password, name);
  }
}
