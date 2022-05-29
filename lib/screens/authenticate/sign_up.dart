import "package:flutter/material.dart";
import 'package:flutterfirebase/services/auth.dart';
import 'package:flutterfirebase/shared/loading.dart';
import 'package:flutterfirebase/shared/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  var _email;
  var _password;
  var _error;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Loading()
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: "Email",
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                      ),
                      validator: (val) => val!.isEmpty ? "Enter email" : null,
                      onChanged: (val) {
                        setState(() {
                          _email = val;
                        });
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                      hintText: "Password",
                      prefixIcon: const Icon(
                        Icons.password,
                        color: Colors.white,
                      ),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Enter password";
                      } else if (val.length < 6) {
                        return "Password shoud be at least 6 chars + long";
                      } else {
                        return null;
                      }
                    },
                    obscureText: true,
                    onChanged: (val) {
                      setState(
                        () {
                          _password = val;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blue[500],
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _loading = true;
                        });
                        // do authenticate
                        var result = await _auth.registerWithEmailAndPassword(_email, _password);
                        if (result == null) {
                          setState(
                            () {
                              _error = "Supply valid email";
                              _loading = false;
                            },
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _error ?? "",
                    style: TextStyle(color: Colors.red[400]),
                  ),
                ],
              ),
            ),
          );
  }
}
