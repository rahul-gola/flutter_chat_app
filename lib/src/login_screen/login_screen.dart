import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/base/base_widget/stateless/base_stateless_widget.dart';
import 'package:flutter_chat_app/core/di/di.dart';
import 'package:flutter_chat_app/src/home_screen/home_page.dart';
import 'package:flutter_chat_app/src/login_screen/bloc/login_bloc.dart';
import 'package:flutter_chat_app/src/sign_up_screen/sign_up_screen.dart';
import 'package:flutter_chat_app/src/widgets/custom_text_button.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends BaseStatelessWidget<LoginBloc> {
  const LoginScreen({super.key});

  @override
  LoginBloc get bloc => getIt<LoginBloc>();

  @override
  Widget buildView(BuildContext context, LoginBloc model) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 100),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/splash-logo.png',
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ],
              ),
              const SizedBox(height: 45),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: model.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                controller: model.passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 35),
              CustomTextButton(
                height: 45,
                width: MediaQuery.of(context).size.width - 150,
                radius: 10,
                onPressed: () {
                  model.login(() {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>  HomePage()),
                    );
                  });
                },
                child: Text(
                  'Log in',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign up',
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
