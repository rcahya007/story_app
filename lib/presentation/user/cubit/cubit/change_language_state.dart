part of 'change_language_cubit.dart';

@freezed
class ChangeLanguageState with _$ChangeLanguageState {
  const factory ChangeLanguageState.initial(Locale locale) = _Initial;
  const factory ChangeLanguageState.loading() = _Loading;
  const factory ChangeLanguageState.loaded(Locale locale) = _Loaded;
  const factory ChangeLanguageState.error(String message) = _Error;
}
