part of 'post_details_bloc.dart';

@immutable
sealed class PostDetailsEvent {}

final class LoadPostDetails extends PostDetailsEvent {
  final int postId;

  LoadPostDetails({required this.postId});
}

final class UpdatePost extends PostDetailsEvent {
  final int postId;
  final String? title;
  final String? description;

  UpdatePost({required this.postId, this.title, this.description});
}

final class CreateNewPost extends PostDetailsEvent {
  final PostModel newPost;

  CreateNewPost({required this.newPost});
}

final class DeletePost extends PostDetailsEvent {
  final int postId;

  DeletePost({required this.postId});
}


final class ResetState extends PostDetailsEvent {}
