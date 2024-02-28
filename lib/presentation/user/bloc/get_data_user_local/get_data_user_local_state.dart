part of 'get_data_user_local_bloc.dart';

@freezed
class GetDataUserLocalState with _$GetDataUserLocalState {
  const factory GetDataUserLocalState.initial() = _Initial;
  const factory GetDataUserLocalState.loading() = _Loading;
  const factory GetDataUserLocalState.loaded(UserLoginResponseModel data) =
      _Loaded;
  const factory GetDataUserLocalState.error(String message) = _Error;
}
