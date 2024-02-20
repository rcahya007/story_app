import 'package:flutter/material.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/model/page_configuration.dart';
import 'package:story_app/ui/pages/init_page.dart';
import 'package:story_app/ui/pages/login_page.dart';
import 'package:story_app/ui/pages/register_page.dart';
import 'package:story_app/ui/pages/splash_page.dart';

class MyRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;

  List<Page> historyStack = [];
  static bool? isLoggedIn;
  bool isRegister = false;
  bool isProfile = false;
  bool? isUnknown;
  String? selectedStories;

  MyRouterDelegate(this.authRepository)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  _init() async {
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    if (configuration.isUnknownPage) {
      isUnknown = true;
      isRegister = false;
    } else if (configuration.isRegisterPage) {
      isRegister = true;
    } else if (configuration.isHomePage ||
        configuration.isLoginPage ||
        configuration.isSplashPage) {
      isUnknown = false;
      selectedStories = null;
      isRegister = false;
    } else if (configuration.isDetailPage) {
      isUnknown = false;
      isRegister = false;
      selectedStories = configuration.storiesId.toString();
    } else {
      print(' Could not set new route');
    }
    notifyListeners();
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (isLoggedIn == null) {
      return PageConfiguration.splash();
    } else if (isRegister == true) {
      return PageConfiguration.register();
    } else if (isLoggedIn == false) {
      return PageConfiguration.login();
    } else if (isUnknown == true) {
      return PageConfiguration.unknown();
    } else if (selectedStories == null) {
      return PageConfiguration.home();
    } else if (selectedStories != null) {
      return PageConfiguration.detailStories(selectedStories!);
    } else {
      return null;
    }
  }

  List<Page> get _splashStack => const [
        MaterialPage(
          key: ValueKey('SplashPage'),
          child: SplashScreen(),
        ),
      ];

  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey('LoginPage'),
          child: LoginPage(
            onLogin: () {
              isLoggedIn = true;
              notifyListeners();
            },
            onRegister: () {
              isRegister = true;
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey('RegisterPage'),
            child: RegisterPage(
              onLogin: () {
                isRegister = false;
                notifyListeners();
              },
              onRegister: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          ),
      ];

  get _loggedInStack => [
        MaterialPage(
          key: const ValueKey('HomePage'),
          child: InitPage(
            onLogout: () {
              isLoggedIn = false;
              notifyListeners();
            },
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }

    return Navigator(
      key: navigatorKey,
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }
        isRegister = false;
        notifyListeners();
        return true;
      },
    );
  }
}
