import 'package:flutter/material.dart';
import 'card1.dart';
import 'card2.dart';
import 'card3.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // keeps track of which tab is currently selected
  // underscore before name indicates that it is private
  int _selectedIndex = 0;

  // define the widgets that will be displayed for each tab
  static List<Widget> pages = <Widget>[
    const Card1(),
    const Card2(),
    const Card3(),
  ];

  // handles tapped bar items
  // set index of the item the user presses
  // notifies the framework that the state of this object has changed, then rebuilds this widget internally
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Fooderlich',
        // Theme.of(context) returns the nearest theme in the widgets tree
        style: Theme.of(context).textTheme.headline6,
      )),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // selection color when tapped
        selectedItemColor: Theme.of(context).textSelectionTheme.selectionColor,
        // tells which tab bar item to highlight
        currentIndex: _selectedIndex,
        // on tap, calls function and updates with correct index
        onTap: _onItemTapped,
        // defining three nav items
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Card',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Card1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Card2',
          ),
        ],
      ),
    );
  }
}
