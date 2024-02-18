import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:story_app/core/styles.dart';
import 'package:story_app/gen/assets.gen.dart';
import 'package:story_app/model/user_model.dart';
import 'package:story_app/provider/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  final Function() onRegister;
  final Function() onLogin;

  const RegisterPage({
    Key? key,
    required this.onRegister,
    required this.onLogin,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final nameC = TextEditingController();
  final registerKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    nameC.dispose();
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
              key: registerKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                    obscureText: true,
                    controller: passC,
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
                  context.watch<AuthProvider>().isLoadingRegister
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GestureDetector(
                          onTap: () async {
                            if (registerKey.currentState!.validate()) {
                              final UserModel user = UserModel(
                                name: nameC.text,
                                email: emailC.text,
                                password: passC.text,
                              );
                              final authRead = context.read<AuthProvider>();
                              final result = await authRead.saveUser(user);
                              if (result) widget.onRegister();
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
                              'REGISTER',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Allready have account? ',
                        style: body3,
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.onLogin();
                        },
                        child: Text(
                          'SIGN IN',
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
