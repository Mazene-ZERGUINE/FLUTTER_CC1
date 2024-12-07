part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoadedSuccess extends PostsState {
  final Map<int, PostModel> postsList;

  PostsLoadedSuccess({required this.postsList});
}

class PostsLoadedError extends PostsState {
  final AppException exception;
  final String errorMessage;

  PostsLoadedError({required this.exception, required this.errorMessage});
}
