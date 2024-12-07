part of 'post_details_bloc.dart';

@immutable
sealed class PostDetailsEvent {}


final class LoadPostDetails extends PostDetailsEvent {
  final int postId ;
  LoadPostDetails({required this.postId});
}