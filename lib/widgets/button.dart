import 'package:firebasetuts/utils/constants.dart';
import 'package:flutter/material.dart';

class MyButton {
  ElevatedButton getButton(BuildContext context, var routeName, var title) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    final ButtonStyle btnStyle = ElevatedButton.styleFrom(
      backgroundColor: Color(constants().primaryColor),
      shadowColor: Color(constants().secondaryColor),
    );
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, routeName);
      },
      style: btnStyle,
      child: Container(
        margin: const EdgeInsets.all(6.0),
        width: _width * .30,
        height: _height * .04,
        child: Text(
          '$title'.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 2,
            fontSize: constants().fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
