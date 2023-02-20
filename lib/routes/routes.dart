import 'package:mapmytrip/screens/start.dart';
import 'package:mapmytrip/screens/login.dart';
import 'package:mapmytrip/screens/profile.dart';
import 'package:mapmytrip/screens/topics.dart';

var appRoutes = {
  '/': (context) => const StartScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen()
};
