import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cc1/ui/blocs/posts_bloc/posts_bloc.dart';
import 'package:flutter_cc1/ui/screens/post_details_screen.dart';
import 'package:flutter_cc1/ui/screens/posts_screen/post_list_item.dart';

import '../../../repositories/posts.repository.dart';
import '../../blocs/posts_details_bloc/post_details_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final List<bool> _visibleItems = [];

  void _animateItems() async {
    for (int i = 0; i < _visibleItems.length; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        setState(() {
          _visibleItems[i] = true;
        });
      }
    }
  }

  void _redirectToPostDetailsScreen(int? postId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => PostDetailsBloc(
            postsRepository: RepositoryProvider.of<PostsRepository>(context),
          ),
          child: PostDetailsScreen(postId: postId),
        ),
      ),
    );
  }

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
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is PostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostsLoadedSuccess) {
            final posts = state.postsList;
            final postKeys = posts.keys.toList();

            if (_visibleItems.length != posts.length) {
              _visibleItems.clear();
              _visibleItems.addAll(List.generate(posts.length, (_) => false));
              _animateItems();
            }

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final postId = postKeys[index];
                final post = posts[postId]!;

                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _visibleItems[index] ? 1.0 : 0.0,
                  curve: Curves.easeIn,
                  child: PostListItem(
                    postId: postId,
                    postTitle: post.title,
                    postDescription: post.description,
                  ),
                );
              },
            );
          } else if (state is PostsLoadedError) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (state is PostsListEmpty) {
            return const Center(
              child: Text(
                'No posts found!',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }
          return const Center(
            child: Text(
              'something went wrong ??!',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _redirectToPostDetailsScreen(null);
        },
        backgroundColor: Colors.blueGrey,
        child: const Icon(Icons.add, size: 28, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
