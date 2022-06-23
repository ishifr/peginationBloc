import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/post_model.dart';
import '../data/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository? repository;
  PostBloc(this.repository) : super(PostInitial()) {
    on<GetPostEvent>((event, emit) async {
      event.page > 1 ? emit(PostPeginationLoading()) : emit(PostLoading());
      try {
        var data = await repository!.fetch(page: event.page,limit: event.limit);
        emit(PostSuccess(data: data));
      } catch (ee) {
        emit(PostError());
      }
    });
  }
}
