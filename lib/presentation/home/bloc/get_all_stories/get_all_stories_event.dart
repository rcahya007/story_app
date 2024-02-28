part of 'get_all_stories_bloc.dart';

@freezed
class GetAllStoriesEvent with _$GetAllStoriesEvent {
  const factory GetAllStoriesEvent.started() = _Started;
  const factory GetAllStoriesEvent.getAllStories() = _GetAllStories;
}
