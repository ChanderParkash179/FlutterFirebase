// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetuts/screens/phone.dart';
import 'package:firebasetuts/utils/constants.dart';
import 'package:firebasetuts/utils/routes.dart';
import 'package:firebasetuts/utils/toast.dart';
import 'package:firebasetuts/widgets/button.dart';
import 'package:firebasetuts/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ButtonStyle btnStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(constants().primaryColor),
    shadowColor: Color(constants().secondaryColor),
  );

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    bool loading = false;
    final _auth = FirebaseAuth.instance;
    return WillPopScope(
      onWillPop: (() async {
        SystemNavigator.pop();
        return true;
      }),
      child: SafeArea(
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
            )),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      constants().loginTitle.toUpperCase(),
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
                            Spaces().verticalSpace(50),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Your Email',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                  prefixIcon: Icon(
                                    CupertinoIcons.mail,
                                    color: Colors.white,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Email';
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please Enter valid Email';
                                  }
                                  if (!value.contains('.')) {
                                    return 'Please Enter valid Email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Spaces().verticalSpace(20),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter Your Password',
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                  prefixIcon: Icon(
                                    CupertinoIcons.padlock,
                                    color: Colors.white,
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Password';
                                  }
                                  if (value.length < 8) {
                                    return 'Password should be length of 8 minimum';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Spaces().verticalSpace(20),
                          ],
                        )),
                    Spaces().verticalSpace(30),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });

                        if (_formKey.currentState!.validate()) {
                          _auth
                              .signInWithEmailAndPassword(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString(),
                          )
                              .then((value) {
                            FlutterToast()
                                .toastMsg(value.user!.email.toString());
                            Navigator.pushNamed(context, MyRoutes().homeRoute);
                            setState(() {
                              loading = false;
                            });
                          }).onError(
                            (error, stackTrace) {
                              FlutterToast().toastMsg(
                                error.toString(),
                              );
                              setState(() {
                                loading = false;
                              });
                            },
                          );
                        }
                      },
                      style: btnStyle,
                      child: Container(
                        margin: const EdgeInsets.all(6.0),
                        width: _width * .30,
                        height: _height * .04,
                        child: Text(
                          constants().loginTitle.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize: constants().fontSize,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Spaces().verticalSpace(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an Account! ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: constants().fontSize - 8,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MyRoutes().signupRoute);
                          },
                          child: Text(
                            'Signup',
                            style: TextStyle(
                              color: Color(0xffDFACA2),
                              letterSpacing: 1,
                              fontSize: constants().fontSize - 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spaces().verticalSpace(30),
                    MyButton().getButton(
                        context, MyRoutes().phoneRoute, constants().phoneTitle),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
