import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'firebase_options.dart';
import 'widgets/my_app.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}




// fingerprint for production firebase
// hide .env from gitHub
// change the name that will appear on the phone
// update the design of the app

// fix hide menu when click outside

// start zoned express app