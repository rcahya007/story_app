import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'show_image_event.dart';
part 'show_image_state.dart';
part 'show_image_bloc.freezed.dart';

class ShowImageBloc extends Bloc<ShowImageEvent, ShowImageState> {
  ShowImageBloc() : super(const _Initial()) {
    on<_SetImageFile>((event, emit) {
      emit(const _Loading());
      emit(_LoadedFile(event.value));
    });
  }
}
