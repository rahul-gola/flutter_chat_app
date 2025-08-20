import 'package:dartz/dartz.dart';
import 'package:domain/src/model/error/base_error.dart';
import 'package:domain/src/model/user_data.dart';
import 'package:domain/src/repository/auth/auth_repository.dart';
import 'package:domain/src/repository/user/user_repository.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';
import 'package:domain/src/usecase/base/params.dart';
import 'package:domain/src/usecase/sign_up/sign_up_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUsersUseCase extends BaseUsesCaseNoParams<List<UserDataModel>> {
  GetUsersUseCase(this._userRepository);

  final UserRepository _userRepository;

  @override
  Stream<Either<BaseError, List<UserDataModel>>> execute() {
    return _userRepository.getAllUsers();
  }
}
