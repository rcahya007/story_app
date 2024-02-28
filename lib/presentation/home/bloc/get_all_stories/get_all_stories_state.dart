part of 'get_all_stories_bloc.dart';

@freezed
class GetAllStoriesState with _$GetAllStoriesState {
  const factory GetAllStoriesState.initial() = _Initial;
  const factory GetAllStoriesState.loading() = _Loading;
  const factory GetAllStoriesState.loaded(StoriesResponseModel data) = _Loaded;
  const factory GetAllStoriesState.error(String message) = _Error;
}
