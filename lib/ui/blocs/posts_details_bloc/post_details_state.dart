part of 'post_details_bloc.dart';

@immutable
sealed class PostDetailsState {}

final class PostDetailsInitial extends PostDetailsState {}

final class PostDetailsLoadedSuccess extends PostDetailsState {
  final int postId;
  final PostModel post;
  PostDetailsLoadedSuccess({required this.postId, required this.post});
}

final class PostDetailsLoadedError extends PostDetailsState {
  final AppException exception;
  final String errorMessage;
  PostDetailsLoadedError({required this.exception, required this.errorMessage});
}

