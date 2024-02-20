// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:story_app/core/styles.dart';
import 'package:story_app/gen/assets.gen.dart';
import 'package:story_app/provider/auth_provider.dart';

class HomePage extends StatelessWidget {
  final Function() onLogut;
  const HomePage({
    Key? key,
    required this.onLogut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();
    return Scaffold(
      bottomNavigationBar: Container(
        height: 75,
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: const BottomAppBar(
          clipBehavior: Clip.antiAlias,
          surfaceTintColor: Colors.white,
          elevation: 20,
          shadowColor: Colors.black,
          notchMargin: 10.0,
          shape: CircularNotchedRectangle(),
          child: Row(
            children: [
              Icon(
                Icons.home,
              ),
              Icon(
                Icons.home,
              ),
              Icon(
                Icons.home,
              ),
              Icon(
                Icons.home,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FittedBox(
          child: FloatingActionButton(
            shape: const CircleBorder(),
            onPressed: () {},
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('HomePage'),
            ElevatedButton(
              onPressed: () async {
                final authRead = context.read<AuthProvider>();
                final result = await authRead.logout();
                if (result) onLogut();
              },
              child: authWatch.isLoadingLogout
                  ? const CircularProgressIndicator()
                  : const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
