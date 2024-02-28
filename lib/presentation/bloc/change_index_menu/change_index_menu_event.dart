part of 'change_index_menu_bloc.dart';

@freezed
class ChangeIndexMenuEvent with _$ChangeIndexMenuEvent {
  const factory ChangeIndexMenuEvent.started() = _Started;
  const factory ChangeIndexMenuEvent.changeIndexMenu(int index) =
      _ChangeIndexMenu;
}
