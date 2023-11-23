// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'dart:async';

import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widgets/chatty_material_button.dart';
import 'package:chat_app/widgets/chatty_navigate_to.dart';
import 'package:chat_app/widgets/chatty_snackbar.dart';
import 'package:chat_app/widgets/chatty_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          title: Text('Register'),
          centerTitle: true,
        ),
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                SizedBox(
                  height: 3,
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
                        await registerUser();
                        chattySnackbar(
                            context, 'Account created successfully !');
                        chattyNavigateTo(
                          context,
                          ChatScreen(
                            email: email!,
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          chattySnackbar(
                              context, 'Password is weak or too short !');
                        } else if (e.code == 'email-already-in-use') {
                          chattySnackbar(context,
                              'This email already in use by another account !');
                        }
                      } catch (e) {
                        chattySnackbar(context, e.toString());
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  buttonText: 'Create Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    print(userCredential.user!.displayName);
  }
}
