import 'dart:async';
import 'package:flutter/material.dart';

// constants for each tab
class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

class AppStateManager extends ChangeNotifier {
  // checks if app is initialized
  bool _initialized = false;

  // checks if user is logged in
  bool _loggedIn = false;

  // checks if onboarding is completed
  bool _onBoardingComplete = false;
// tracks which tab the user is on
  int _selectedTab = FooderlichTab.explore;

  // getter methods. These properties cannot be changed outside this manager.
// Important for unidirectional flow architecture
// states can only be changed via functions
  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onBoardingComplete;
  int get getSelectedTab => _selectedTab;

  void initializeApp() {
    // set a delay timer for 2 sec before closure.
    // this simulates how long the splash screen will display after app launch
    // in a real app, you would call the server to get feature flags/app config
    Timer(
      const Duration(milliseconds: 2000),
      () {
        _initialized = true;
        notifyListeners();
      },
    );
  }

  // in a real scenario, you'd make an API request to log in. This is mock
  void login(String username, String password) {
    _loggedIn = true;
    notifyListeners();
  }

  void completeOnboarding() {
    _onBoardingComplete = true;
    notifyListeners();
  }

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() {
    _selectedTab = FooderlichTab.recipes;
    notifyListeners();
  }

  void logout() {
    // reset app state properties
    _loggedIn = false;
    _onBoardingComplete = false;
    _initialized = false;
    // reinitialize app
    initializeApp();
    notifyListeners();
  }
}
