import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String? uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({
    this.uid,
    required this.name,
    required this.sugars,
    required this.strength,
  });
}
