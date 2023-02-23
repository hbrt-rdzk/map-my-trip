import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapmytrip/constants/constants.dart' as constants;
import 'package:mapmytrip/services/models.dart';

class ProfileEdit extends StatelessWidget {
  ProfileEdit({super.key, required this.user, required this.email});
  UserData user;
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 110.0, bottom: 8, left: 8, right: 8),
            child: TextField(
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              onChanged: (value) => user.name = value,
              controller: TextEditingController()..text = user.name.toString(),
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
              onChanged: (value) => user.surname = value,
              controller: TextEditingController()
                ..text = user.surname.toString(),
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
              onChanged: (value) => user.age = int.parse(value),
              controller: TextEditingController()..text = user.age.toString(),
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
                  child: DropdownNationalities(user: user)),
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
                child: const Text("Save"),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(email)
                      .update(user.toJson())
                      .onError((error, stackTrace) {
                  });
                  Fluttertoast.showToast(
                      msg: "Changes saved",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: const Color.fromRGBO(255, 251, 243, 1),
                      textColor: Colors.orange,
                      fontSize: 16.0);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DropdownNationalities extends StatefulWidget {
  DropdownNationalities({super.key, required this.user});
  UserData user;
  @override
  State<DropdownNationalities> createState() => _DropdownNationalitiesState();
}

class _DropdownNationalitiesState extends State<DropdownNationalities> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: widget.user.nationality,
        hint: const Text('Nationality'),
        onChanged: (value) {
          if (value is String) {
            setState(() {
              widget.user.nationality = value;
            });
          }
        },
        isExpanded: true,
        items: constants.nationalities
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList());
  }
}
