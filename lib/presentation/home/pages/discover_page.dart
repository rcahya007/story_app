import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/presentation/bloc/change_index_menu/change_index_menu_bloc.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    context
        .read<ChangeIndexMenuBloc>()
        .add(const ChangeIndexMenuEvent.changeIndexMenu(1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('Discover Page'),
    ));
  }
}
