import 'package:flutter/material.dart';
import 'package:mapmytrip/screens/profile/edit.dart';
import 'package:mapmytrip/screens/profile/info.dart';
import 'package:mapmytrip/services/auth.dart';
import 'package:mapmytrip/services/models.dart';

void logOut(BuildContext context) {
  AuthService().anonSignOut(context).then((value) {
    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
  });
}

void goToProfileEdition(BuildContext context, UserData user, String email) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileEdit(user: user, email: email)));
}

void goToInfoScreen(context) {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => InfoScreen()));
}
