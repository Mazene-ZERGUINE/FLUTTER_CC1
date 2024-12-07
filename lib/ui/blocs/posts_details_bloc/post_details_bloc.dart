import 'package:bloc/bloc.dart';
import 'package:flutter_cc1/core/errors/app_exception.dart';
import 'package:flutter_cc1/core/errors/not_found_exception.dart';
import 'package:flutter_cc1/models/post.model.dart';
import 'package:flutter_cc1/repositories/posts.repository.dart';
import 'package:meta/meta.dart';

part 'post_details_event.dart';
part 'post_details_state.dart';

class PostDetailsBloc extends Bloc<PostDetailsEvent, PostDetailsState> {
  final PostsRepository postsRepository;

  PostDetailsBloc({required this.postsRepository})
      : super(PostDetailsInitial()) {
    on<LoadPostDetails>((event, emit) {
      _loadPostDetails(event.postId);
    });
  }

  Future<void> _loadPostDetails(int postId) async {
    PostModel? post = await postsRepository.getPost(postId);
    emit(PostDetailsLoadedSuccess(postId: postId, post: post));
  }
}
