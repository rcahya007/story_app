part of 'upload_image_bloc.dart';

@freezed
class UploadImageState with _$UploadImageState {
  const factory UploadImageState.initial() = _Initial;
  const factory UploadImageState.loading() = _Loading;
  const factory UploadImageState.loadedUpload(String? message) = _LoadedUpload;
  const factory UploadImageState.error(String message) = _Error;
}
