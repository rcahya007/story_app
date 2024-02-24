import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/api/api_service.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/model/page_configuration.dart';
import 'package:story_app/provider/post_page_provider.dart';
import 'package:story_app/provider/upload_provider.dart';
import 'package:story_app/ui/pages/detail_stories.dart';
import 'package:story_app/ui/pages/init_page.dart';
import 'package:story_app/ui/pages/login_page.dart';
import 'package:story_app/ui/pages/post_stories.dart';
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
  bool isUploadStories = false;

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
    } else if (configuration.isUploadStoriesPage) {
      isUnknown = false;
      isRegister = false;
      isUploadStories = true;
    } else {}
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
    } else if (isUploadStories == true) {
      return PageConfiguration.uploadStories();
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

  List<Page> get _loggedInStack => [
        MaterialPage(
          key: const ValueKey('HomePage'),
          child: InitPage(
            onLogout: () {
              isLoggedIn = false;
              notifyListeners();
            },
            onTapped: (String storiesId) {
              selectedStories = storiesId;
              notifyListeners();
            },
            onPostStories: () {
              isUploadStories = true;
              notifyListeners();
            },
          ),
        ),
        if (isUploadStories == true)
          MaterialPage(
            key: const ValueKey("UploadStories"),
            child: ChangeNotifierProvider(
              create: (context) => PostPageProvider(),
              child: ChangeNotifierProvider(
                create: (context) => UploadProvider(ApiService()),
                child: PostStories(
                  onUpload: () {
                    isUploadStories = false;
                    notifyListeners();
                  },
                ),
              ),
            ),
          ),
        if (selectedStories != null)
          MaterialPage(
            key: ValueKey("DetailStories-$selectedStories"),
            child: DetailStories(
              idStories: selectedStories,
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
        selectedStories = null;
        isUploadStories = false;
        notifyListeners();
        return true;
      },
    );
  }
}
