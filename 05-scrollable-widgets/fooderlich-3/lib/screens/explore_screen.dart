import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';
import '../api/mock_fooderlich_service.dart';

class ExploreScreen extends StatelessWidget {
  // Create MockFooderlichService for mock server responses
  final mockService = MockFooderlichService();

  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // use mock service (returns future)
      // ExploreData instance will have two lists: todayRecipes and friendPosts
      future: mockService.getExploreData(),
      // snapshot used to check the current state of the Future
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        // TODO: Add Nested List Views
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              // snapshot.data returns ExploreData, extract it
              TodayRecipeListView(recipes: snapshot.data?.todayRecipes ?? []),
              const SizedBox(height: 16),
              // TODO: replace this with FriendPostListView
              Container(
                height: 400,
                color: Colors.green,
              ),
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
