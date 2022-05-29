import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutterfirebase/models/user.dart';
import 'package:flutterfirebase/services/database.dart';
import 'package:flutterfirebase/shared/constants.dart';
import 'package:flutterfirebase/shared/loading.dart';
import 'package:provider/provider.dart';

class FormSettings extends StatefulWidget {
  const FormSettings({Key? key}) : super(key: key);

  @override
  State<FormSettings> createState() => _FormSettingsState();
}

class _FormSettingsState extends State<FormSettings> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = [
    "0",
    "1",
    "2",
    "3",
    "4"
  ];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    CollectionReference coffees = FirebaseFirestore.instance.collection('coffees');
    print(user.uid);

    return FutureBuilder<DocumentSnapshot>(
      future: coffees.doc(user.uid).get(),
      // future: DatabaseService(uid: user.uid).userData,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Update My Data",
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: data["name"],
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter name";
                    } else if (val.length < 6) {
                      return "Name shoud be at least 6 chars + long";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                  decoration: textInputDecoration,
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  onChanged: (val) => setState(() {
                    _currentSugars = val as String?;
                  }),
                  value: _currentSugars ?? data["sugars"],
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text("$sugar sugars"),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Slider",
                ),
                Slider(
                  value: (_currentStrength ?? data["strength"]).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? data["strength"]],
                  inactiveColor: Colors.brown[_currentStrength ?? data["strength"]],
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) => setState(
                    () => _currentStrength = val.round(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue[500],
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // update info in collections docs
                      await DatabaseService(uid: user.uid).updateUserInfo(
                        _currentName ?? data["name"],
                        _currentSugars ?? data['sugars'],
                        _currentStrength ?? data['strength'],
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
