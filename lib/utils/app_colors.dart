import 'package:flutter/material.dart';

class AppColors {
  //Main Colors
  static const Color kBackGroundColor = Color(0xff202326);
  static const Color kFActionButtonColor = Color.fromARGB(255, 0, 128, 255);
  static const Color kWhiteColor = Color(0xffFFFFFF);

  //Greadient Colors
  //Card
  static const Color kCardColorG1 = Color.fromARGB(255, 0, 156, 156);
  static const Color kCardColorG2 = Color.fromARGB(255, 0, 22, 95);

  LinearGradient kMainCardColor = LinearGradient(
    colors: [kCardColorG1, kCardColorG2],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  //Circle
  static const Color kCircleColorG1 = Color.fromARGB(255, 0, 68, 255);
  static const Color kCircleColorG2 = Color.fromARGB(255, 255, 251, 0);

  LinearGradient kMainCircleColor = LinearGradient(
    colors: [kCircleColorG1, kCircleColorG2],
    begin: Alignment.bottomLeft,
    end: Alignment.topLeft,
  );
}
