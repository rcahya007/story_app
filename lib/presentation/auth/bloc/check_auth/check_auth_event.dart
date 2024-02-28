part of 'check_auth_bloc.dart';

@freezed
class CheckAuthEvent with _$CheckAuthEvent {
  const factory CheckAuthEvent.started() = _Started;
  const factory CheckAuthEvent.check() = _Check;
}
