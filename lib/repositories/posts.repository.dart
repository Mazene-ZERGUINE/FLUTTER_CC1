import 'package:flutter_cc1/core/errors/app_exception.dart';
import 'package:flutter_cc1/core/errors/not_found_exception.dart';
import 'package:flutter_cc1/datasources/local_posts_datasource/local_posts_datasource.dart';
import 'package:flutter_cc1/models/post.model.dart';

class PostsRepository {
  final LocalPostsDataSource localPostsDataSource;

  const PostsRepository({required this.localPostsDataSource});

  Future<Map<int, PostModel>> getAllPosts() async {
    try {
      Map<int, PostModel> productsList = await localPostsDataSource.getAll();
      return productsList;
    } catch (error) {
      throw AppException('Error occured while getting posts data from datasource');
    }
  }

  Future<PostModel> getPost(int postId) async {
    try {
      final post = await localPostsDataSource.getOne(postId);
      if (post == null) {
        throw PostNotFoundException('Post $postId not found');
      }
      return post;
    } catch (error) {
      if (error is AppException) rethrow;
      throw AppException('Error occured while post $postId from datasource');
    }
  }
}