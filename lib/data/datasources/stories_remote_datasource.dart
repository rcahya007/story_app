import 'package:dartz/dartz.dart';
import 'package:story_app/core/constants/variables.dart';
import 'package:story_app/data/datasources/auth_local_datasource.dart';
import 'package:story_app/data/model/response/stories_detail_response_model.dart';
import 'package:story_app/data/model/response/stories_response_model.dart';
import 'package:http/http.dart' as http;

class StoriesRemoteDatasource {
  Future<Either<String, StoriesResponseModel>> getAllStories() async {
    final dataUser = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
        '${Variables.urlBase}/stories',
      ),
      headers: {
        'Authorization': 'Bearer ${dataUser!.loginResult!.token}',
      },
    );
    if (response.statusCode == 200) {
      return Right(StoriesResponseModel.fromJson(response.body));
    } else {
      return Left(StoriesResponseModel.fromJson(response.body).message!);
    }
  }

  Future<Either<String, StoriesDetailResponseModel>> getDetailStories(
      String id) async {
    final dataUser = await AuthLocalDatasource().getAuthData();
    final response =
        await http.get(Uri.parse('${Variables.urlBase}/stories/$id'), headers: {
      'Authorization': 'Bearer ${dataUser!.loginResult!.token}',
    });
    if (response.statusCode == 200) {
      return Right(StoriesDetailResponseModel.fromJson(response.body));
    } else {
      return Left(StoriesDetailResponseModel.fromJson(response.body).message!);
    }
  }
}
