import 'package:flutter/material.dart';
import 'package:flutter_cc1/models/post.model.dart';
import 'package:flutter_cc1/ui/screens/posts_screen/post_list_item.dart';

class PostsScreen extends StatelessWidget {
  final List<PostModel> posts = [
    const PostModel(
      title: 'Flutter: A Guide for Beginners',
      description:
          'Learn the basics of Flutter, a powerful UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
    ),
    const PostModel(
      title: 'The Future of Artificial Intelligence',
      description:
          'Explore how AI is transforming industries, from healthcare to transportation, and what the future holds for this rapidly advancing technology.',
    ),
    const PostModel(
      title: 'Top 10 Travel Destinations in 2024',
      description:
          'From the breathtaking beaches of Bali to the historic streets of Rome, discover the top travel destinations to add to your bucket list this year.',
    ),
    const PostModel(
      title: 'Mastering Dart Programming',
      description:
          'Dart is the language behind Flutter. Learn its key features, syntax, and why it’s a great choice for modern app development.',
    ),
    const PostModel(
      title: 'How to Stay Productive While Working Remotely',
      description:
          'Remote work can be challenging. Discover tips and tools to maintain productivity and balance when working from home.',
    ),
  ];

  PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostListItem(post: posts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
