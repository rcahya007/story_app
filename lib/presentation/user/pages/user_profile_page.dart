import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story_app/common.dart';
import 'package:story_app/core/components/flag_icon.dart';
import 'package:story_app/core/constants/styles.dart';
import 'package:story_app/presentation/bloc/change_index_menu/change_index_menu_bloc.dart';
import 'package:story_app/presentation/user/bloc/logout/logout_bloc.dart';
import 'package:story_app/presentation/user/bloc/get_data_user_local/get_data_user_local_bloc.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    super.key,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    context
        .read<ChangeIndexMenuBloc>()
        .add(const ChangeIndexMenuEvent.changeIndexMenu(3));
    context
        .read<GetDataUserLocalBloc>()
        .add(const GetDataUserLocalEvent.getDataUserLocal());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<GetDataUserLocalBloc, GetDataUserLocalState>(
          builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const SizedBox();
          },
          loaded: (user) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.titleChangeLanguage} : ',
                          style: title1,
                        ),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context)!.language,
                            style: title1,
                          ),
                        ),
                        const FlagIcon(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('User Profile Page'),
                        Text(user.loginResult!.name!),
                        BlocConsumer<LogoutBloc, LogoutState>(
                          listener: (context, state) {
                            state.maybeWhen(
                              loaded: (message) {
                                context.goNamed('Login');
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  duration: const Duration(seconds: 2),
                                  content: Text(message),
                                ));
                              },
                              orElse: () {},
                            );
                          },
                          builder: (context, state) {
                            return state.maybeWhen(
                              orElse: () {
                                return ElevatedButton(
                                  onPressed: () async {
                                    context
                                        .read<LogoutBloc>()
                                        .add(const LogoutEvent.logout());
                                  },
                                  child: Text(AppLocalizations.of(context)!
                                      .textIconLogout),
                                );
                              },
                              loading: () => const CircularProgressIndicator(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    ));
  }
}
