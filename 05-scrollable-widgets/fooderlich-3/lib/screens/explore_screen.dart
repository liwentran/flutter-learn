import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // Create MockFooderlichService for mock server responses
  final mockService = MockFooderlichService();

  late ScrollController _controller;

  // listens to scroll offsets
  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('i am at the bottom');
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print('i am at the top');
    }
  }

  // initializes scroll controller and adds a listener.
  // every time the user scrolls, scrollListener() will get alled
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  // perm. removes the object and is state from the tree
  // memory cleanup includes unsubscribing from streams, disposing animations/
  // controllers.
  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // use mock service (returns future)
      // ExploreData instance will have two lists: todayRecipes and friendPosts
      future: mockService.getExploreData(),

      // snapshot used to check the current state of the Future
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            controller: _controller,
            scrollDirection: Axis.vertical,
            children: [
              // snapshot.data returns ExploreData, extract data from it
              TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
              const SizedBox(height: 16),
              FriendPostListView(friendPosts: snapshot.data?.friendPosts ?? []),
            ],
          );
        } else {
          // the future is still loading. show a spinner
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
