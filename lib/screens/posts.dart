import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebasetuts/utils/constants.dart';
import 'package:firebasetuts/utils/routes.dart';
import 'package:firebasetuts/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final reference = FirebaseDatabase.instance.ref('POST');

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
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
            ),
          ),
          child: Column(
            children: [
              Text(
                constants().postTitle.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: constants().fontSize,
                  color: Colors.white,
                ),
              ),
              Spaces().verticalSpace(20),
              Expanded(
                child: FirebaseAnimatedList(
                  query: reference,
                  itemBuilder: (context, snapshot, animation, index) {
                    return ListTile(
                      leading: Text(
                        snapshot.child('title').value.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Text(
                        snapshot.child('id').value.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes().addpostRoute);
          },
          child: const Icon(
            CupertinoIcons.add_circled,
          ),
        ),
      ),
    );
  }
}
