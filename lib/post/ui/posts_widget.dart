import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/post_model.dart';
import '../post_bloc/post_bloc.dart';

class GetPostsWidget extends StatefulWidget {
  const GetPostsWidget({Key? key}) : super(key: key);
  @override
  State<GetPostsWidget> createState() => _GetPostsWidgetState();
}

class _GetPostsWidgetState extends State<GetPostsWidget> {
  List<PostModel> items = [];
  final scrollController = ScrollController();
  int page = 1;
  bool hasMore = true;
  int limit = 15;
  @override
  void initState() {
    // birinchi martta page ochilganda ishlidi
    BlocProvider.of<PostBloc>(context).add(GetPostEvent(page: page,limit: limit));
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        page++;
        // bu esa scroll bo'lganda ishlidi
        BlocProvider.of<PostBloc>(context).add(GetPostEvent(page: page,limit: limit));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostSuccess || state is PostPeginationLoading) {
          if (state is PostSuccess) {
            state.data.length < limit ? hasMore = false : "";
            items.addAll(state.data.map<PostModel>((e) => e));
          }
          return _refreshIndicator(
              child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        height: 10.0,
                        color: Colors.blue,
                      ),
                  controller: scrollController,
                  itemCount: items.length + 1,
                  itemBuilder: (context, index) {
                    if (index < items.length) {
                      return ListTile(title: Text('Items: ${items[index].id}'));
                    } else {
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: hasMore
                                ? const CircularProgressIndicator()
                                : const Center(child: Text("No More Data...")),
                          ));
                    }
                  }));
        } else {
          return _refreshIndicator(
              child: ListView(
            scrollDirection: Axis.vertical,
            children: const [
              Center(child: Text("Something went wrong....")),
            ],
          ));
        }
      },
    );
  }

  _refreshIndicator({required Widget child}) {
    return RefreshIndicator(
        onRefresh: (() async {
          hasMore = true;
          page = 1;
          items.clear();
          BlocProvider.of<PostBloc>(context).add(GetPostEvent(page: page,limit: limit));
        }),
        child: child);
  }
}
