// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/domain.dart' as _i494;
import 'package:domain/src/usecase/get_messages_usecase.dart' as _i143;
import 'package:domain/src/usecase/send_message_usecase.dart' as _i587;
import 'package:flutter_chat_app/src/chat_page/bloc/chat_bloc.dart' as _i425;
import 'package:flutter_chat_app/src/home_screen/bloc/home_bloc.dart' as _i972;
import 'package:flutter_chat_app/src/login_screen/bloc/login_bloc.dart'
    as _i884;
import 'package:flutter_chat_app/src/sign_up_screen/bloc/sign_up_bloc.dart'
    as _i137;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i884.LoginBloc>(
      () => _i884.LoginBloc(gh<_i494.SignInUseCase>()),
    );
    gh.factory<_i972.HomeBloc>(
      () => _i972.HomeBloc(
        gh<_i494.GetUsersUseCase>(),
        gh<_i494.UserSignOutUseCase>(),
        gh<_i494.CurrentUserUsecase>(),
      ),
    );
    gh.factory<_i425.ChatBloc>(
      () => _i425.ChatBloc(
        sendMessageUsecase: gh<_i587.SendMessageUsecase>(),
        getMessagesUsecase: gh<_i143.GetMessagesUsecase>(),
      ),
    );
    gh.factory<_i137.SignUpBloc>(
      () => _i137.SignUpBloc(gh<_i494.SignUpUseCase>()),
    );
    return this;
  }
}
