import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/datasources/auth_local_datasource.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthLocalDatasource authLocalDatasource;
  LogoutBloc(this.authLocalDatasource) : super(const _Initial()) {
    on<_Logout>((event, emit) {
      emit(const _Loading());
      authLocalDatasource.removeAuthData();
      emit(const _Loaded('Logout Success'));
    });
  }
}
