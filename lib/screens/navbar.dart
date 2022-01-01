import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/chat.dart';
import '../screens/home.dart';
import '../screens/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[Profile(), Home(), Chat()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.person), label: profileTitle),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: homeTitle),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: chatTitle),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
