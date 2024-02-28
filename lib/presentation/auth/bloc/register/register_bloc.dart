import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:story_app/data/datasources/auth_remote_datasource.dart';
import 'package:story_app/data/model/request/user_register_request_model.dart';
import 'package:story_app/data/model/response/user_register_response_model.dart';

part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource _authRemoteDatasource;
  RegisterBloc(
    this._authRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Register>((event, emit) async {
      emit(const _Loading());
      final register = await _authRemoteDatasource.register(
        event.data,
      );
      register.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
