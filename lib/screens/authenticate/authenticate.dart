import "package:flutter/material.dart";

import "sign_in.dart";
import "sign_up.dart";

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool toggleSignIn = true;
  void toggleView() {
    setState(() {
      toggleSignIn = !toggleSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authenticate"),
        backgroundColor: Colors.brown[900],
        actions: [
          TextButton(
            onPressed: () {
              toggleView();
            },
            child: Text(
              toggleSignIn ? "Sign Up" : "Sign In",
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: toggleSignIn ? const SignIn() : const SignUp(),
    );
  }
}
