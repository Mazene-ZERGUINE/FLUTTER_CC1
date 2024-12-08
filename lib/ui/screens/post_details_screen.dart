import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cc1/core/utils/snackbar_utils.dart';
import 'package:flutter_cc1/ui/blocs/posts_bloc/posts_bloc.dart';

import '../../models/post.model.dart';
import '../blocs/posts_details_bloc/post_details_bloc.dart';

class PostDetailsScreen extends StatefulWidget {
  final int? postId;

  const PostDetailsScreen({super.key, this.postId});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  bool _hasHandledState = false;

  @override
  void initState() {
    super.initState();
    if (widget.postId != null) {
      context
          .read<PostDetailsBloc>()
          .add(LoadPostDetails(postId: widget.postId!));
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _createOrUpdatePost() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      showSnackBar(context, 'Title or description can not be empty', backgroundColor: Colors.red);
      return;
    }
    if (widget.postId == null) {
      context.read<PostDetailsBloc>().add(
            CreateNewPost(
              newPost: PostModel(title: title, description: description),
            ),
          );
    } else {
      context.read<PostDetailsBloc>().add(
            UpdatePost(
              postId: widget.postId!,
              title: title,
              description: description,
            ),
          );
    }
  }


  void _handelPostCreatedWithSuccess(PostDetailsState state) {
    String message = state is PostCreatedSuccess
        ? 'Post created successfully!'
        : 'Post updated successfully!';
    showSnackBar(context, message);
    Navigator.pushNamed(context, '/');
    context.read<PostsBloc>().add(LoadPosts());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          widget.postId == null ? 'Add New Post' : 'Edit Post',
          style: const TextStyle(
            color: Colors.blueGrey,
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: widget.postId == null
          ? _buildForm()
          : BlocBuilder<PostDetailsBloc, PostDetailsState>(
              builder: (context, state) {
                if (state is PostDetailsInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostDetailsLoadedSuccess) {
                  final post = state.post;
                  _titleController = TextEditingController(text: post.title);
                  _descriptionController =
                      TextEditingController(text: post.description);
                  return _buildForm();
                } else if (state is PostDetailsLoadedError) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }
                return const Center(
                  child: Text(
                    'Something went wrong!',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildWrapper({required Widget child}) {
    return Card(
      color: const Color(0xFF1C1C1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.postId != null)
            _buildWrapper(
              child: Row(
                children: [
                  const Text(
                    'Post:',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.postId}',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          _buildWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Title',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _titleController,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          BlocConsumer<PostDetailsBloc, PostDetailsState>(
            listener: (context, state) {
              if (_hasHandledState) return; // Skip if already handled
              if (state is PostCreatedSuccess || state is PostUpdatedSuccess) {
                _hasHandledState = true; // Mark as handled
                _handelPostCreatedWithSuccess(state);
              } else if (state is PostCreatedError || state is PostUpdatedError) {
                _hasHandledState = true; // Mark as handled
                showSnackBar(context, 'Error occurred', backgroundColor: Colors.red);
              }
            },
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _createOrUpdatePost();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    widget.postId == null ? 'Add New Post' : 'Save Changes',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
