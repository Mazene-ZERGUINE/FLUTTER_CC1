import 'package:flutter_cc1/models/post.model.dart';

abstract class LocalPostsDataSource {
  Future<Map<int ,PostModel>> getAll();
  Future<PostModel?> getOne(int postId) ;
  Future<void> update(PostModel post);
  Future<void> delete(int postId); 
}
