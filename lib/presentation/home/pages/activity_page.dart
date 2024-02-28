import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/presentation/bloc/change_index_menu/change_index_menu_bloc.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    context
        .read<ChangeIndexMenuBloc>()
        .add(const ChangeIndexMenuEvent.changeIndexMenu(2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text('Activity Page'),
    ));
  }
}
