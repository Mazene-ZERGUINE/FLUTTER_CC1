import 'package:flutter/material.dart';
import 'package:flutter_cc1/models/post.model.dart';

class PostDetailsScreen extends StatelessWidget {
  final int postId;
  final PostModel post;

  const PostDetailsScreen({super.key, required this.postId, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Posts List',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 32,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Post ID: $postId',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              post.title,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              post.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
