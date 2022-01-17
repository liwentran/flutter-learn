import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/screens.dart';

// RouterDelegate will tell the router to build and configure a navigator widget
class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  // a unique key across the entire app
  final GlobalKey<NavigatorState> navigatorKey;
  // router will listen
  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    // connect the state managers so that when the state changes, the router
    // will reconfigure the navigator with a new set of pages
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }
  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      // required to retrieve the current navigator
      key: navigatorKey,
      // called every time a page pops from the stack
      onPopPage: _handlePopPage,
      pages: [
        // if the app has not been initialized, show the splash screen
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),
        if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)
          OnboardingScreen.page(),
        if (appStateManager.isOnboardingComplete)
          Home.page(appStateManager.getSelectedTab),
        if (groceryManager.isCreatingNewItem)
          GroceryItemScreen.page(
            onCreate: (item) {
              groceryManager.addItem(item);
            },
            onUpdate: (item, index) {
              // no update
            },
          ),
        if (groceryManager.selectedIndex != -1)
          GroceryItemScreen.page(
            item: groceryManager.selectedGroceryItem,
            index: groceryManager.selectedIndex,
            onUpdate: (item, index) {
              groceryManager.updateItem(item, index);
            },
            onCreate: (_) {
              // no create
            },
          ),
        if (profileManager.didSelectUser)
          ProfileScreen.page(profileManager.getUser),
        if (profileManager.didTapOnRaywenderlich) WebViewScreen.page(),
      ],
    );
  }

  // when the user taps the Back button or triggers a system back button event,
  // it fires a helper method onPopPage
  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }
    // if route pop succeeds, check the different routes and trigger appropriate
    // state changes
    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }
    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }
    if (route.settings.name == FooderlichPages.profilePath) {
      profileManager.tapOnProfile(false);
    }
    if (route.settings.name == FooderlichPages.raywenderlich) {
      profileManager.tapOnRaywenderlich(false);
    }

    return true;
  }

  // set to null since we aren't supporting Flutter web apps yet
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
// this navigator is declarative because instead of telling the navigator what
// to do with push() and pop(), you tell it: when the state is x, render y pages
