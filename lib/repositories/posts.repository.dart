import 'package:flutter_cc1/core/errors/app_exception.dart';
import 'package:flutter_cc1/core/errors/not_found_exception.dart';
import 'package:flutter_cc1/datasources/local_posts_datasource/local_posts_datasource.dart';
import 'package:flutter_cc1/models/post.model.dart';

class PostsRepository {
  final LocalPostsDataSource localPostsDataSource;

  const PostsRepository({required this.localPostsDataSource});

  Future<Map<int, PostModel>> getAllPosts() async {
    return await localPostsDataSource.getAll();
  }

  Future<PostModel> getPost(int postId) async {
    try {
      final post = await localPostsDataSource.getOne(postId);
      if (post == null) {
        throw PostNotFoundException('post $postId not found');
      }
      return post;
    } catch (error) {
      throw AppException('Error occured while post $postId from datasource');
    }
  }

  Future<void> createPost(PostModel post) async {
    try {
      await localPostsDataSource.create(post);
    } catch (error) {
      throw AppException('Error occured while creating new post');
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      final post = await localPostsDataSource.getOne(postId);
      if (post == null) {
        throw PostNotFoundException('post $postId not found');
      }
      await localPostsDataSource.delete(postId);
    } catch (error) {
      throw AppException('Error occured while creating new post');
    }
  }

  Future<void> updatePost(int postId,
      {String? title, String? description}) async {
    try {
      final post = await localPostsDataSource.getOne(postId);
      if (post == null) {
        throw PostNotFoundException('post $postId not found');
      }
      await localPostsDataSource.update(postId,
          title: title, description: description);
    } catch (error) {
      throw AppException('Error occured while creating new post');
    }
  }
}
