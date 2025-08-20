import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/util/request_controller.dart';
import 'package:fluttertoast/fluttertoast.dart' show Fluttertoast;
import 'package:injectable/injectable.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> with RequestController {
  SignUpBloc(this.signUpUseCase) : super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) {});
  }

  void registration(void Function() onSuccess) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    print('email $email password $password');
    if (email.isNotEmpty && password.isNotEmpty) {
      getDataWithPramas<UserDataModel>(
        signUpUseCase,
        params: SignUpParams(
          username: email,
          password: password,
          name: phoneController.text.trim(),
        ),
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

  final SignUpUseCase signUpUseCase;

  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final cnfrmpassController = TextEditingController();
}
