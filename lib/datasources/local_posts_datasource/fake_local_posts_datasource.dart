import 'package:flutter_cc1/core/errors/illigal_arguments_exception.dart';
import 'package:flutter_cc1/core/errors/not_found_exception.dart';
import 'package:flutter_cc1/datasources/local_posts_datasource/local_posts_datasource.dart';
import 'package:flutter_cc1/models/post.model.dart';

class FakeLocalPostsDataSource extends LocalPostsDataSource {
  final Map<int, PostModel> inMemoryPosts = {
    1: const PostModel(
      title: 'Flutter: A Guide for Beginners',
      description:
          'Learn the basics of Flutter, a powerful UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
    ),
    2: const PostModel(
      title: 'The Future of Artificial Intelligence',
      description:
          'Explore how AI is transforming industries, from healthcare to transportation, and what the future holds for this rapidly advancing technology.',
    ),
    3: const PostModel(
      title: 'Top 10 Travel Destinations in 2024',
      description:
          'From the breathtaking beaches of Bali to the historic streets of Rome, discover the top travel destinations to add to your bucket list this year.',
    ),
    4: const PostModel(
      title: 'Mastering Dart Programming',
      description:
          'Dart is the language behind Flutter. Learn its key features, syntax, and why it’s a great choice for modern app development.',
    ),
    5: const PostModel(
      title: 'How to Stay Productive While Working Remotely',
      description:
          'Remote work can be challenging. Discover tips and tools to maintain productivity and balance when working from home.',
    ),
  };

  int _nextId() => (inMemoryPosts.keys.isEmpty
      ? 1
      : inMemoryPosts.keys.reduce((a, b) => a > b ? a : b) + 1);

  @override
  Future<Map<int, PostModel>> getAll() async {
    return inMemoryPosts;
  }

  @override
  Future<PostModel?> getOne(int postId) async {
    return inMemoryPosts[postId];
  }

  @override
  Future<void> create(PostModel post) async {
    if (post.title.isEmpty || post.description.isEmpty) {
      throw IllegalArgumentException(' title and description cannot be empty');
    }
    final newId = _nextId();
    inMemoryPosts[newId] = post;
  }

  @override
  Future<void> update(int postId, {String? title, String? description}) async {
    final existingPost = inMemoryPosts[postId];
    if (existingPost == null) {
      throw PostNotFoundException('Post $postId not found');
    }

    final updatedPost = existingPost.copyWith(
      title: title ?? existingPost.title,
      description: description ?? existingPost.description,
    );
    inMemoryPosts[postId] = updatedPost;
  }

  @override
  Future<void> delete(int postId) async {
    if (!inMemoryPosts.containsKey(postId)) {
      throw PostNotFoundException('Post $postId not found');
    }
    inMemoryPosts.remove(postId);
  }
}
