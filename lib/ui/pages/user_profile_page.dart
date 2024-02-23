import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/model/response/user_login_response_model.dart';

import 'package:story_app/provider/auth_provider.dart';

class UserProfilePage extends StatefulWidget {
  final Function() onLogout;
  const UserProfilePage({
    super.key,
    required this.onLogout,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserLoginResponseModel? user;

  @override
  void initState() {
    super.initState();
    getDataLocal();
  }

  void getDataLocal() async {
    final dataUser = await AuthRepository().getUser();
    setState(() {
      user = dataUser;
    });
  }

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
            user != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(user!.loginResult!.name!),
                    ],
                  )
                : const CircularProgressIndicator(),
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
