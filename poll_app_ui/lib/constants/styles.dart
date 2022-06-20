import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:flutter_test_1/constants/constants.dart';

Color transparentColor = Colors.transparent;
Color blackColor = Colors.black;
Color whiteColor = Colors.white;
Color primaryColorLight = Color(0xff3e3e49);
Color scaffoldBackgroundColor = Colors.grey[200]!;
Color backgroundColor = Colors.grey[200]!;
Color greyBackgroundColor = Colors.grey[400]!;
Color primaryColor = Color(0xff6ee429);
Color followingBgColor = Color(0xffeff3ec);
Color primaryV2Color=Color(0xff44beef);


final BorderRadius radius = BorderRadius.circular(6.0);
final ThemeData appTheme = ThemeData(
  fontFamily: 'Poppins',
  backgroundColor: backgroundColor,
  scaffoldBackgroundColor: scaffoldBackgroundColor,
  primaryColor: const Color(0xFF062949),
  primaryColorLight: const Color(0xFFF4E6f0),
  hintColor: Colors.grey[400],
  primarySwatch: const MaterialColor( 
    0xff062949, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    <int, Color>{ 
      50: Color(0xff1f3e5b),//10% 
      100: Color(0xff38546d),//20% 
      200: Color(0xff516980),//30% 
      300: Color(0xff6a7f92),//40% 
      400: Color(0xff8394a4),//50% 
      500: Color(0xff9ba9b6),//60% 
      600: Color(0xffb4bfc8),//70% 
      700: Color(0xffcdd4db),//80% 
      800: Color(0xffe6eaed),//90% 
      900: Color(0xffffffff),//100% 
    }, 
  ),
  
  ///appBar theme
  appBarTheme: const AppBarTheme(
      color: Color(0xff062949),
      elevation: 0.0,
      
      iconTheme: IconThemeData(color: Colors.white)),
//input decoratio
inputDecorationTheme: const InputDecorationTheme(focusColor: Color(0xff062949)),
  ///text theme
  textTheme: TextTheme(
    bodyText1: const TextStyle(),
    bodyText2: const TextStyle(fontWeight: FontWeight.w400),
    subtitle1: const TextStyle(fontWeight: FontWeight.w500),
    subtitle2: TextStyle(color: Colors.grey[400], fontWeight: FontWeight.w400),
    headline1: const TextStyle(),
    headline2: const TextStyle(),
    headline3: const TextStyle(),
    headline4: const TextStyle(),
    headline5: const TextStyle(),
    headline6: const TextStyle(),
  ).apply(bodyColor: Colors.black),
);

final TextStyle bottomBarTextStyle = const TextStyle(
  fontSize: 15.0,
  color: Colors.white,
  fontWeight: FontWeight.w400,
);

/// NAME         SIZE  WEIGHT  SPACING
/// headline1    96.0  light   -1.5
/// headline2    60.0  light   -0.5
/// headline3    48.0  regular  0.0
/// headline4    34.0  regular  0.25
/// headline5    24.0  regular  0.0
/// headline6    20.0  medium   0.15
/// subtitle1    16.0  regular  0.15
/// subtitle2    14.0  medium   0.1
/// body1        16.0  regular  0.5   (bodyText1)
/// body2        14.0  regular  0.25  (bodyText2)
/// button       14.0  medium   1.25
/// caption      12.0  regular  0.4
/// overline     10.0  regular  1.5
