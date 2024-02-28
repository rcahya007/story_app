part of 'get_data_user_local_bloc.dart';

@freezed
class GetDataUserLocalEvent with _$GetDataUserLocalEvent {
  const factory GetDataUserLocalEvent.started() = _Started;
  const factory GetDataUserLocalEvent.getDataUserLocal() = _GerDataUserLocal;
}
