import 'package:bloc_timer/post/ui/posts_widget.dart';
import 'package:flutter/material.dart';

class Pegination extends StatelessWidget {
  const Pegination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pegination"),
        centerTitle: true,
      ),
      body: const GetPostsWidget(),
    );
  }
}