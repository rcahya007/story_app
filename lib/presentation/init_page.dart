import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/core/assets/assets.gen.dart';
import 'package:story_app/presentation/bloc/change_index_menu/change_index_menu_bloc.dart';

class InitPage extends StatefulWidget {
  const InitPage({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  void _goToBrach(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        surfaceTintColor: Colors.white,
        elevation: 20,
        shadowColor: Colors.black,
        notchMargin: 10.0,
        shape: const CircularNotchedRectangle(),
        child: BlocConsumer<ChangeIndexMenuBloc, ChangeIndexMenuState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (index) {
                _goToBrach(index);
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return const SizedBox();
              },
              loaded: (index) {
                return Row(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<ChangeIndexMenuBloc>()
                            .add(const ChangeIndexMenuEvent.changeIndexMenu(0));
                      },
                      child: SvgPicture.asset(
                        index == 0
                            ? Assets.icon.home.path
                            : Assets.icon.homeCopy.path,
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<ChangeIndexMenuBloc>()
                            .add(const ChangeIndexMenuEvent.changeIndexMenu(1));
                      },
                      child: SvgPicture.asset(
                        index == 1
                            ? Assets.icon.category.path
                            : Assets.icon.categoryCopy.path,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<ChangeIndexMenuBloc>()
                            .add(const ChangeIndexMenuEvent.changeIndexMenu(2));
                      },
                      child: SvgPicture.asset(
                        index == 2
                            ? Assets.icon.notificationFill.path
                            : Assets.icon.notificationCopy.path,
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<ChangeIndexMenuBloc>()
                            .add(const ChangeIndexMenuEvent.changeIndexMenu(3));
                      },
                      child: SvgPicture.asset(
                        index == 3
                            ? Assets.icon.profileFill.path
                            : Assets.icon.profile.path,
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            shape: const CircleBorder(),
            onPressed: () {
              context.goNamed('Upload');
            },
            tooltip: 'Add Stories',
            elevation: 2.0,
            child: SvgPicture.asset(
              Assets.icon.plus.path,
              height: 24,
              width: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }
}
