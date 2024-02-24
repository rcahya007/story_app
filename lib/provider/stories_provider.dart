import 'package:flutter/material.dart';
import 'package:story_app/core/variables.dart';
import 'package:story_app/db/auth_repository.dart';
import 'package:story_app/model/response/stories_detail_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/model/response/stories_response_model.dart';

class StoriesProvider with ChangeNotifier {
  final AuthRepository authRepository;
  StoriesProvider({required this.authRepository}) {
    getStories();
  }

  bool isLoadingStories = false;
  List<ListStory> _dataStories = [];

  List<ListStory> get dataStories => _dataStories;

  Future<void> getStories() async {
    isLoadingStories = true;
    notifyListeners();
    final user = await authRepository.getUser();

    final response = await http.get(
      Uri.parse('${Variables.urlBase}/stories'),
      headers: {
        'Authorization': 'Bearer ${user!.loginResult!.token}',
      },
    );
    if (response.statusCode == 200) {
      isLoadingStories = false;
      _dataStories = StoriesResponseModel.fromJson(response.body).listStory!;
      notifyListeners();
    } else {
      isLoadingStories = false;
      _dataStories = [];
      notifyListeners();
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
