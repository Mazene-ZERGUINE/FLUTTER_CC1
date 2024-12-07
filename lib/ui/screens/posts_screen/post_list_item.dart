import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cc1/ui/screens/post_details_screen.dart';

import '../../../repositories/posts.repository.dart';
import '../../blocs/posts_details_bloc/post_details_bloc.dart';

class PostListItem extends StatelessWidget {
  final int postId;
  final String postTitle;
  final String postDescription;

  const PostListItem({
    super.key,
    required this.postId,
    required this.postTitle,
    required this.postDescription,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => PostDetailsBloc(
                postsRepository: RepositoryProvider.of<PostsRepository>(context),
              )..add(LoadPostDetails(postId: postId)),
              child: PostDetailsScreen(postId: postId),
            ),
          ),
        );
      },
      child: Card(
        color: const Color(0xFF1C1C1E),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        shadowColor: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.article,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      postTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_ios,
                      color: Colors.grey, size: 18),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                postDescription,
                style: const TextStyle(
                    fontSize: 16, color: Colors.grey, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
