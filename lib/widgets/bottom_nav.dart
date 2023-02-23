import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatefulWidget {
  final Function currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.mapLocation,
            size: 20,
          ),
          label: 'Map',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.bookAtlas,
            size: 20,
          ),
          label: 'Your trips',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.personHiking,
            size: 20,
          ),
          label: 'Profile',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      backgroundColor: const Color.fromARGB(255, 234, 234, 234),
      selectedItemColor: Colors.greenAccent,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
          widget.currentIndex(index);
        });
      },
    );
  }
}
