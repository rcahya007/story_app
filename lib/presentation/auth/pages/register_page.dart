import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/assets/assets.gen.dart';

import 'package:story_app/core/constants/styles.dart';
import 'package:story_app/data/model/request/user_register_request_model.dart';
import 'package:story_app/core/components/button_action.dart';
import 'package:story_app/core/components/input_text_custom.dart';
import 'package:story_app/presentation/auth/bloc/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
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
                        BlocConsumer<RegisterBloc, RegisterState>(
                          listener: (context, state) {
                            state.maybeWhen(
                                orElse: () {},
                                loaded: (user) {
                                  context.goNamed('Login');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      content: Text(user.message!),
                                    ),
                                  );
                                },
                                error: (message) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      message,
                                    ),
                                  ));
                                });
                          },
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return ButtonAction(
                                  text: 'SIGN IN',
                                  onTap: () {
                                    if (registerKey.currentState!.validate()) {
                                      context
                                          .read<RegisterBloc>()
                                          .add(RegisterEvent.register(
                                            UserRegisterRequestModel(
                                              email: emailC.text,
                                              password: passC.text,
                                              name: nameC.text,
                                            ),
                                          ));
                                    }
                                  },
                                );
                              },
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
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
                                // widget.onLogin();
                                context.goNamed('Login');
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
