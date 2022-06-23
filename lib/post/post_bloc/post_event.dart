part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetPostEvent extends PostEvent {
  final int page;
  final int limit;
  const GetPostEvent({required this.page,required this.limit});
}
