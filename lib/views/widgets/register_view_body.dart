
import 'package:chatapp/views/widgets/register_form.dart';
import 'package:flutter/material.dart';

import 'already_have_an_account.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
            ),
            child: Image.asset(
              'assets/images/logo.png',
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const RegisterForm(),
          const SizedBox(
            height: 32,
          ),
          AuthAuthenticationOption(
            action: 'Login',
            text: 'Already have an account?',
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
