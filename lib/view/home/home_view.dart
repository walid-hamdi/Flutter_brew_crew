import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../models/coffee.dart';
import '../../services/auth.dart';
import '../../services/database.dart';
import '../../widgets/scaffold_wrapper.dart';
import 'widgets/coffee_list.dart';
import 'widgets/form_settings_panel.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
      child: ScaffoldWrapper(
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: Colors.brown[900],
          actions: [
            PopupMenuButton(
              onSelected: (result) async {
                if (result == 0) {
                  showPanelSettings();
                } else if (result == 1) {
                  await _auth.signout();
                }
              },
              itemBuilder: (cnx) => [
                const PopupMenuItem(
                  value: 0,
                  child: Text("Settings"),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text("Logout"),
                ),
              ],
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        child: const CoffeeList(),
      ),
    );
  }
}
