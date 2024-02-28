import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:story_app/data/datasources/stories_remote_datasource.dart';
import 'package:story_app/data/model/response/stories_detail_response_model.dart';

part 'get_detail_stories_event.dart';
part 'get_detail_stories_state.dart';
part 'get_detail_stories_bloc.freezed.dart';

class GetDetailStoriesBloc
    extends Bloc<GetDetailStoriesEvent, GetDetailStoriesState> {
  final StoriesRemoteDatasource storiesRemoteDatasource;
  GetDetailStoriesBloc(this.storiesRemoteDatasource) : super(const _Initial()) {
    on<_GetDetailStories>((event, emit) async {
      emit(const _Loading());
      final response = await storiesRemoteDatasource.getDetailStories(
        event.id,
      );
      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
