import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetuts/utils/constants.dart';
import 'package:firebasetuts/utils/routes.dart';
import 'package:firebasetuts/utils/toast.dart';
import 'package:firebasetuts/widgets/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  final verificationId;
  const VerificationScreen({super.key, required this.verificationId});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _verificationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ButtonStyle btnStyle = ElevatedButton.styleFrom(
    backgroundColor: Color(constants().primaryColor),
    shadowColor: Color(constants().secondaryColor),
  );
  final _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
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
                    constants().verificationTitle.toUpperCase(),
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
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: TextFormField(
                            controller: _verificationController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter 6 Digits Code',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                              labelText: 'Code',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                              prefixIcon: Icon(
                                CupertinoIcons.lock_shield,
                                color: Colors.white,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                setState(() {
                                  loading = false;
                                });
                                return 'Please Enter Verification Code';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spaces().verticalSpace(30),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });

                      if (_formKey.currentState!.validate()) {
                        final credentials = PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: _verificationController.text.toString());

                        try {
                          
                          await _auth.signInWithCredential(credentials);
                          Navigator.pushNamed(context, MyRoutes().homeRoute);
                        } catch (e) {
                          FlutterToast().toastMsg(e.toString());
                        }
                      }
                    },
                    style: btnStyle,
                    child: (loading == false)
                        ? Container(
                            margin: const EdgeInsets.all(6.0),
                            width: _width * .30,
                            height: _height * .04,
                            child: Text(
                              constants().verificationBtnTitle.toUpperCase(),
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
