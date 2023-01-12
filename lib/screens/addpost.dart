import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebasetuts/utils/constants.dart';
import 'package:firebasetuts/utils/routes.dart';
import 'package:firebasetuts/utils/toast.dart';
import 'package:firebasetuts/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final _formKey = GlobalKey<FormState>();
  final ButtonStyle btnStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(constants().primaryColor),
    shadowColor: Color(constants().secondaryColor),
  );
  bool loading = false;
  var id = DateTime.now().millisecondsSinceEpoch.toString();
  final postController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('POST');

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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    constants().addPost.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 2,
                      fontSize: constants().fontSize,
                      color: Colors.white,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Spaces().verticalSpace(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            maxLines: 2,
                            controller: postController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Your Post',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                              labelText: 'Post',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                              prefixIcon: Icon(
                                CupertinoIcons.book,
                                color: Colors.white,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty &&
                                  value == ' ' &&
                                  value == "") {
                                return 'Please Enter Post';
                              }
                              setState(() {
                                loading = false;
                              });
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spaces().verticalSpace(30),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });

                      databaseRef
                          .child(
                              DateTime.now().millisecondsSinceEpoch.toString())
                          .set({
                        'title': postController.text.toString(),
                        'id': (id).substring(8, id.length)
                      }).then((value) {
                        FlutterToast().toastMsg('POST ADDED!');

                        setState(() {
                          loading = false;
                        });

                        Navigator.pushNamed(context, MyRoutes().postsListRoute);
                      }).onError((error, stackTrace) {
                        FlutterToast().toastMsg(error.toString());
                      });
                    },
                    style: btnStyle,
                    child: (loading == false)
                        ? Container(
                            margin: const EdgeInsets.all(6.0),
                            width: _width * .30,
                            height: _height * .04,
                            child: Text(
                              constants().addPost.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: 2,
                                fontSize: constants().fontSize,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 16.0,
                            ),
                            child: const CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              strokeWidth: 4,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
