import 'package:dartz/dartz.dart';
import 'package:domain/src/model/error/base_error.dart';
import 'package:domain/src/model/user_data.dart';
import 'package:domain/src/repository/auth/auth_repository.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';
import 'package:domain/src/usecase/base/params.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUseCase extends BaseUseCase<SignUpParams, UserDataModel> {
  SignUpUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<Either<BaseError, UserDataModel>> execute(
    SignUpParams params,
  ) {
    return _authRepository.getUserSignUp(
      params.username,
      params.password,
      params.name,
    );
  }
}

class SignUpParams extends Params {
  SignUpParams({
    required this.username,
    required this.password,
    required this.name,
  });

  final String username;
  final String password;
  final String name;
}
