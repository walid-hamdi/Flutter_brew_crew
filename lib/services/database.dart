import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutterfirebase/models/coffee.dart";
import "package:flutterfirebase/models/user.dart";

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  // create reference
  final CollectionReference _coffees = FirebaseFirestore.instance.collection("coffees");

  List<Coffee> _coffeeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map(
          (doc) => Coffee(
            name: doc["name"] ?? "",
            sugars: doc["sugars"] ?? "0",
            strength: doc["strength"] ?? 0,
          ),
        )
        .toList();
  }

  // UserData _userDataFromSnapshot(DocumentSnapshot document) {
  //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  //   return UserData(
  //     name: data['name'].toString(),
  //     sugars: data['sugars'].toString(),
  //     strength: int.parse(data['strength']),
  //   );
  // }

  Stream<List<Coffee>?> get coffeeUsers {
    return _coffees.snapshots().map(_coffeeListFromSnapshot);
  }

  Future<DocumentSnapshot> get userData {
    return _coffees.doc(uid).get();
  }

  Future updateUserInfo(String name, String sugars, int strength) async {
    return await _coffees.doc(uid).set({
      "name": name,
      "sugars": sugars,
      "strength": strength
    });
  }
}
