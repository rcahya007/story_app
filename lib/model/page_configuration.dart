class PageConfiguration {
  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? storiesId;
  final bool? isUploadStories;

  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        storiesId = null,
        isUploadStories = false;
  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        storiesId = null,
        isUploadStories = false;
  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        storiesId = null,
        isUploadStories = false;
  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true,
        storiesId = null,
        isUploadStories = false;
  PageConfiguration.uploadStories()
      : unknown = false,
        register = false,
        loggedIn = true,
        storiesId = null,
        isUploadStories = true;
  PageConfiguration.detailStories(String id)
      : unknown = false,
        register = false,
        loggedIn = true,
        storiesId = id,
        isUploadStories = false;
  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        storiesId = null,
        isUploadStories = false;

  bool get isSplashPage =>
      unknown == false &&
      register == false &&
      loggedIn == null &&
      storiesId == null &&
      isUploadStories == false;
  bool get isLoginPage =>
      unknown == false &&
      register == false &&
      loggedIn == false &&
      storiesId == null &&
      isUploadStories == false;
  bool get isRegisterPage =>
      unknown == false &&
      register == true &&
      loggedIn == false &&
      storiesId == null &&
      isUploadStories == false;
  bool get isHomePage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storiesId == null &&
      isUploadStories == false;
  bool get isUploadStoriesPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storiesId == null &&
      isUploadStories == true;
  bool get isDetailPage =>
      unknown == false &&
      register == false &&
      loggedIn == true &&
      storiesId != null &&
      isUploadStories == false;
  bool get isUnknownPage =>
      unknown == true &&
      register == false &&
      loggedIn == null &&
      storiesId == null &&
      isUploadStories == false;
}
