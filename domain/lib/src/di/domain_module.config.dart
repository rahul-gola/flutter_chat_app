// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/src/repository/auth/auth_repository.dart' as _i609;
import 'package:domain/src/repository/chat_repository.dart' as _i747;
import 'package:domain/src/repository/user/user_repository.dart' as _i498;
import 'package:domain/src/usecase/current_user_usecase.dart' as _i688;
import 'package:domain/src/usecase/get_messages_usecase.dart' as _i143;
import 'package:domain/src/usecase/get_users_usecase.dart' as _i179;
import 'package:domain/src/usecase/send_message_usecase.dart' as _i587;
import 'package:domain/src/usecase/sign_in/sign_in_usecase.dart' as _i12;
import 'package:domain/src/usecase/sign_up/sign_up_usecase.dart' as _i388;
import 'package:domain/src/usecase/user_sign_out_usecase.dart' as _i876;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initDomainModule({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i688.CurrentUserUsecase>(
        () => _i688.CurrentUserUsecase(gh<_i498.UserRepository>()));
    gh.factory<_i179.GetUsersUseCase>(
        () => _i179.GetUsersUseCase(gh<_i498.UserRepository>()));
    gh.factory<_i876.UserSignOutUseCase>(
        () => _i876.UserSignOutUseCase(gh<_i498.UserRepository>()));
    gh.factory<_i587.SendMessageUsecase>(
        () => _i587.SendMessageUsecase(gh<_i747.ChatRepository>()));
    gh.factory<_i12.SignInUseCase>(
        () => _i12.SignInUseCase(gh<_i609.AuthRepository>()));
    gh.factory<_i388.SignUpUseCase>(
        () => _i388.SignUpUseCase(gh<_i609.AuthRepository>()));
    gh.factory<_i143.GetMessagesUsecase>(
        () => _i143.GetMessagesUsecase(repository: gh<_i747.ChatRepository>()));
    return this;
  }
}
