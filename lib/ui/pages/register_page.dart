import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:story_app/core/styles.dart';
import 'package:story_app/gen/assets.gen.dart';
import 'package:story_app/model/request/user_register_request_model.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/ui/widgets/button_action.dart';
import 'package:story_app/ui/widgets/input_text_custom.dart';

class RegisterPage extends StatefulWidget {
  final Function() onRegister;
  final Function() onLogin;

  const RegisterPage({
    super.key,
    required this.onRegister,
    required this.onLogin,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final nameC = TextEditingController();
  final registerKey = GlobalKey<FormState>();

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
                    key: registerKey,
                    child: Column(
                      children: [
                        InputTextCustom(
                          isPassword: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          controller: nameC,
                          hintText: 'Name',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InputTextCustom(
                          isPassword: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          controller: emailC,
                          hintText: 'Email',
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
                        context.watch<AuthProvider>().isLoadingRegister
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ButtonAction(
                                text: 'SIGN IN',
                                onTap: () async {
                                  if (registerKey.currentState!.validate()) {
                                    final UserRegisterRequestModel user =
                                        UserRegisterRequestModel(
                                      name: nameC.text,
                                      email: emailC.text,
                                      password: passC.text,
                                    );

                                    final authRead =
                                        context.read<AuthProvider>();
                                    final result =
                                        await authRead.register(user);
                                    if (result.error == false) {
                                      widget.onRegister();
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(result.message!),
                                            duration: const Duration(
                                              seconds: 1,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                              ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have account? ',
                              style: body3.copyWith(
                                color: blackColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.onLogin();
                                //
                              },
                              child: Text(
                                'SIGN IN',
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
