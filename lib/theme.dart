import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

ThemeData basicTheme(BuildContext context)=>ThemeData(
  primarySwatch: Colors.blue,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme:TextTheme(

    headline6: TextStyle(
      color:Colors.white,
      fontSize:30,
    ),


    bodyText1: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: Colors.black,
    ),


    bodyText2: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 17,
      color:Colors.blue,
    ),


    button: TextStyle(
      color:Colors.white,
      fontSize:20,
    ),
  ),
  buttonColor: Colors.blue,
);