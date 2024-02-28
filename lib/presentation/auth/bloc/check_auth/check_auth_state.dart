part of 'check_auth_bloc.dart';

@freezed
class CheckAuthState with _$CheckAuthState {
  const factory CheckAuthState.initial() = _Initial;
  const factory CheckAuthState.loading() = _Loading;
  const factory CheckAuthState.loaded(bool isLogin) = _Loaded;
  const factory CheckAuthState.error(String message) = _Error;
}
