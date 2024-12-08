part of 'post_details_bloc.dart';

@immutable
sealed class PostDetailsState {}

// initial
final class PostDetailsInitial extends PostDetailsState {}


// success
final class PostDetailsLoadedSuccess extends PostDetailsState {
  final int postId;
  final PostModel post;
  PostDetailsLoadedSuccess({required this.postId, required this.post});
}
final class PostCreatedSuccess extends PostDetailsState {}
final class PostUpdatedSuccess extends PostDetailsState {}
final class PostDeletedSuccess extends PostDetailsState {}

// Error
final class PostDetailsLoadedError extends PostDetailsState {
  final AppException exception;
  final String errorMessage;
  PostDetailsLoadedError({required this.exception, required this.errorMessage});
}

final class PostCreatedError extends PostDetailsState {
  final AppException exception;
  final String errorMessage;
  PostCreatedError({required this.exception, required this.errorMessage});
}

final class PostUpdatedError extends PostDetailsState {
  final AppException exception;
  final String errorMessage;
  PostUpdatedError({required this.exception, required this.errorMessage});
}

final class PostDeletedError extends PostDetailsState {
  final AppException exception;
  final String errorMessage;
  PostDeletedError({required this.exception, required this.errorMessage});
}
