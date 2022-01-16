import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'empty_grocery_screen.dart';
import 'grocery_item_screen.dart';
import 'grocery_list_screen.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // returns the GroceryManager available in this tree
          final manager = Provider.of<GroceryManager>(context, listen: false);
          // new route to the stack of routes
          Navigator.push(
            context,
            // Replaces screen with platform-specific transition
            MaterialPageRoute(
              // Creates new screen within the route's builder callback
              builder: (context) => GroceryItemScreen(
                // defines what to do with the created item
                onCreate: (item) {
                  // adds this new item to the list of items
                  manager.addItem(item);
                  // removes the top navigation route item, GroceryItemScreen,
                  // to show the list of grocery items
                  Navigator.pop(context);
                },
                // will never get called since you are creating a new item
                onUpdate: (item) {},
              ),
            ),
          );
        },
      ),
      // 7
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    // consumer will listen to changes to GroceryManager
    return Consumer<GroceryManager>(
      builder: (context, manager, child) {
        if (manager.groceryItems.isNotEmpty) {
          return GroceryListScreen(manager: manager);
        } else {
          return const EmptyGroceryScreen();
        }
      },
    );
  }
}
