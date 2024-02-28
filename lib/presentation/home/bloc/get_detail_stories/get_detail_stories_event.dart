part of 'get_detail_stories_bloc.dart';

@freezed
class GetDetailStoriesEvent with _$GetDetailStoriesEvent {
  const factory GetDetailStoriesEvent.started() = _Started;
  const factory GetDetailStoriesEvent.getDetailStories(String id) =
      _GetDetailStories;
}
