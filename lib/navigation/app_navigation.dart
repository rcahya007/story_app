import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/datasources/auth_local_datasource.dart';
import 'package:story_app/presentation/auth/pages/login_page.dart';
import 'package:story_app/presentation/auth/pages/register_page.dart';
import 'package:story_app/presentation/bloc/change_index_menu/change_index_menu_bloc.dart';
import 'package:story_app/presentation/home/pages/activity_page.dart';
import 'package:story_app/presentation/home/pages/detail_stories.dart';
import 'package:story_app/presentation/home/pages/discover_page.dart';
import 'package:story_app/presentation/home/pages/home_page.dart';
import 'package:story_app/presentation/init_page.dart';
import 'package:story_app/presentation/home/pages/post_stories.dart';
import 'package:story_app/presentation/splash_page.dart';
import 'package:story_app/presentation/user/pages/user_profile_page.dart';

class AppNavigation {
  AppNavigation._();
  static String init = '/home';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  // Home
  static final _rootNavigatorHome = GlobalKey<NavigatorState>(
    debugLabel: 'HomeStories',
  );
  // Discover
  static final _rootNavigatorDiscover = GlobalKey<NavigatorState>(
    debugLabel: 'DiscoverStories',
  );
  // Activities
  static final _rootNavigatorActivities = GlobalKey<NavigatorState>(
    debugLabel: 'ActivitiesStories',
  );
  // Profile
  static final _rootNavigatorProfile = GlobalKey<NavigatorState>(
    debugLabel: 'ProfileStories',
  );

  // Go Router Navigation
  static final GoRouter router = GoRouter(
    initialLocation: '/splash_screen',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // InitPage Route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return InitPage(
            navigationShell: navigationShell,
          );
        },
        branches: [
          // Branch Home
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(
                  path: '/home',
                  name: 'Home',
                  builder: (context, state) {
                    return HomePage(
                      key: state.pageKey,
                    );
                  },
                  routes: [
                    GoRoute(
                        path: ':storiesId',
                        name: 'DetailStories',
                        builder: (context, state) {
                          return DetailStories(
                            key: state.pageKey,
                            storiesId: state.pathParameters['storiesId']!,
                          );
                        })
                  ]),
            ],
          ),
          // Branch Discover
          StatefulShellBranch(
            navigatorKey: _rootNavigatorDiscover,
            routes: [
              GoRoute(
                path: '/discover',
                name: 'Discover',
                builder: (context, state) {
                  context
                      .read<ChangeIndexMenuBloc>()
                      .add(const ChangeIndexMenuEvent.changeIndexMenu(1));
                  return DiscoverPage(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
          // Branch Activities
          StatefulShellBranch(
            navigatorKey: _rootNavigatorActivities,
            routes: [
              GoRoute(
                path: '/activities',
                name: 'Activities',
                builder: (context, state) {
                  context.read<ChangeIndexMenuBloc>().add(
                        const ChangeIndexMenuEvent.changeIndexMenu(2),
                      );
                  return ActivityPage(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
          // Branch User Profile
          StatefulShellBranch(
            navigatorKey: _rootNavigatorProfile,
            routes: [
              GoRoute(
                path: '/profile',
                name: 'Profile',
                builder: (context, state) {
                  context.read<ChangeIndexMenuBloc>().add(
                        const ChangeIndexMenuEvent.changeIndexMenu(3),
                      );
                  return UserProfilePage(
                    key: state.pageKey,
                  );
                },
              ),
            ],
          ),
        ],
      ),

      GoRoute(
          path: '/upload',
          name: 'Upload',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            return PostStories(
              key: state.pageKey,
            );
          }),

      GoRoute(
          path: '/splash_screen',
          name: 'SplashScreen',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            return SplashScreen(
              key: state.pageKey,
            );
          }),

      GoRoute(
          path: '/login',
          name: 'Login',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            return LoginPage(
              key: state.pageKey,
            );
          }),

      GoRoute(
          path: '/register',
          name: 'Register',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            return RegisterPage(
              key: state.pageKey,
            );
          }),
    ],
    redirect: (context, state) async {
      // Check Auth
      final checkAuth = await AuthLocalDatasource().isAuth();
      if (state.matchedLocation == '/login') {
        return '/login';
      } else if (state.matchedLocation == '/register') {
        return '/register';
      } else if (checkAuth) {
        return null;
      } else {
        return '/login';
      }
    },
  );
}
