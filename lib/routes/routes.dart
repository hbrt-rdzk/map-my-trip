import 'package:mapmytrip/screens/start.dart';
import 'package:mapmytrip/screens/login.dart';
import 'package:mapmytrip/screens/profile/profile.dart';
import 'package:mapmytrip/screens/map.dart';

var appRoutes = {
  '/': (context) => const StartScreen(),
  '/login': (context) => const LoginScreen(),
  '/map': (context) => const MapScreen(),
  '/profile': (context) => const ProfileScreen(),
};
