import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'custom_container.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomContainer(
      child: Center(
        child: SpinKitRotatingCircle(
          color: Colors.brown,
          size: 50.0,
        ),
      ),
    );
  }
}
