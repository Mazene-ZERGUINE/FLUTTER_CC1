import 'package:flutter/material.dart';

class PostListItem extends StatelessWidget {
  final int postId;
  final String postTitle;
  final String postDescription;
  final VoidCallback onTap;

  const PostListItem({
    super.key,
    required this.postId,
    required this.postTitle,
    required this.postDescription,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
