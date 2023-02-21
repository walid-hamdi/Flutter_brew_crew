import "package:flutter/material.dart";

import "../../services/auth.dart";
import "../../widgets/custom_container.dart";
import "../../widgets/loading.dart";
import "../../widgets/custom_input_field.dart";
import "../../widgets/custom_button.dart";

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _error = "";
  bool _loading = false;

  String? _onEmailValidator(String? val) => val!.isEmpty ? "Enter email" : null;
  _onEmailChanged(String? val) {
    setState(() {
      _email = val!;
    });
  }

  String? _onPasswordValidator(String? val) {
    if (val!.isEmpty) {
      return "Enter password";
    } else if (val.length < 6) {
      return "Password should be at least 6 chars + long";
    } else {
      return null;
    }
  }

  _onPasswordChanged(String? val) {
    setState(() {
      _password = val!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Loading()
        : CustomContainer(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomInputField(
                      hintText: "Enter email",
                      icon: Icons.email,
                      onChange: _onEmailChanged,
                      validator: _onEmailValidator,
                      initialValue: _email,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomInputField(
                      hintText: "Enter password",
                      icon: Icons.lock,
                      onChange: _onPasswordChanged,
                      validator: _onPasswordValidator,
                      initialValue: _password,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      label: "Login",
                      onPressed: _onLoginPressed,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      _error,
                      style: TextStyle(color: Colors.red[400]),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      // do authenticate
      var result = await _auth.signInWithEmailAndPassword(_email, _password);
      if (result == null) {
        setState(
          () {
            _error = "invalid credentials";
            _loading = false;
          },
        );
      }
    }
  }
}
