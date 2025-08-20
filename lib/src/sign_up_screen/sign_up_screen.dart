import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/base/base_widget/stateless/base_stateless_widget.dart';
import 'package:flutter_chat_app/core/di/di.dart';
import 'package:flutter_chat_app/src/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:flutter_chat_app/src/widgets/custom_text_button.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends BaseStatelessWidget<SignUpBloc> {
  const SignUpScreen({super.key});

  @override
  SignUpBloc get bloc => getIt<SignUpBloc>();

  @override
  Widget buildView(BuildContext context, SignUpBloc model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', width: 60, height: 40),
                const SizedBox(width: 8),
                Image.asset('assets/ping.png', width: 60, height: 40),
              ],
            ),
            const SizedBox(height: 45),
            TextFormField(
              controller: model.emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email'),
            ),

            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: model.phoneController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: model.passwordController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              controller: model.cnfrmpassController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
            ),
            const SizedBox(height: 35),
            CustomTextButton(
              height: 45,
              width: MediaQuery.of(context).size.width - 150,
              radius: 10,
              onPressed: () {
                model.registration(() {
                  Navigator.pop(context);
                });
              },
              child: Text(
                'Sign up',
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
                    'Already have an account? ',
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign in',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return AppBar(
      leading: const BackButton(color: Colors.black),
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
    );
  }
}
