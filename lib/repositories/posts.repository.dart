import 'package:flutter_cc1/core/errors/app_exception.dart';
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
      throw AppException('Error occured while getting posts data from data source');
    }
  }
}