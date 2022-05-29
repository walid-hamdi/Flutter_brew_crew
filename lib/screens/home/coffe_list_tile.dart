import "package:flutter/material.dart";
import 'package:flutterfirebase/models/coffee.dart';

class CoffeeListTile extends StatelessWidget {
  final Coffee items;

  const CoffeeListTile({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.brown[items.strength ?? 900],
        ),
        title: Text(items.name ?? " "),
        subtitle: Text("Takes ${items.sugars} sugar(s)"),
      ),
    );
  }
}
