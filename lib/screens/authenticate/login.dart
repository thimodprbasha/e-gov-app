import 'package:e_gov/screens/citizen/citizen_dashboard.dart';
import 'package:e_gov/screens/deptwoker/gov_worker_dashboard.dart';
import 'package:e_gov/screens/supervisor/supervisor_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:e_gov/screens/authenticate/register.dart';
import 'package:e_gov/widgets/primary_button.dart';
import 'package:e_gov/widgets/custom_checkbox.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/authservice.dart';
import '../../widgets/spinner.dart';
import '../theme.dart';
import 'dart:convert';
import 'package:e_gov/env/env.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences? prefs;
  bool isLording = false;
  bool passwordVisible = false;
  final AuthenticationService _auth = AuthenticationService();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String isUser = "";

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLording) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login to your\naccount',
                      style: heading2.copyWith(color: textBlack),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/images/accent.png',
                      width: 99,
                      height: 4,
                    ),
                  ],
                ),
                const SizedBox(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter username';
                            }
                            return null;
                          },
                          controller: userNameController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: heading6.copyWith(color: textGrey),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: textWhiteGrey,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                          controller: passwordController,
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
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomCheckbox(),
                    const SizedBox(
                      width: 12,
                    ),
                    Text('Remember me', style: regular16pt),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                CustomPrimaryButton(
                  buttonColor: primaryBlue,
                  textValue: 'Login',
                  textColor: Colors.white,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      authenticateForm();
                    }
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Text(
                    'OR',
                    style: heading6.copyWith(color: textGrey),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomPrimaryButton(
                  buttonColor: Color(0xfffbfbfb),
                  textValue: 'Login with Google',
                  textColor: textBlack,
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: regular16pt.copyWith(color: textGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        'Register',
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

  void authenticateForm() async {
    setState(() {
      isLording = true;
    });
    Response credentials = await _auth.userAuthenticateService(
        userNameController.text, passwordController.text);
    final Map userDetails = json.decode(credentials.body);
    if (credentials.statusCode == 200) {
      prefs = await SharedPreferences.getInstance();
      prefs?.setString("USER_ID", userDetails["id"]);
      prefs?.setString("USER_ROLE", userDetails["role"]);
      prefs?.setString("USER_EMAIL", userDetails["email"]);

      navigate(userDetails['role']);
    }else {
      snackBar(
          text: userDetails["message"],
          textColor: Colors.red,
          actionLabelText: "Close",
          actionTextColor: Colors.white,
          onPress: (){}
      );
    }
    setState(() {
      isLording = false;
    });
  }

  void navigate(String role) {
    if (role == CITIZEN) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CitizenDashboard()),
      );
    } else if (role == GOV_WORKER) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GovWorkerDashBoard()),
      );
    } else if (role == SUPERVISOR) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SupervisorDashboard()),
      );
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
}
