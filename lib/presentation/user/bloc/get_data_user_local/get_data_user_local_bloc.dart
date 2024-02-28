import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/datasources/auth_local_datasource.dart';
import 'package:story_app/data/model/response/user_login_response_model.dart';

part 'get_data_user_local_event.dart';
part 'get_data_user_local_state.dart';
part 'get_data_user_local_bloc.freezed.dart';

class GetDataUserLocalBloc
    extends Bloc<GetDataUserLocalEvent, GetDataUserLocalState> {
  final AuthLocalDatasource authLocalDatasource;
  GetDataUserLocalBloc(
    this.authLocalDatasource,
  ) : super(const _Initial()) {
    on<_GerDataUserLocal>((event, emit) async {
      emit(const _Loading());
      final authData = await authLocalDatasource.getAuthData();
      if (authData != null) {
        emit(_Loaded(authData));
      } else {
        emit(const _Error('data not found'));
      }
    });
  }
}
