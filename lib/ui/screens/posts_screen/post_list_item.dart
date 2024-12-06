import 'package:flutter/material.dart';
import 'package:flutter_cc1/models/post.model.dart';

class PostListItem extends StatelessWidget {
  final PostModel post;

  const PostListItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                // Leading Icon
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.article, // Icon
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    post.title,
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
              post.description,
              style: const TextStyle(
                  fontSize: 16, color: Colors.grey, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
