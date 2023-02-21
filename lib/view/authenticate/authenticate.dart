import "package:flutter/material.dart";

import "../../widgets/scaffold_wrapper.dart";
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
    return ScaffoldWrapper(
      appBar: AppBar(
        title: Text(toggleSignIn ? "Login account" : "Create account"),
        actions: [
          InkWell(
            onTap: toggleView,
            child: Icon(
              toggleSignIn ? Icons.person : Icons.login,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      child: toggleSignIn ? const SignInView() : const SignUpView(),
    );
  }
}
