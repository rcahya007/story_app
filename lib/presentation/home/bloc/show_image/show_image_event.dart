part of 'show_image_bloc.dart';

@freezed
class ShowImageEvent with _$ShowImageEvent {
  const factory ShowImageEvent.started() = _Started;
  const factory ShowImageEvent.setImage(XFile? value) = _SetImageFile;
}
