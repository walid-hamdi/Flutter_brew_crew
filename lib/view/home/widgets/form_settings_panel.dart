import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../../services/database.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input_field.dart';
import '../../../widgets/loading.dart';

class FormSettings extends StatefulWidget {
  const FormSettings({Key? key}) : super(key: key);

  @override
  State<FormSettings> createState() => _FormSettingsState();
}

class _FormSettingsState extends State<FormSettings> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  String? _onNameValidator(String? val) {
    if (val!.isEmpty) {
      return "Enter name";
    } else if (val.length < 6) {
      return "Name should be at least 6 chars + long";
    } else {
      return null;
    }
  }

  _onNameChanged(String? val) {
    setState(() {
      _currentName = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    CollectionReference coffees =
        FirebaseFirestore.instance.collection('coffees');

    return FutureBuilder<DocumentSnapshot>(
      future: coffees.doc(user!.uid).get(),
      // future: DatabaseService(uid: user.uid).userData,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

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
                CustomInputField(
                  initialValue: data["name"],
                  validator: _onNameValidator,
                  hintText: "Name",
                  icon: Icons.person,
                  onChange: _onNameChanged,
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  // decoration: textInputDecoration,
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
                  activeColor:
                      Colors.brown[_currentStrength ?? data["strength"]],
                  inactiveColor:
                      Colors.brown[_currentStrength ?? data["strength"]],
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
                CustomButton(
                  label: "Update",
                  onPressed: () {
                    _onUpdatePressed(user, data);
                  },
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

  _onUpdatePressed(User? user, Map<String, dynamic> data) async {
    if (_formKey.currentState!.validate()) {
      // update info in collections docs
      DatabaseService(uid: user?.uid).updateUserInfo(
        _currentName ?? data["name"],
        _currentSugars ?? data['sugars'],
        _currentStrength ?? data['strength'],
      );
      Navigator.pop(context);
    }
  }
}
