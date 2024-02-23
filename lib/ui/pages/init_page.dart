import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:story_app/gen/assets.gen.dart';
import 'package:story_app/ui/pages/activity_page.dart';
import 'package:story_app/ui/pages/discover_page.dart';
import 'package:story_app/ui/pages/home_page.dart';
import 'package:story_app/ui/pages/user_profile_page.dart';

class InitPage extends StatefulWidget {
  final dynamic Function() onLogout;
  final dynamic Function(String) onTapped;
  final dynamic Function() onPostStories;
  const InitPage({
    super.key,
    required this.onLogout,
    required this.onTapped,
    required this.onPostStories,
  });

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int pageIndex = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();

    pages = [
      HomePage(
        onTapped: widget.onTapped,
      ),
      const DiscoverPage(),
      const ActivityPage(),
      UserProfilePage(
        onLogout: widget.onLogout,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: Colors.white,
        elevation: 20,
        shadowColor: Colors.black,
        notchMargin: 10.0,
        shape: const CircularNotchedRectangle(),
        child: Row(
          children: [
            const SizedBox(
              width: 24,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              child: SvgPicture.asset(
                pageIndex == 0 ? Assets.icon.home : Assets.icon.homeCopy,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              child: SvgPicture.asset(
                pageIndex == 1
                    ? Assets.icon.category
                    : Assets.icon.categoryCopy,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              child: SvgPicture.asset(
                pageIndex == 2
                    ? Assets.icon.notificationFill
                    : Assets.icon.notificationCopy,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              child: SvgPicture.asset(
                pageIndex == 3 ? Assets.icon.profileFill : Assets.icon.profile,
              ),
            ),
            const SizedBox(
              width: 24,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FittedBox(
          child: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () => widget.onPostStories(),
            tooltip: 'Add Stories',
            elevation: 2.0,
            child: SvgPicture.asset(
              Assets.icon.plus,
              height: 24,
              width: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
      body: pages[pageIndex],
    );
  }
}
