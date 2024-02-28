import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/datasources/auth_local_datasource.dart';

part 'check_auth_event.dart';
part 'check_auth_state.dart';
part 'check_auth_bloc.freezed.dart';

class CheckAuthBloc extends Bloc<CheckAuthEvent, CheckAuthState> {
  final AuthLocalDatasource authLocalDatasource;
  CheckAuthBloc(this.authLocalDatasource) : super(const _Loaded(false)) {
    on<_Check>((event, emit) async {
      emit(const _Loading());
      final authData = await authLocalDatasource.isAuth();
      if (authData) {
        emit(const _Loaded(true));
      } else {
        emit(const _Loaded(false));
      }
    });
  }
}
