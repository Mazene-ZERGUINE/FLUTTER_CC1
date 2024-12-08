import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cc1/datasources/local_posts_datasource/fake_local_posts_datasource.dart';
import 'package:flutter_cc1/repositories/posts.repository.dart';
import 'package:flutter_cc1/ui/blocs/posts_bloc/posts_bloc.dart';
import 'package:flutter_cc1/ui/blocs/posts_details_bloc/post_details_bloc.dart';
import 'package:flutter_cc1/ui/screens/posts_screen/posts.screen.dart';
import 'package:flutter_cc1/ui/screens/post_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PostsRepository>(
          create: (context) => PostsRepository(
            localPostsDataSource: FakeLocalPostsDataSource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PostsBloc>(
            create: (context) => PostsBloc(
              postsRepository: RepositoryProvider.of<PostsRepository>(context),
            )..add(LoadPosts()),
          ),
          BlocProvider<PostDetailsBloc>(
            create: (context) => PostDetailsBloc(
              postsRepository: RepositoryProvider.of<PostsRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Posts App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const PostsScreen(),
            '/post-details': (context) {
              final postId = ModalRoute.of(context)!.settings.arguments as int?;
              return PostDetailsScreen(postId: postId);
            },
          },
        ),
      ),
    );
  }
}
