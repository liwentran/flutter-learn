import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO 3: Replace and add layout widgets
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gives the child the ability to fill the available space
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/fooderlich_assets/empty_list.png'),
              ),
            ),

            Text(
              'No Grocceries',
              style: Theme.of(context).textTheme.headline6,
            ),

            const SizedBox(height: 16),

            const Text(
              'Shopping for ingredients?\n'
              'Tap the + button to write them down!',
              textAlign: TextAlign.center,
            ),

            MaterialButton(
              textColor: Colors.white,
              child: const Text('Browse Recipes'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.green,
              onPressed: () {
                // access the model object and sets th index. Notifies Consumer
                // to rebuild home
                Provider.of<TabManager>(context, listen: false).goToRecipes();
              },
            ),
          ],
        ),
      ),
    );
  }
}
