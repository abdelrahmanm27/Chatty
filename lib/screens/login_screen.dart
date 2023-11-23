// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/widgets/chatty_navigate_to.dart';
import 'package:chat_app/widgets/chatty_material_button.dart';
import 'package:chat_app/widgets/chatty_snackbar.dart';
import 'package:chat_app/widgets/chatty_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                ),
                Image.asset(
                  appLogo,
                  height: 90,
                  width: 90,
                ),
                Text(
                  'Chatty',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 35,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                ChattyTextFormField(
                  labelText: 'Email',
                  hintText: 'Your email..',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) {
                    email = val;
                  },
                ),
                ChattyTextFormField(
                  labelText: 'Password',
                  hintText: 'Your password..',
                  isPassword: true,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (val) {
                    password = val;
                  },
                ),
                ChattyMaterialButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await loginUser();
                        chattyNavigateTo(
                          context,
                          ChatScreen(email: email!),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          chattySnackbar(
                              context, 'No user found for that email !');
                        } else if (e.code == 'wrong-password') {
                          chattySnackbar(context,
                              'Wrong password provided for that user !');
                        }
                      } catch (e) {
                        chattySnackbar(context, e.toString());
                      }
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  buttonText: 'Sign In',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        chattyNavigateTo(context, RegisterScreen());
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xff83C0F3),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
    print(userCredential.user!.displayName);
  }
}
