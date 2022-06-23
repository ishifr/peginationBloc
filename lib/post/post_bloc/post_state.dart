part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostPeginationLoading extends PostState {}

class PostSuccess extends PostState {
  final List<PostModel> data;
  const PostSuccess({required this.data});
}

class PostError extends PostState {}
