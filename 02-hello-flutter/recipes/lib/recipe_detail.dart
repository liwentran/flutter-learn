import 'package:flutter/material.dart';
import 'recipe.dart';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;

  // initializer that takes the recipe details to display
  const RecipeDetail({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  _RecipeDetailState createState() {
    return _RecipeDetailState();
  }
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _sliderVal = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
      ),
      body: SafeArea(
        // keeps app from getting close to operating system interfaces
        child: Column(
          children: <Widget>[
            SizedBox(
              // around image that defines resizable bounds for the image.
              height: 300,
              width: double.infinity,
              // fixed height but width ill adjust to fit the aspect ratio
              child: Image(
                image: AssetImage(widget.recipe.imageURL),
              ),
            ),

            const SizedBox(
              height: 4,
            ),
            // spacer

            Text(
              widget.recipe.label,
              style: const TextStyle(fontSize: 18),
            ),

            // expanded widget expands to fill the space in the column so that
            //it will take up the space not filled by the other widgets
            Expanded(
              child: ListView.builder(
                // one row per ingredient
                padding: const EdgeInsets.all(7.0),
                itemCount: widget.recipe.ingredients.length,
                itemBuilder: (BuildContext context, int index) {
                  final ingredient = widget.recipe.ingredients[index];
                  // TODO: Add ingredient quantity
                  // uses string interpolation to populate a string with runtime values
                  //${expression} syntax to denote these
                  return Text(
                      '${ingredient.quantity * _sliderVal} ${ingredient.measure} ${ingredient.name}');
                },
              ),
            ),

            Slider(
              // use min, max, and divisions to define how it moves
              min: 1,
              max: 10,
              divisions: 9,
              // label displays a scaled number of servings
              label: '${_sliderVal * widget.recipe.servings} servings',
              // slider works in double, so this converts to the int variable
              value: _sliderVal.toDouble(),
              // saves in _sliderval
              onChanged: (newValue) {
                setState(() {
                  _sliderVal = newValue.round();
                });
              },
              // activeColor is the section between min val and thumb
              activeColor: Colors.green,
              inactiveColor: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
