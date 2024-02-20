import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:story_app/core/styles.dart';
import 'package:story_app/gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // bool isSelected = false;

  // @override
  // void initState() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     setState(() {
  //       isSelected = true;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
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
            GestureDetector(
                onTap: () {
                  // setState(() {
                  //   isSelected = !isSelected;
                  // });
                },
                child: SvgPicture.asset(Assets.icon.logo)),
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
                // const SizedBox(
                //   height: 40,
                // ),
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(30),
                //     color: const Color(0xffD0D0D0),
                //   ),
                //   child: const Text(
                //     'GET STARTED',
                //     style: bodySemiBold,
                //   ),
                // ),
              ],
            ),
            // : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
