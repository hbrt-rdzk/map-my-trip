import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mapmytrip/screens/profile/login.dart';
import 'package:mapmytrip/screens/profile/register.dart';

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> anonLogin(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {}
  }

  Future<void> logIn(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProfileLogin()));
  }

  Future<void> signIn(BuildContext context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ProfileRegister()));
  }

  Future<void> googleSignIn(BuildContext context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return;
      }

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {}
  }

  Future<void> anonSignOut(BuildContext context) async {
    FirebaseAuth.instance.signOut();
  }
}
