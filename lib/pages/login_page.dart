// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/utils/spacer.dart';
import 'package:chat_app/widgets/my_button.dart';
import 'package:chat_app/widgets/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final void Function() onTap;

  LoginPage({
    super.key,
    required this.onTap,
  });

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login(context) async {
    final authService = AuthService();
    authService.signIn(emailController.text, passwordController.text, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat,
              color: Theme.of(context).colorScheme.primary,
              size: 60,
            ),
            verticalSpace(30),
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            verticalSpace(30),
            Mytextfield(hintText: 'Email', controller: emailController),
            verticalSpace(10),
            Mytextfield(
              hintText: 'Password',
              controller: passwordController,
              obscureText: true,
            ),
            verticalSpace(25),
            Mybutton(
              text: 'Login',
              onTap: () => login(context),
            ),
            verticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                GestureDetector(
                  onTap: onTap,
                  child: Text('  Register now',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
