// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../utils/spacer.dart';
import '../widgets/myButton.dart';
import '../widgets/myTextfield.dart';

class RegisterPage extends StatelessWidget {
  final void Function() onTap;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  RegisterPage({
    super.key,
    required this.onTap,
  });

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
              "Let's create an account for you!",
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
            verticalSpace(10),
            Mytextfield(
              hintText: 'Confirm password',
              controller: cpasswordController,
              obscureText: true,
            ),
            verticalSpace(25),
            const Mybutton(text: 'Register'),
            verticalSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    )),
                GestureDetector(
                  onTap: onTap,
                  child: Text('  Login now',
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
