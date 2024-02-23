import 'package:flutter/material.dart';
import 'package:story_app/core/variables.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/model/response/stories_detail_response_model.dart';
import 'package:story_app/model/response/stories_response_model.dart';
import 'package:http/http.dart' as http;

class StoriesProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  StoriesProvider({required this.authRepository});

  bool isLoadingStories = false;

  Future<StoriesResponseModel> getStories() async {
    isLoadingStories = true;
    final user = await authRepository.getUser();

    final response = await http.get(
      Uri.parse('${Variables.urlBase}/stories'),
      headers: {
        'Authorization': 'Bearer ${user!.loginResult!.token}',
      },
    );
    if (response.statusCode == 200) {
      isLoadingStories = false;
      notifyListeners();
      return StoriesResponseModel.fromJson(response.body);
    } else {
      isLoadingStories = false;
      notifyListeners();
      return StoriesResponseModel.fromJson(response.body);
    }
  }

  Future<StoriesDetailResponseModel> getStoriesDetail(String id) async {
    isLoadingStories = true;
    final user = await authRepository.getUser();

    final response =
        await http.get(Uri.parse('${Variables.urlBase}/stories/$id'), headers: {
      'Authorization': 'Bearer ${user!.loginResult!.token}',
    });
    if (response.statusCode == 200) {
      isLoadingStories = false;
      notifyListeners();
      return StoriesDetailResponseModel.fromJson(response.body);
    } else {
      isLoadingStories = false;
      notifyListeners();
      return StoriesDetailResponseModel.fromJson(response.body);
    }
  }
}
