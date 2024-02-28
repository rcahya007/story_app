part of 'show_image_bloc.dart';

@freezed
class ShowImageState with _$ShowImageState {
  const factory ShowImageState.initial() = _Initial;
  const factory ShowImageState.loading() = _Loading;
  const factory ShowImageState.loaded(XFile? imageFile) = _LoadedFile;
  const factory ShowImageState.error(String message) = _Error;
}
