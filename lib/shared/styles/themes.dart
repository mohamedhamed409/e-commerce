import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme=ThemeData(
  fontFamily: 'Jannah',
  primarySwatch: defaultColor,
  // floatingActionButtonTheme:const FloatingActionButtonThemeData(
  //   backgroundColor: Colors.deepOrange,
  // ),
  appBarTheme: const AppBarTheme(
    iconTheme:  IconThemeData(

      color: Colors.black,
    ),
    elevation: 0.0,
    titleSpacing: 20,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor:defaultColor,
    backgroundColor: Colors.white,
    elevation: 20.0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
);
ThemeData darkTheme=ThemeData(

  fontFamily: 'Jannah',
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  primarySwatch:defaultColor,
  // floatingActionButtonTheme:const FloatingActionButtonThemeData(
  //   backgroundColor: Colors.deepOrange,
  // ),
  appBarTheme:  AppBarTheme(

    iconTheme:  IconThemeData(
      color: Colors.white,
    ),
    elevation: 0.0,
    titleSpacing: 20,
    backgroundColor: HexColor('333739'),
    titleTextStyle: TextStyle(
      color:Colors.white,
    ),

    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('333739'),
    elevation: 20.0,

  ),
);