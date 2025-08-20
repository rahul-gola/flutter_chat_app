import 'package:dartz/dartz.dart';
import 'package:domain/src/model/error/base_error.dart';
import 'package:domain/src/model/user_data.dart';
import 'package:domain/src/repository/auth/auth_repository.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';
import 'package:domain/src/usecase/base/params.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase extends BaseUseCase<SignInParams, UserDataModel> {
  SignInUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<BaseError, UserDataModel>> execute(
    SignInParams params,
  ) {
    return _authRepository.getUserSignIn(params.username, params.password);
  }
}

class SignInParams extends Params {
  SignInParams({required this.username, required this.password});

  final String username;
  final String password;
}
