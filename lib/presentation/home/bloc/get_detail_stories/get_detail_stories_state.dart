part of 'get_detail_stories_bloc.dart';

@freezed
class GetDetailStoriesState with _$GetDetailStoriesState {
  const factory GetDetailStoriesState.initial() = _Initial;
  const factory GetDetailStoriesState.loading() = _Loading;
  const factory GetDetailStoriesState.loaded(StoriesDetailResponseModel data) =
      _Loaded;
  const factory GetDetailStoriesState.error(String message) = _Error;
}
