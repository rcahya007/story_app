// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:story_app/core/styles.dart';
import 'package:story_app/gen/assets.gen.dart';
import 'package:story_app/model/user_model.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/ui/widgets/button_action.dart';
import 'package:story_app/ui/widgets/input_text_custom.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Stack(
              children: [
                Image.asset(
                  Assets.img.heroSignIn.path,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Positioned(
              top: 272,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 40,
                  ),
                  height: 650,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        InputTextCustom(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          controller: emailC,
                          hintText: 'Email',
                          isPassword: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputTextCustom(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          controller: passC,
                          hintText: 'Password',
                          isPassword: true,
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'FORGOT PASSWORD',
                          style: caption.copyWith(
                            color: const Color(0xff5252C7),
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        context.watch<AuthProvider>().isLoadingLogin
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ButtonAction(
                                text: 'LOG IN',
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    final scaffoldMessenger =
                                        ScaffoldMessenger.of(context);
                                    final UserModel user = UserModel(
                                      email: emailC.text,
                                      password: passC.text,
                                    );
                                    final authRead =
                                        context.read<AuthProvider>();

                                    final result = await authRead.login(user);
                                    if (result) {
                                      widget.onLogin();
                                    } else {
                                      scaffoldMessenger.showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Your email or password is invalid"),
                                        ),
                                      );
                                    }
                                  }
                                },
                              ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'OR LOG IN BY',
                          style: caption.copyWith(
                            letterSpacing: 3,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xffE3E4FC),
                              ),
                              child: SvgPicture.asset(
                                Assets.icon.ic24GooglePlus,
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: const Color(0xffE3E4FC),
                              ),
                              child: SvgPicture.asset(
                                Assets.icon.facebookFill,
                                height: 24,
                                width: 24,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have account? ',
                              style: body3.copyWith(
                                color: blackColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onRegister();
                              },
                              child: Text(
                                'SIGN UP',
                                style: body3.copyWith(
                                  color: const Color(0xff888BF4),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
