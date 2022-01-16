import 'package:flutter/material.dart';
import 'grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  // only this manager can control the private array of GroceryItems
  final _groceryItems = <GroceryItem>[];

  // public getter method for groceryItems, which is unmodifiable
  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  // deletes an item at a particular index
  void deleteItem(int index) {
    _groceryItems.removeAt(index);
    notifyListeners();
  }

  // add new grocery item at the end of the list
  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    notifyListeners();
  }

  // toggles the isComplete flag on and off
  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}
