import 'dart:async';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../widgets/custom_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(Routes.wrapper);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomContainer(
        child: Center(
          child: Image.asset('assets/icons/icon.png', scale: 0.5),
        ),
      ),
    );
  }
}
