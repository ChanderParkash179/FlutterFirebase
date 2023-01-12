import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetuts/screens/addpost.dart';
import 'package:firebasetuts/screens/home.dart';
import 'package:firebasetuts/screens/login.dart';
import 'package:firebasetuts/screens/phone.dart';
import 'package:firebasetuts/screens/posts.dart';
import 'package:firebasetuts/screens/signup.dart';
import 'package:firebasetuts/screens/splash.dart';
import 'package:firebasetuts/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
      ),
      initialRoute: MyRoutes().defaultRoute,
      routes: {
        MyRoutes().defaultRoute: (context) => SplashScreen(),
        MyRoutes().homeRoute: (context) => HomePage(),
        MyRoutes().loginRoute: (context) => LoginPage(),
        MyRoutes().signupRoute: (context) => SignupPage(),
        MyRoutes().phoneRoute: (context) => PhonePage(),
        MyRoutes().addpostRoute: (context) => AddPostPage(),
        MyRoutes().postsListRoute: (context) => PostsPage()
      },
    );
  }
}
