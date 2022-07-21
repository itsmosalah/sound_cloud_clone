import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../components/constants.dart';

ThemeData DarkMode = ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  fontFamily: 'Jannah',
  // default Color for Whole the App
  primarySwatch: defaultColor,

  appBarTheme: AppBarTheme(
    // titleSpacing: 20.0,
      backgroundColor: HexColor('333739'),
      elevation: 5.0,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white)
    // titleTextStyle: const TextStyle(
    //   color: Colors.white,
    //   fontSize: 18.0,
    //   fontWeight: FontWeight.bold,
    //   letterSpacing: 1.3,
    // ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      unselectedItemColor: Colors.white,
      unselectedLabelStyle: TextStyle(
        fontSize: 18,
      ),
      selectedLabelStyle: TextStyle(fontSize: 19),
      selectedIconTheme: IconThemeData(size: 26)),
  textTheme: const TextTheme(
    // controller color in TextFormField
    subtitle1: TextStyle(
      color: Colors.black,
    ),
    subtitle2: TextStyle(color: Colors.white, fontSize: 20),
    // For Headers
    headline1: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.4),
    headline2: TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 25,
      color: Colors.white,
    ),
    // For Normal Text
    bodyText1: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),

    // Label Style in TextFormField
    bodyText2: TextStyle(
      fontSize: 15,
      color: Colors.white,
    ),

    headline3: TextStyle(
        fontSize: 25,
        height: 1.2,
        color: Colors.white,
        overflow: TextOverflow.ellipsis),
  ),
  iconTheme: IconThemeData(color: Colors.white),
);

ThemeData LightMode = ThemeData(
  fontFamily: 'Jannah',
  appBarTheme: AppBarTheme(
    // titleSpacing: 20.0,
      backgroundColor: Colors.white,
      elevation: 5.0,
      iconTheme: IconThemeData(color: Colors.black)
    // titleTextStyle: TextStyle(
    //   color: Colors.black,
    //   fontSize: 25.0,
    //   fontWeight: FontWeight.bold,
    //   letterSpacing: 1.3,
    // ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedLabelStyle: TextStyle(fontSize: 19),
    selectedIconTheme: IconThemeData(size: 26),
    unselectedLabelStyle: TextStyle(
      fontSize: 18,
    ),
  ),
  textTheme: TextTheme(
    // For Headers
    headline1: const TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        letterSpacing: 1.4),
    subtitle2: TextStyle(color: Colors.black, fontSize: 20),

    headline2: TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: 25,
      color: Colors.grey[600],
    ),

    // Normal Text
    bodyText1: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),

    // Label Style in TextFormField
    bodyText2: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    headline3: TextStyle(
        fontSize: 25,
        height: 1.2,
        color: Colors.black,
        overflow: TextOverflow.ellipsis),
  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('e8e6ef'),
  iconTheme: IconThemeData(color: Colors.black),
);