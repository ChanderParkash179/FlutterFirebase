import 'package:firebasetuts/services/splashservice.dart';
import 'package:firebasetuts/utils/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  SplashService splashService = SplashService();
  @override
  void initState() {
    super.initState();

    splashService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(constants().primaryColor),
        child: FlutterLogo(size: MediaQuery.of(context).size.height * .5));
  }
}
