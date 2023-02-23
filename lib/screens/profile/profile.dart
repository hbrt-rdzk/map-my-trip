import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapmytrip/services/auth.dart';
import 'package:mapmytrip/services/firestore.dart';
import 'package:mapmytrip/services/models.dart';
import 'package:mapmytrip/services/profile_options.dart';
import 'package:mapmytrip/widgets/error.dart';
import 'package:mapmytrip/widgets/loading.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool? _isAnonymousUser;

  @override
  void initState() {
    _isAnonymousUser = FirebaseAuth.instance.currentUser?.isAnonymous;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Profile'),
          backgroundColor: Colors.green,
        ),
        body: Builder(builder: (BuildContext context) {
          if (_isAnonymousUser == true) {
            return const AnonymousUser();
          } else {
            return SignedUser();
          }
        }));
  }
}

class SignedUser extends StatelessWidget {
  SignedUser({super.key});

  @override
  Widget build(BuildContext context) {
    var user = AuthService().user;
    var email = user!.email;
    email ??= 'default';

    return FutureBuilder(
        future: FirestoreService().getUser(email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
                child: ErrorMessage(message: snapshot.error.toString()));
          } else if (snapshot.hasData) {
            var userData = snapshot.data!;
            return Column(
              children: [
                const ProfilePicture(),
                EditProfileButton(
                    icon: FontAwesomeIcons.brush,
                    text: 'Edit Account',
                    function: goToProfileEdition,
                    email: email!,
                    user: userData),
                ProfileButton(
                    icon: FontAwesomeIcons.bell,
                    text: 'Notifications',
                    function: goToInfoScreen),
                ProfileButton(
                    icon: FontAwesomeIcons.gear,
                    text: 'Settings',
                    function: goToInfoScreen),
                ProfileButton(
                    icon: FontAwesomeIcons.info,
                    text: 'Info',
                    function: goToInfoScreen),
                ProfileButton(
                  icon: FontAwesomeIcons.doorClosed,
                  text: 'Log out',
                  function: logOut,
                ),
              ],
            );
          } else {
            return const Text(
                'No topics found in firestore, try checking your database');
          }
        });
  }
}

class AnonymousUser extends StatelessWidget {
  const AnonymousUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: const Color.fromARGB(255, 18, 103, 21), width: 2),
        ),
        child: TextButton(
          child: const Text(
            "Anonymous account, sign in",
            style: TextStyle(color: Color.fromARGB(255, 18, 103, 21)),
          ),
          onPressed: () async {
            await AuthService().anonSignOut(context);
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  ProfileButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.function});
  IconData icon;
  String text;
  Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 234, 234),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.greenAccent,
                size: 20,
              ),
              const SizedBox(
                width: 22,
              ),
              Expanded(
                  child: Text(
                text,
                style: const TextStyle(color: Colors.grey),
              )),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              )
            ],
          ),
          onPressed: () async {
            function(context);
          },
        ),
      ),
    );
  }
}

class EditProfileButton extends ProfileButton {
  EditProfileButton(
      {super.key,
      required super.icon,
      required super.text,
      required super.function,
      required this.user,
      required this.email});
  UserData user;
  String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 234, 234),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.greenAccent,
                size: 20,
              ),
              const SizedBox(
                width: 22,
              ),
              Expanded(
                  child: Text(
                text,
                style: const TextStyle(color: Colors.grey),
              )),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              )
            ],
          ),
          onPressed: () async {
            function(context, user, email);
          },
        ),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Center(
        child: SizedBox(
            height: 115,
            width: 115,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/default_user.png"),
            )),
      ),
    );
  }
}
