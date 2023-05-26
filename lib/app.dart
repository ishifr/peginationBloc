import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'post/data/post_repository.dart';
import 'post/ui/main_post_page.dart';
import 'post/post_bloc/post_bloc.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => PostBloc(PostRepository()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pagination',
        home: Pegination(),
      ),
    );
  }
}
