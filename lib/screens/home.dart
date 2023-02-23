import 'package:flutter/material.dart';
import 'package:mapmytrip/screens/profile/profile.dart';
import 'package:mapmytrip/screens/trips.dart';
import 'package:mapmytrip/screens/map.dart';
import 'package:mapmytrip/widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _myWidgets = [
    const MapScreen(),
    const TripsScreen(),
    const ProfileScreen(),
  ];
  int _index = 0;
  late BottomNavBar bottomNavBar;

  @override
  void initState() {
    bottomNavBar = BottomNavBar(currentIndex: (i) {
      setState(() {
        _index = i;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      body: _myWidgets[_index],
    );
  }
}
