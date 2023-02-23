import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapmytrip/services/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(96, 200, 166, 1),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/logo.png',
              ),
              LoginButton(
                  color: Colors.orangeAccent,
                  icon: FontAwesomeIcons.doorOpen,
                  text: "Log in",
                  loginMethod: AuthService().logIn),
              LoginButton(
                color: Colors.orange,
                text: "Continue as guest",
                loginMethod: AuthService().anonLogin,
                icon: FontAwesomeIcons.userNinja,
              ),
              LoginButton(
                color: Colors.blueAccent,
                icon: FontAwesomeIcons.personCirclePlus,
                loginMethod: AuthService().signIn,
                text: "Register account",
              ),
              LoginButton(
                color: Colors.blue,
                text: "Use your Google account",
                loginMethod: AuthService().googleSignIn,
                icon: FontAwesomeIcons.google,
              )
            ],
          ),
        ));
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.text,
      required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
            backgroundColor: color, padding: const EdgeInsets.all(24)),
        onPressed: () => loginMethod(context),
        label: Text(text),
      ),
    );
  }
}
