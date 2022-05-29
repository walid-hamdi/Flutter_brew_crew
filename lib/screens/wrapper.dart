import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutterfirebase/screens/authenticate/authenticate.dart';
import 'package:flutterfirebase/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context) as dynamic;
    return user != null ? const Home() : const Authenticate();
  }
}
