part of 'change_index_menu_bloc.dart';

@freezed
class ChangeIndexMenuState with _$ChangeIndexMenuState {
  const factory ChangeIndexMenuState.initial() = _Initial;
  const factory ChangeIndexMenuState.loading() = _Loading;
  const factory ChangeIndexMenuState.loaded(int index) = _Loaded;
  const factory ChangeIndexMenuState.error(String message) = _Error;
}
