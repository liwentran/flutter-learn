import 'package:flutter/material.dart';
import 'recipe.dart';
import 'recipe_detail.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({Key? key}) : super(key: key);

  // This widget is the root of your application. The entry point for composing together other widgets to make a new widget.
  @override // tells Dart Analyzer that this method is supposed to replace the default method from StatelessWidget
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(); // shows standard Material defaults
    return MaterialApp(
      // uses Material Design and is the widget that will be included in RecipeApp
      title:
          'Recipe Calculator', // UI will not display this. Just a description that the device will use for identification
      theme: theme.copyWith(
        // copies the theme and replaces color scheme.
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.grey,
          secondary: Colors.black,
        ),
      ),
      home: const MyHomePage(
          title:
              'Recipe Calculator'), // still uses the same MyHomePage widget but with a new title that is displayed
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // high-level structure for a screen
      appBar: AppBar(
        title: Text(widget
            .title), // gets a title property by using a text widget that has title passed from home: MyHomePage(title: 'Recipe Calculator')
      ),
      body: SafeArea(
        child: ListView.builder(
          // builds a list using Listview
          itemCount: Recipe.samples.length,
          // determines # of rows the list has. Length = number of objects in Recipe.samples list
          itemBuilder: (BuildContext context, int index) {
            // builds the widget tree for each row
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // callback called when widget is tapped
                Navigator.push(
                  // manages a stack of pages
                  context,
                  MaterialPageRoute(
                    // pushes a new material page onto the stack
                    builder: (context) {
                      // creates the destination page widget
                      return RecipeDetail(recipe: Recipe.samples[index]);
                    },
                  ),
                );
              },
              // 11
              child: buildRecipeCard(Recipe.samples[index]),
              // defines the area where the gesture is active
              // use the custom Card widget for each recipe in the samples list
            );
          },
        ),
      ),
    );
  }
}

Widget buildRecipeCard(Recipe recipe) {
  return Card(
    elevation:
        2.0, // determines how high off the screen the card is, affecting its shadow
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)), // shape of the card

    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        // a widget that defines a vertical layout
        children: <Widget>[
          // Column has two children
          Image(
              image: AssetImage(recipe
                  .imageURL)), // AssetImage states that the image is fetched from the local asset bundle defined in pubspec.yaml
          const SizedBox(
            // between image and text, this is a blank view with a fixed size
            height: 16.0,
          ),
          Text(recipe.label,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'Palatino',
              )),
        ],
      ),
    ),
  );
}
