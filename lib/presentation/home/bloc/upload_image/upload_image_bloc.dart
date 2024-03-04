import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/data/datasources/post_stories_datasource.dart';
import 'package:image/image.dart' as img;

part 'upload_image_bloc.freezed.dart';
part 'upload_image_event.dart';
part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  final PostStoriesDatasource postStoriesDatasource;
  UploadImageBloc(
    this.postStoriesDatasource,
  ) : super(const _Initial()) {
    on<_Upload>((event, emit) async {
      emit(const _Loading());

      Future<List<int>> compressImage(List<int> bytes) async {
        int imageLength = bytes.length;
        if (imageLength < 1000000) return bytes;
        final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
        int compressQuality = 100;
        int length = imageLength;
        List<int> newByte = [];
        do {
          ///
          compressQuality -= 10;
          newByte = img.encodeJpg(
            image,
            quality: compressQuality,
          );
          length = newByte.length;
        } while (length > 1000000);
        return newByte;
      }

      final List<int> bytes = await compressImage(event.bytes);
      final String fileName = event.fileName;
      final String description = event.description;

      final response = await postStoriesDatasource.uploadDocument(
        bytes,
        fileName,
        description,
        event.location,
      );
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_LoadedUpload(r.message)),
      );
    });
  }
}
