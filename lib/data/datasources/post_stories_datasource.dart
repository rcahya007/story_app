import 'dart:convert';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/data/datasources/auth_local_datasource.dart';
import 'package:story_app/data/model/upload_response.dart';
import 'package:http/http.dart' as http;

class PostStoriesDatasource {
  Future<Either<String, UploadResponse>> uploadDocument(
    List<int> bytes,
    String fileName,
    String description,
    LatLng? location,
  ) async {
    const String url = "https://story-api.dicoding.dev/v1/stories";

    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);

    final multiPartFile = http.MultipartFile.fromBytes(
      "photo",
      bytes,
      filename: fileName,
    );

    Map<String, String> fields;

    if (location != null) {
      fields = {
        "description": description,
        "lat": location.latitude.toString(),
        "lon": location.longitude.toString()
      };
    } else {
      fields = {
        "description": description,
      };
    }

    final AuthLocalDatasource authLocalDatasource;
    authLocalDatasource = AuthLocalDatasource();
    final dataUSer = await authLocalDatasource.getAuthData();

    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer ${dataUSer!.loginResult!.token}",
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;
    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      final UploadResponse uploadResponse = UploadResponse.fromJson(
        jsonDecode(responseData),
      );
      return right(uploadResponse);
    } else {
      return left('Upload file error');
    }
  }
}
