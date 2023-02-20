import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapmytrip/services/auth.dart';
import 'package:mapmytrip/widgets/bottom_nav.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool? _isAnonymousUser;
  var user = {
    'Name': 'Hubert',
    'Surname': 'Rudzik',
    'Age': 22,
    'Nationality': '🇵🇱',
    'Lessons': '16'
  };

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
          backgroundColor: Colors.orange,
        ),
        body: Builder(builder: (BuildContext context) {
          if (_isAnonymousUser == true) {
            return AnonymousAccount();
            // return ElevatedButton(
            //     child: const Text('Sign'),
            //     onPressed: () async {
            //       await AuthService().anonSignOut();
            //       Navigator.of(context)
            //           .pushNamedAndRemoveUntil('/', (route) => false);
            //     });
          } else {
            return SignedUser(
              userInfo: user,
            );
            // return ElevatedButton(
            // child: const Text('Sign out'),
            // onPressed: () async {
            //   await AuthService().anonSignOut();
            //   Navigator.of(context)
            //       .pushNamedAndRemoveUntil('/', (route) => false);
            // });
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
          border: Border.all(color: Colors.blueAccent, width: 2),
        ),
        child: TextButton(
          child: const Text("Anonymous account, sign in"),
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
  Map<String, Object> userInfo;
  SignedUser({required this.userInfo, super.key});

  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final entries = [
      Container(
          height: 130,
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.purple,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/user.png',
                  height: 100,
                  width: 100,
                  alignment: Alignment.bottomRight,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Name: ${userInfo['Name']}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text('Age: ${userInfo['Age']}',
                        style: TextStyle(color: Colors.white)),
                    Text('Nationality: ${userInfo['Nationality']}',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    print("1234");
                  },
                  icon: const Icon(FontAwesomeIcons.penToSquare),
                  color: Colors.white,
                ),
              ],
            ),
          ])),
      Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 130,
        alignment: Alignment.center,
        child: Text("Finished Lessons: ${userInfo['Lessons']}",
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24)),
      ),
      Container(
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
          height: 130,
          child: TextButton(
            child: const Text("Log out",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 24)),
            onPressed: () async {
              await AuthService().anonSignOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            },
          )),
    ];
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _controller,
      padding: const EdgeInsets.all(10),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: const EdgeInsets.only(bottom: 5), child: entries[index]);
      },
    );
  }
}
