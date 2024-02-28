import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/assets/assets.gen.dart';

import 'package:story_app/core/constants/styles.dart';
import 'package:story_app/data/datasources/auth_local_datasource.dart';
import 'package:story_app/data/model/request/user_login_request_model.dart';
import 'package:story_app/core/components/button_action.dart';
import 'package:story_app/core/components/input_text_custom.dart';
import 'package:story_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:story_app/presentation/home/bloc/get_all_stories/get_all_stories_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

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
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              orElse: () {},
                              loaded: (user) {
                                AuthLocalDatasource().saveAuthData(user);
                                context.goNamed('Home');
                                context.read<GetAllStoriesBloc>().add(
                                      const GetAllStoriesEvent.getAllStories(),
                                    );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(
                                      seconds: 2,
                                    ),
                                    content: Text(
                                        'Selamat data ${user.loginResult!.name}'),
                                  ),
                                );
                              },
                              error: (message) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: const Duration(
                                    seconds: 2,
                                  ),
                                  content: Text(message),
                                ));
                              },
                            );
                          },
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return ButtonAction(
                                  text: 'LOG IN',
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      context
                                          .read<LoginBloc>()
                                          .add(LoginEvent.login(
                                            UserLoginRequestModel(
                                              email: emailC.text,
                                              password: passC.text,
                                            ),
                                          ));
                                    }
                                  },
                                );
                              },
                              loading: () {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
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
                                Assets.icon.ic24GooglePlus.path,
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
                                Assets.icon.facebookFill.path,
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
                                context.goNamed('Register');
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
