import 'package:flutter_cc1/models/post.model.dart';

abstract class LocalPostsDataSource {
  Future<Map<int ,PostModel>> getAll();
}
