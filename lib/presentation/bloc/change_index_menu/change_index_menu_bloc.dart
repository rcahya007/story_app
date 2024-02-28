import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_index_menu_event.dart';
part 'change_index_menu_state.dart';
part 'change_index_menu_bloc.freezed.dart';

class ChangeIndexMenuBloc
    extends Bloc<ChangeIndexMenuEvent, ChangeIndexMenuState> {
  ChangeIndexMenuBloc() : super(const _Loaded(0)) {
    on<_ChangeIndexMenu>((event, emit) {
      emit(_Loaded(event.index));
    });
  }
}
