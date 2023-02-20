import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapmytrip/services/auth.dart';

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
            return const AnonymousAccount();
          } else {
            return SignedUser();
          }
        }));
  }
}

class AnonymousAccount extends StatelessWidget {
  const AnonymousAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color.fromARGB(255, 18, 103, 21), width: 2),
        ),
        child: TextButton(
          child: const Text(
            "Anonymous account, sign in",
            style: TextStyle(color: Color.fromARGB(255, 18, 103, 21)),
          ),
          onPressed: () async {
            await AuthService().anonSignOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
        ),
      ),
    );
  }
}

class SignedUser extends StatelessWidget {
  SignedUser({super.key});

  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      ProfilePicture(),
      ProfileButton(icon: FontAwesomeIcons.brush, text: 'Edit Account'),
      ProfileButton(icon: FontAwesomeIcons.bell, text: 'Notifications'),
      ProfileButton(icon: FontAwesomeIcons.gear, text: 'Settings'),
      ProfileButton(icon: FontAwesomeIcons.info, text: 'Info'),
      ProfileButton(icon: FontAwesomeIcons.doorClosed, text: 'Log out'),
      ],
    ) ;
  }
}

class ProfileButton extends StatelessWidget {
  ProfileButton({super.key, required this.icon, required this.text});
  IconData icon;
  String text;

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
            await AuthService().anonSignOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
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
          height:115,
          width: 115,
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/default_user.png"),
          )
        ),
      ),
    );
  }
}
