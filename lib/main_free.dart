import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_app/common.dart';
import 'package:story_app/data/datasources/auth_local_datasource.dart';
import 'package:story_app/data/datasources/auth_local_language_datasource.dart';
import 'package:story_app/data/datasources/auth_remote_datasource.dart';
import 'package:story_app/data/datasources/post_stories_datasource.dart';
import 'package:story_app/data/datasources/stories_remote_datasource.dart';
import 'package:story_app/flavor_config.dart';
import 'package:story_app/navigation/app_navigation.dart';
import 'package:story_app/presentation/auth/bloc/login/login_bloc.dart';
import 'package:story_app/presentation/auth/bloc/register/register_bloc.dart';
import 'package:story_app/presentation/bloc/change_index_menu/change_index_menu_bloc.dart';
import 'package:story_app/presentation/auth/bloc/check_auth/check_auth_bloc.dart';
import 'package:story_app/presentation/home/bloc/get_detail_stories/get_detail_stories_bloc.dart';
import 'package:story_app/presentation/home/bloc/get_all_stories/get_all_stories_bloc.dart';
import 'package:story_app/presentation/home/bloc/get_location/get_location_bloc.dart';
import 'package:story_app/presentation/home/bloc/show_image/show_image_bloc.dart';
import 'package:story_app/presentation/home/bloc/upload_image/upload_image_bloc.dart';
import 'package:story_app/presentation/user/bloc/logout/logout_bloc.dart';
import 'package:story_app/presentation/user/bloc/get_data_user_local/get_data_user_local_bloc.dart';
import 'package:story_app/presentation/user/cubit/change_language/change_language_cubit.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  FlavorConfig(
    flavor: FlavorType.free,
    values: const FlavorValues(
      titleApp: "Story App Free",
    ),
  );
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckAuthBloc(AuthLocalDatasource()),
        ),
        BlocProvider(
          create: (context) => ChangeIndexMenuBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetAllStoriesBloc(StoriesRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetDataUserLocalBloc(AuthLocalDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthLocalDatasource()),
        ),
        BlocProvider(
          create: (context) => GetDetailStoriesBloc(StoriesRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ShowImageBloc(),
        ),
        BlocProvider(
          create: (context) => UploadImageBloc(PostStoriesDatasource()),
        ),
        BlocProvider(
          create: (context) =>
              ChangeLanguageCubit(AuthLocalLanguageDatasource()),
        ),
        BlocProvider(
          create: (context) => GetLocationBloc(),
        )
      ],
      child: BlocBuilder<ChangeLanguageCubit, ChangeLanguageState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const SizedBox();
            },
            loaded: (locale) {
              return MaterialApp.router(
                locale: locale,
                debugShowCheckedModeBanner: false,
                routerConfig: AppNavigation.router,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
              );
            },
          );
        },
      ),
    );
  }
}
