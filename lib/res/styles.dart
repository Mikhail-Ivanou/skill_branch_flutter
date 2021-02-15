import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';

class AppStyles {
  static const _h6 = TextStyle(
    fontSize: 12,
    height: 20 / 12,
    letterSpacing: -0.24,
    fontWeight: FontWeight.w300,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
  );

  static const _h5 = TextStyle(
    fontSize: 15,
    height: 18 / 13,
    fontWeight: FontWeight.normal,
    color: AppColors.black,
    fontStyle: FontStyle.normal,
    fontFamily: 'Roboto',
  );

  static const _h4 = TextStyle(
    fontSize: 14,
    height: 16 / 14,
    color: AppColors.alto,
    fontWeight: FontWeight.w600,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    letterSpacing: 0.75,
  );

  static const _h3 = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.manatee,
    fontWeight: FontWeight.normal,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    letterSpacing: 0.25,
  );

  static const _h2 = TextStyle(
    fontSize: 17,
    height: 22 / 17,
    fontFamily: 'Roboto',
    color: AppColors.black,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    letterSpacing: -0.41,
  );

  static const _h1 = TextStyle(
    fontSize: 18,
    height: 23 / 18,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
  );

  static const _body = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    color: AppColors.black,
    fontWeight: FontWeight.w300,
    fontFamily: 'Roboto',
    fontStyle: FontStyle.normal,
    letterSpacing: -0.24,
  );
}

TextTheme buildAppTextTheme() {
  return TextTheme(
    headline1: AppStyles._h1,
    headline2: AppStyles._h2,
    headline3: AppStyles._h3,
    headline4: AppStyles._h4,
    headline5: AppStyles._h5,
    headline6: AppStyles._h6,
    bodyText1: AppStyles._body,
  );
}
