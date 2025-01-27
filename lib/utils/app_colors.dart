import 'package:flutter/material.dart';

class AppColors {
  //Main Colors
  static const Color kBackGroundColor = Color(0xff202326);
  static const Color kFActionButtonColor = Color.fromARGB(255, 23, 54, 85);
  static const Color kWhiteColor = Color(0xffFFFFFF);

  //Greadient Colors
  //Card
  static const Color kCardColorG1 = Color.fromARGB(255, 8, 39, 39);
  static const Color kCardColorG2 = Color.fromARGB(255, 66, 29, 29);

  LinearGradient kMainCardColor = LinearGradient(
    colors: [kCardColorG1, kCardColorG2],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  //Circle
  static const Color kCircleColorG1 = Color.fromARGB(255, 22, 13, 109);
  static const Color kCircleColorG2 = Color.fromARGB(255, 23, 100, 151);

  LinearGradient kMainCircleColor = LinearGradient(
    colors: [kCircleColorG1, kCircleColorG2],
    begin: Alignment.bottomLeft,
    end: Alignment.centerLeft,
  );
}
