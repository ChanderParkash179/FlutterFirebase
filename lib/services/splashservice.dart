import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetuts/screens/home.dart';
import 'package:firebasetuts/screens/login.dart';
import 'package:flutter/material.dart';

class SplashService {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user == null) {
      Timer(
          const Duration(seconds: 5),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage())));
    } else {
      Timer(
          const Duration(seconds: 5),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage())));
    }
  }
}
