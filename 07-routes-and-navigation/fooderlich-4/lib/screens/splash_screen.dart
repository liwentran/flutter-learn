import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class SplashScreen extends StatefulWidget {
  // a staic method to create a MaterialPage that sets the appropriate
  // unique identifier and creates SpashScreen
  static MaterialPage page() {
    return MaterialPage(
      name: FooderlichPages.splashPath,
      child: const SplashScreen(),
    );
  }

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // use the context to retrieve the AppStateManager to initialize the app
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              height: 200,
              image: AssetImage('assets/fooderlich_assets/rw_logo.png'),
            ),
            const Text('Initializing...'),
          ],
        ),
      ),
    );
  }
}
