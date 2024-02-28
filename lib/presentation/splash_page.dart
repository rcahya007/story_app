import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/assets/assets.gen.dart';
import 'package:story_app/core/constants/styles.dart';
import 'package:story_app/presentation/bloc/change_index_menu/change_index_menu_bloc.dart';
import 'package:story_app/presentation/auth/bloc/check_auth/check_auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      checkAuth();
    });
    super.initState();
  }

  void checkAuth() {
    context
        .read<ChangeIndexMenuBloc>()
        .add(const ChangeIndexMenuEvent.changeIndexMenu(0));
    context.read<CheckAuthBloc>().add(const CheckAuthEvent.check());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckAuthBloc, CheckAuthState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          loaded: (isLogin) {
            if (isLogin) {
              context.goNamed('Home');
            } else {
              context.goNamed('Login');
            }
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Assets.img.backgroundSplash.path),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Assets.icon.logo.path),
                    const SizedBox(
                      height: 40,
                    ),
                    Image.asset(Assets.img.heroSplashScreen.path),
                    const SizedBox(
                      height: 30,
                    ),
                    // isSelected
                    //     ?
                    Column(
                      // key: ValueKey(isSelected),
                      children: [
                        Text(
                          'SHARE - INSPIRE - CONNECT',
                          style: bodySemiBold.copyWith(
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                    // : const CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
