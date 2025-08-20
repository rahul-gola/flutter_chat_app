import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_app/core/util/request_controller.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';

part 'login_state.dart';

@Injectable()
class LoginBloc extends Bloc<LoginEvent, LoginState> with RequestController {
  LoginBloc(this.signInUseCase) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
  }

  final SignInUseCase signInUseCase;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(void Function() onSuccess) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      getDataWithPramas<UserDataModel>(
        signInUseCase,
        params: SignInParams(username: email, password: password),
        onSuccess: (s) {
          onSuccess();
        },
        onFailure: (e) {
          print('Success  e ${e.message}');
        },
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Email / Password cannot be empty',
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
    }
  }

  @override
  void mapEventToState() {
    // TODO: implement mapEventToState
  }
}
