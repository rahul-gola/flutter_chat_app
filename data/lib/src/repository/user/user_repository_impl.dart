import 'package:dartz/dartz.dart';
import 'package:data/src/source/user_data_source/user_ds.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required this.userDataSource});

  final UserDataSource userDataSource;

  @override
  Stream<Either<BaseError, List<UserDataModel>>> getAllUsers() {
    return userDataSource.getAllUsers();
  }

  @override
  Future<Either<BaseError, UserDataModel>> getCurrentUserName() {
    return userDataSource.getCurrentUserName();
  }

  @override
  Future<Either<BaseError, bool>> signOutUser() {
    return userDataSource.signOutUser();
  }
}
