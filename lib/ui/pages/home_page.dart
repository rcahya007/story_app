// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        body: SafeArea(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    ])));
  }
}
