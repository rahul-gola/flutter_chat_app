import 'package:dartz/dartz.dart';
import 'package:data/src/network/firebase_service.dart';
import 'package:data/src/source/user_data_source/user_ds.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UserDataSource)
class UserDataSourceImpl implements UserDataSource {
  UserDataSourceImpl(this._retrofitService);

  final FirebaseService _retrofitService;

  @override
  Stream<Either<BaseError, List<UserDataModel>>> getAllUsers() {
    return _retrofitService.getAllUsers();
  }
}
