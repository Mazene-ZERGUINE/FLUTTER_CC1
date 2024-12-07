import 'package:bloc/bloc.dart';
import 'package:flutter_cc1/core/errors/app_exception.dart';
import 'package:flutter_cc1/models/post.model.dart';
import 'package:flutter_cc1/repositories/posts.repository.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository}) : super(PostsInitial()) {
    on<LoadPosts>(_onLoadPosts);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoading());

    try {
      final Map<int, PostModel> postsList = await postsRepository.getAllPosts();
      await Future.delayed(const Duration(seconds: 1));
      emit(PostsLoadedSuccess(postsList: postsList));
    } catch (e) {
      emit(PostsLoadedError(
        exception: AppException('Error while loading list'),
        errorMessage: e.toString(),
      ));
    }
  }
}
