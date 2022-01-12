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
      // ExploreData instance will have two lists: todayRecipes and friendPosts
      future: mockService.getExploreData(),
      // snapshot used to check the current state of the Future
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        // TODO: Add Nested List Views
        if (snapshot.connectionState == ConnectionState.done) {
          // snapshot.data returns ExploreData, which can be extracted
          final recipes = snapshot.data?.todayRecipes ?? [];
          // TODO: Replace with TodayRecipeListView
          return Center(
            child: Container(
              child: const Text('Show TodayRecipeListView'),
            ),
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
