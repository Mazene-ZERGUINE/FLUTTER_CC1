import 'dart:math';

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
    on<CreateNewPost>((event, emit) {
      _createPost(event.newPost);
    });
    on<UpdatePost>((event, emit) {
      _updatePost(event.postId, event.title, event.description);
    });
    on<DeletePost>((event, emit) {
      _deletePost(event.postId);
    });
    on<ResetState>((event, emit) {
      emit(PostDetailsInitial());
    });
  }

  Future<void> _loadPostDetails(int postId) async {
    try {
      PostModel? post = await postsRepository.getPost(postId);
      emit(PostDetailsLoadedSuccess(postId: postId, post: post));
    } catch (error) {
      emit(PostDetailsLoadedError(
          exception: PostNotFoundException(),
          errorMessage: 'Post $postId is no longer available'));
    }
  }

  Future<void> _createPost(PostModel post) async {
    try {
      await postsRepository.createPost(post);
      if (state is! PostCreatedSuccess) {
        emit(PostCreatedSuccess());
      }
    } catch (error) {
      emit(PostCreatedError(
          exception: AppException(),
          errorMessage: 'Error while creating new post'));
    }
  }

  Future<void> _updatePost(int postId, String? title,
      String? description) async {
    try {
      await postsRepository.updatePost(postId,
          title: title, description: description);
      if (state is! PostUpdatedSuccess) {
        emit(PostUpdatedSuccess());
      }
    } catch (error) {
      emit(PostUpdatedError(
          exception: AppException(),
          errorMessage: 'Error while updating post $postId'));
    }
  }

  Future<void> _deletePost(int postId) async {
    try {
      await postsRepository.deletePost(postId);
      emit(PostDeletedSuccess());
    } catch (error) {
      emit(PostDeletedError(
          exception: AppException(),
          errorMessage: 'Error while deleting post $postId'));
    }
  }
}
