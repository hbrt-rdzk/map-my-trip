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
            FontAwesomeIcons.graduationCap,
            size: 20,
          ),
          label: 'Topics',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.barsProgress,
            size: 20,
          ),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.person,
            size: 20,
          ),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FontAwesomeIcons.bolt,
            size: 20,
          ),
          label: 'About',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.orange[200],
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
          widget.currentIndex(index);
        });
      },
    );
  }
}
