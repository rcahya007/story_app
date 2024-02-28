import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:story_app/data/datasources/stories_remote_datasource.dart';
import 'package:story_app/data/model/response/stories_response_model.dart';

part 'get_all_stories_bloc.freezed.dart';
part 'get_all_stories_event.dart';
part 'get_all_stories_state.dart';

class GetAllStoriesBloc extends Bloc<GetAllStoriesEvent, GetAllStoriesState> {
  final StoriesRemoteDatasource _storiesRemoteDatasource;
  GetAllStoriesBloc(
    this._storiesRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetAllStories>((event, emit) async {
      emit(const _Loading());
      final response = await _storiesRemoteDatasource.getAllStories();
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
