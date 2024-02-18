// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:story_app/core/styles.dart';
import 'package:story_app/gen/assets.gen.dart';
import 'package:story_app/model/user_model.dart';
import 'package:story_app/provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  final Function() onLogin;
  final Function() onRegister;

  const LoginPage({
    Key? key,
    required this.onLogin,
    required this.onRegister,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(),
        Stack(
          children: [
            Image.asset(
              Assets.img.heroSignIn.path,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 42,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SvgPicture.asset(
                    Assets.icon.logo,
                    height: 25,
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  Stack(
                    children: [
                      Text(
                        'WELCOME',
                        style: TextStyle(
                          fontFamily: 'CircularStd',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 1
                            ..color = whiteColor, // <-- Border color
                        ),
                      ),
                      const Text(
                        'WELCOME',
                        style: TextStyle(
                          fontFamily: 'CircularStd',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.transparent, // <-- Inner color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 282,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(
              top: 40,
              right: 30,
              left: 30,
            ),
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                )),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passC,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'FORGOT PASSWORD',
                    style: caption.copyWith(
                      letterSpacing: 5,
                      color: blueColor,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  context.watch<AuthProvider>().isLoadingLogin
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              final scaffoldMessenger =
                                  ScaffoldMessenger.of(context);
                              final UserModel user = UserModel(
                                email: emailC.text,
                                password: passC.text,
                              );
                              final authRead = context.read<AuthProvider>();
                              final result = await authRead.login(user);
                              if (result) {
                                widget.onLogin();
                              } else {
                                scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Your email or password is invalid',
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                                color: blueColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: Text(
                              'LOG IN',
                              style: bodySemiBold.copyWith(
                                color: whiteColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'OR LOG IN BY',
                    style: caption.copyWith(
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xffE3E4FC),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: SvgPicture.asset(
                          Assets.icon.google,
                          width: 24,
                          height: 24,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xffE3E4FC),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: SvgPicture.asset(
                          Assets.icon.facebook,
                          width: 24,
                          height: 24,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have account? ',
                        style: body3,
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.onRegister();
                        },
                        child: Text(
                          'SIGN UP',
                          style: body3.copyWith(
                            color: blueColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
