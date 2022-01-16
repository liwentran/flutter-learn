import 'package:flutter/material.dart';

// extending allows the object to provide change notification to its listeners
class TabManager extends ChangeNotifier {
  int selectedTab = 0;

  // modifies the tab index
  void goToTab(index) {
    selectedTab = index;
    // notifies widgets listening to this state
    notifyListeners();
  }

// sets selectedTab to 1
  void goToRecipes() {
    selectedTab = 1;
    notifyListeners();
  }
}
