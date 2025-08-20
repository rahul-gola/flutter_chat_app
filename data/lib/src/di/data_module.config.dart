// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:data/src/network/firebase_service.dart' as _i36;
import 'package:data/src/repository/auth_repository/auth_repository_impl.dart'
    as _i831;
import 'package:data/src/repository/user/user_repository_impl.dart' as _i931;
import 'package:data/src/source/auth_data_source/auth_ds.dart' as _i1059;
import 'package:data/src/source/auth_data_source/auth_ds_impl.dart' as _i894;
import 'package:data/src/source/user_data_source/user_ds.dart' as _i134;
import 'package:data/src/source/user_data_source/user_ds_impl.dart' as _i435;
import 'package:domain/domain.dart' as _i494;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initDataModule({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i36.FirebaseService>(() => _i36.FirebaseService());
    gh.factory<_i134.UserDataSource>(
        () => _i435.UserDataSourceImpl(gh<_i36.FirebaseService>()));
    gh.factory<_i1059.AuthDataSource>(
        () => _i894.AuthDataSourceImpl(gh<_i36.FirebaseService>()));
    gh.factory<_i494.AuthRepository>(() => _i831.AuthRepositoryImpl(
        articleDataSource: gh<_i1059.AuthDataSource>()));
    gh.factory<_i494.UserRepository>(() =>
        _i931.UserRepositoryImpl(userDataSource: gh<_i134.UserDataSource>()));
    return this;
  }
}
