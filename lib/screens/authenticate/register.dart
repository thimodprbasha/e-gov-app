import 'dart:convert';

import 'package:e_gov/service/authservice.dart';
import 'package:e_gov/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:e_gov/widgets/primary_button.dart';
import 'package:e_gov/widgets/custom_checkbox.dart';
import 'package:http/http.dart';
import '../../model/user.dart';
import '../theme.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;

  bool isLoarding = false;

  AuthenticationService _authenticationService = AuthenticationService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoarding) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register new\naccount',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/accent.png',
                      width: 99,
                      height: 4,
                    ),
                  ],
                ),
                SizedBox(
                  height: 48,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          obscureText: !passwordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: heading6.copyWith(color: textGrey),
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: togglePassword,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: passwordConfirmController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          obscureText: !passwordConfrimationVisible,
                          decoration: InputDecoration(
                            hintText: 'Password Confirmation',
                            hintStyle: heading6.copyWith(color: textGrey),
                            suffixIcon: IconButton(
                              color: textGrey,
                              splashRadius: 1,
                              icon: Icon(passwordConfrimationVisible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                              onPressed: () {
                                setState(() {
                                  passwordConfrimationVisible =
                                      !passwordConfrimationVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomCheckbox(),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'By creating an account, you agree to our',
                          style: regular16pt.copyWith(color: textGrey),
                        ),
                        Text(
                          'Terms & Conditions',
                          style: regular16pt.copyWith(color: primaryBlue),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                CustomPrimaryButton(
                  buttonColor: primaryBlue,
                  textValue: 'Register',
                  textColor: Colors.white,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      onCreateUser();
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      child: Text(
                        'Login',
                        style: regular16pt.copyWith(color: primaryBlue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Spinner();
    }
  }

  void snackBar(
      {required textColor,
      required text,
      required onPress,
      actionTextColor: null,
      required actionLabelText}) {
    final snackBar = SnackBar(
      content: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      action: SnackBarAction(
        textColor: actionTextColor,
        label: actionLabelText,
        onPressed: onPress,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  onCreateUser() async {
    if (passwordController.text == passwordConfirmController.text) {
      setState(() {
        isLoarding = true;
      });
      User user = User(
        email: emailController.text,
        password: passwordController.text,
      );
      Response response = await _authenticationService.createUser(user);
      if (response.statusCode == 200) {
        Navigator.pop(
          context,
        );
      } else {
        snackBar(
            text: response.body,
            textColor: Colors.red,
            actionLabelText: "Close",
            actionTextColor: Colors.white,
            onPress: () {});
      }
      setState(() {
        isLoarding = false;
      });
    } else {
      snackBar(
          text: "Password not match",
          textColor: Colors.red,
          actionLabelText: "Close",
          actionTextColor: Colors.white,
          onPress: () {});
    }
  }
}
