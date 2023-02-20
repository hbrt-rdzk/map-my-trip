import 'package:flutter/material.dart';
import 'package:mapmytrip/screens/login.dart';
import 'package:mapmytrip/screens/home.dart';
import 'package:mapmytrip/services/auth.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        } else if (snapshot.hasError) {
          return const Text('error');
        } else if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
