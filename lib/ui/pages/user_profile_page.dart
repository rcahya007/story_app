// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:story_app/provider/auth_provider.dart';

class UserProfilePage extends StatefulWidget {
  final Function() onLogout;
  const UserProfilePage({
    Key? key,
    required this.onLogout,
  }) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final authWatch = context.watch<AuthProvider>();
    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('User Profile Page'),
            const Text('Nama '),
            ElevatedButton(
              onPressed: () async {
                final authRead = context.read<AuthProvider>();
                final result = await authRead.logout();
                if (result) widget.onLogout();
              },
              child: authWatch.isLoadingLogout
                  ? const CircularProgressIndicator()
                  : const Text('Logout'),
            ),
          ],
        ),
      ),
    ));
  }
}
