import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetuts/screens/verifyphone.dart';
import 'package:firebasetuts/utils/constants.dart';
import 'package:firebasetuts/utils/toast.dart';
import 'package:firebasetuts/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final _phoneController = TextEditingController();
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
          )),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    constants().phoneTitle.toUpperCase(),
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
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Your Phone',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                              labelText: 'Phone',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                              prefixIcon: Icon(
                                CupertinoIcons.phone,
                                color: Colors.white,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                setState(() {
                                  loading = false;
                                });
                                return 'Please Enter Phone';
                              }

                              if (value.length < 9) {
                                setState(() {
                                  loading = false;
                                });
                                return 'Phone Number should be length of 8 minimum';
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
                    onPressed: () {
                      setState(() {
                        loading = true;
                      });

                      if (_formKey.currentState!.validate()) {
                        _auth
                            .verifyPhoneNumber(
                              phoneNumber: _phoneController.text,
                              verificationCompleted: (_) {},
                              verificationFailed: (e) {
                                FlutterToast().toastMsg(
                                  e.toString(),
                                );

                                setState(() {
                                  loading = true;
                                });
                              },
                              codeSent: (String verificationId, int? token) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerificationScreen(
                                      verificationId: verificationId,
                                    ),
                                  ),
                                );

                                setState(() {
                                  loading = false;
                                });
                              },
                              codeAutoRetrievalTimeout: (e) {
                                FlutterToast().toastMsg(
                                  e.toString(),
                                );

                                setState(() {
                                  loading = false;
                                });
                              },
                            )
                            .then(
                              (value) => FlutterToast().toastMsg(
                                'Phone Number Entered',
                              ),
                            )
                            .onError(
                              (error, stackTrace) => FlutterToast()
                                  .toastMsg('Enter Valid Phone Number!'),
                            );
                      }
                    },
                    style: btnStyle,
                    child: (loading == false)
                        ? Container(
                            margin: const EdgeInsets.all(6.0),
                            width: _width * .30,
                            height: _height * .04,
                            child: Text(
                              constants().phoneTitle.toUpperCase(),
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
