import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../../../models/coffee.dart';
import 'coffee_list_tile.dart';

class CoffeeList extends StatefulWidget {
  const CoffeeList({Key? key}) : super(key: key);

  @override
  State<CoffeeList> createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    final docs = Provider.of<List<Coffee>?>(context);

    if (docs != null) {
      return ListView.builder(
        itemBuilder: (context, index) => CoffeeListTile(
          items: docs[index],
        ),
        itemCount: docs.length,
      );
    } else {
      return const Center(
          child: Text(
        "There is no list now",
      ));
    }
  }
}
