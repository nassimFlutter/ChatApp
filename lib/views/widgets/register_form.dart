import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'avatars_list.dart';
import 'custom_button.dart';
import 'custom_text_form_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode,
      child: Column(
        children: [
          CustomTextFormField(
            controller: nameController,
            onchange: (p0) {
              nameController.text = p0;
            },
            hintText: 'Enter your name',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            controller: emailController,
            onchange: (p0) {
              emailController.text = p0;
            },
            hintText: 'Enter your email',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            controller: passwordController,
            onchange: (p0) {
              passwordController.text = p0;
            },
            hintText: 'Enter your password',
          ),
          const SizedBox(
            height: 16,
          ),
          const AvatarListWidget(),
          const SizedBox(
            height: 32,
          ),
          CustomButton(
            onPressed: () async {
              print(emailController.text);
              print(passwordController.text);
              if (_formKey.currentState!.validate()) {
                try {
                  UserCredential user = await registerMethod();
                  await auth.currentUser?.sendEmailVerification();
                  // Future<void> sendEmailVerification() async {
                  //   User? user = FirebaseAuth.instance.currentUser;

                  //   try {
                  //     if (user != null && !user.emailVerified) {
                  //       await user.sendEmailVerification();
                  //       print(user.emailVerified);
                  //       // Verification email sent.
                  //     } else {
                  //       // User is either already verified or not signed in.
                  //     }
                  //   } catch (e) {
                  //     print("Error sending email verification: $e");
                  //   }
                  // }

                  // ignore: use_build_context_synchronously
                  showSanckBar(context);
                  if (kDebugMode) {
                    print(user.additionalUserInfo);
                    print(user.user?.displayName);
                  }
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.code.toString())));
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                } catch (e) {
                  print(e);
                }
              } else {
                setState(() {
                  _autoValidateMode = AutovalidateMode.always;
                });
              }
            },
            text: 'Login',
          ),
        ],
      ),
    );
  }

  void showSanckBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Ok"),
      backgroundColor: Colors.cyanAccent,
    ));
  }

  Future<UserCredential> registerMethod() async {
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    return user;
  }
}
