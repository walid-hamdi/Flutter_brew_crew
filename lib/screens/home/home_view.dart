import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../models/coffee.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import 'widgets/coffee_list.dart';
import 'widgets/form_settings_panel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    void showPanelSettings() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: const FormSettings(),
          );
        },
      );
    }

    return StreamProvider<List<Coffee>?>.value(
      initialData: null,
      value: DatabaseService().coffeeUsers,
      child: Scaffold(
        backgroundColor: Colors.brown[800],
        body: const CoffeeList(),
        appBar: AppBar(
          title: const Text("Home Page"),
          backgroundColor: Colors.brown[900],
          actions: [
            TextButton(
              onPressed: () {
                showPanelSettings();
              },
              child: const Text(
                "Settings",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                await _auth.signout();
              },
              child: const Text(
                "Signout",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
