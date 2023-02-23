import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapmytrip/services/models.dart';
import 'package:mapmytrip/constants/constants.dart' as constants;

class ProfileRegister extends StatefulWidget {
  const ProfileRegister({super.key});

  @override
  State<ProfileRegister> createState() => _ProfileRegisterState();
}

class _ProfileRegisterState extends State<ProfileRegister> {
  UserData newUser = UserData();
  String? emailAddress;
  String? password;
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register account"),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              onChanged: (value) => emailAddress = value.toLowerCase(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onChanged: (value) => password = value,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 90.0, bottom: 8, left: 8, right: 8),
            child: TextField(
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              onChanged: (value) => newUser.name = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Surname',
              ),
              onChanged: (value) => newUser.surname = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
              onChanged: (value) => newUser.age = int.parse(value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                    value: dropdownValue,
                    hint: const Text('Nationality'),
                    onChanged: (value) {
                      if (value is String) {
                        setState(() {
                          dropdownValue = value;
                          newUser.nationality = value;
                        });
                      }
                    },
                    isExpanded: true,
                    items: constants.nationalities
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList()),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 60,
                  width: 160,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextButton(
                    child: const Text("Add account"),
                    onPressed: () async {
                      String message = 'Error';
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(emailAddress)
                          .set(newUser.toJson())
                          .onError((error, stackTrace) {
                        print("Error occured: $error");
                      });
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: emailAddress!,
                          password: password!,
                        );
                        message = "Account added";
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          message = 'The password provided is too weak.';
                        } else if (e.code == 'email-already-in-use') {
                          message =
                              'The account already exists for that email.';
                        } else if (e.code == 'invalid-email') {
                          message = 'Invalid email format';
                        }
                      } catch (e) {
                        print(e);
                      } finally {
                        Fluttertoast.showToast(
                            msg: message,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor:
                                const Color.fromRGBO(255, 251, 243, 1),
                            textColor: Colors.orange,
                            fontSize: 16.0);
                      }
                    },
                  ))),
        ]));
  }
}
