class PageConfiguration {
  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? storiesId;
  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        storiesId = null;
  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        storiesId = null;
  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        storiesId = null;
  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true,
        storiesId = null;
  PageConfiguration.detailStories(String id)
      : unknown = false,
        register = false,
        loggedIn = true,
        storiesId = id;
  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        storiesId = null;

  bool get isSplashPage =>
      unknown == false &&
      register == false &&
      loggedIn == null &&
      storiesId == null;
  bool get isLoginPage =>
      unknown == false &&
      register == false &&
      loggedIn == false &&
      storiesId == null;
  bool get isRegisterPage =>
      unknown == false &&
      register == true &&
      loggedIn == false &&
      storiesId == null;
  bool get isHomePage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storiesId == null;
  bool get isDetailPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storiesId != null;
  bool get isUnknownPage =>
      unknown == true &&
      register == false &&
      loggedIn == null &&
      storiesId == null;
}
