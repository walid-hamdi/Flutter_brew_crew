import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../utils/constants.dart';
import '../view/authenticate/sign_in.dart';
import '../view/authenticate/sign_up.dart';
import '../view/splash_screen/splash_screen_view.dart';
import '../view/wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return StreamProvider<User?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.brown),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.splashScreen,
        routes: {
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.login: (context) => const SignInView(),
          Routes.register: (context) => const SignUpView(),
          Routes.wrapper: (context) => const Wrapper(),
        },
      ),
    );
  }
}
