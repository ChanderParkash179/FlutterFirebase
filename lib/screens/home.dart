// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetuts/utils/constants.dart';
import 'package:firebasetuts/utils/routes.dart';
import 'package:firebasetuts/utils/toast.dart';
import 'package:firebasetuts/widgets/button.dart';
import 'package:firebasetuts/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

@override
class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    final auth = FirebaseAuth.instance;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(constants().primaryColor),
          actions: [
            Spaces().verticalSpace(30),
            IconButton(
                onPressed: () {
                  auth
                      .signOut()
                      .then((value) =>
                          Navigator.pushNamed(context, MyRoutes().loginRoute))
                      .onError((error, stackTrace) =>
                          FlutterToast().toastMsg(error.toString()));
                },
                icon: Icon(
                  Icons.logout_outlined,
                ))
          ],
        ),
        body: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(constants().primaryColor),
              Color(constants().secondaryColor),
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          )),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    constants().homeTitle.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 2,
                      fontSize: constants().fontSize,
                      color: Colors.white,
                    ),
                  ),
                  Spaces().verticalSpace(50),
                  MyButton().getButton(
                    context,
                    MyRoutes().loginRoute,
                    constants().loginTitle,
                  ),
                  Spaces().verticalSpace(50),
                  MyButton().getButton(
                    context,
                    MyRoutes().signupRoute,
                    constants().signupTitle,
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes().addpostRoute);
          },
          child: Icon(
            CupertinoIcons.add_circled,
          ),
        ),
      ),
    );
  }
}
