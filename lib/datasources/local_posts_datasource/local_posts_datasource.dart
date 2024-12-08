import 'package:flutter_cc1/models/post.model.dart';

abstract class LocalPostsDataSource {
  Future<Map<int, PostModel>> getAll();

  Future<PostModel?> getOne(int postId);

  Future<void> create(PostModel post);

  Future<void> update(int postId, {String? title, String? description});

  Future<void> delete(int postId);
}
