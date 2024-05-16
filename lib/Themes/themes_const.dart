// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../Constant/colorGenarator.dart';
import '../Constant/colorpalates.dart';

ThemeData yellowTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Palettes.primary2,
    primarySwatch: generateMaterialColor(Palettes.primary2),
    fontFamily:
        'HelveticaNow', //HelveticaNow,SEGOEUIL,ayar,Ordina-WideThin,Celias-Medium*,
    //TruenoRound
    //Quicksand_Bold_Oblique,NovaRegular,Sabon*,OpenSans-Regular
    appBarTheme: AppBarTheme(backgroundColor: Colors.white
        //  foregroundColor: Colors.red,
        ),

    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Palettes.primary2),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Palettes.primary2.withOpacity(1)),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white, fontFamily: 'nunitoSans')))),

    // textTheme: TextTheme(
    //   headline3: TextStyle(fontFamily: 'SEGOEUIL'),
    //   headline1: TextStyle(fontFamily: 'SEGOEUIL'),
    //   headline2: TextStyle(fontFamily: 'SEGOEUIL'),
    //   headline4: TextStyle(fontFamily: 'SEGOEUIL'),
    //   headline5: TextStyle(fontFamily: 'SEGOEUIL'),
    //   headline6: TextStyle(fontFamily: 'SEGOEUIL'),
    //   bodyText1: TextStyle(
    //     fontFamily: 'SEGOEUIL',
    //   ),
    //   bodyText2: TextStyle(fontFamily: 'SEGOEUIL'),
    //   subtitle1: TextStyle(fontFamily: 'SEGOEUIL'),
    //   subtitle2: TextStyle(fontFamily: 'SEGOEUIL'),
    // ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary2),
      ),
    ),

    iconTheme: IconThemeData(color: Colors.white),
  );
}

//

ThemeData blueTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Palettes.primary1,
    primarySwatch: generateMaterialColor(Palettes.primary1),
    appBarTheme: AppBarTheme(backgroundColor: Colors.white
        //  foregroundColor: Colors.red,
        ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Palettes.primary1),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Palettes.primary1.withOpacity(1)),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white, fontFamily: 'nunitoSans')))),
    textTheme: TextTheme(
      displaySmall: TextStyle(fontFamily: 'nunitoSans'),
      displayLarge: TextStyle(fontFamily: 'nunitoSans'),
      displayMedium: TextStyle(fontFamily: 'nunitoSans'),
      headlineMedium: TextStyle(fontFamily: 'nunitoSans'),
      headlineSmall: TextStyle(fontFamily: 'nunitoSans'),
      titleLarge: TextStyle(fontFamily: 'nunitoSans'),
      bodyLarge: TextStyle(
        fontFamily: 'nunitoSans',
      ),
      bodyMedium: TextStyle(fontFamily: 'nunitoSans'),
      titleMedium: TextStyle(fontFamily: 'nunitoSans'),
      titleSmall: TextStyle(fontFamily: 'nunitoSans'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary1),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}

//orange

ThemeData redTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Palettes.primary3,
    primarySwatch: generateMaterialColor(Palettes.primary3),
    appBarTheme: AppBarTheme(backgroundColor: Colors.white
        //  foregroundColor: Colors.red,
        ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Palettes.primary3),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Palettes.primary3.withOpacity(1)),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white, fontFamily: 'nunitoSans')))),
    textTheme: TextTheme(
      displaySmall: TextStyle(fontFamily: 'nunitoSans'),
      displayLarge: TextStyle(fontFamily: 'nunitoSans'),
      displayMedium: TextStyle(fontFamily: 'nunitoSans'),
      headlineMedium: TextStyle(fontFamily: 'nunitoSans'),
      headlineSmall: TextStyle(fontFamily: 'nunitoSans'),
      titleLarge: TextStyle(fontFamily: 'nunitoSans'),
      bodyLarge: TextStyle(
        fontFamily: 'nunitoSans',
      ),
      bodyMedium: TextStyle(fontFamily: 'nunitoSans'),
      titleMedium: TextStyle(fontFamily: 'nunitoSans'),
      titleSmall: TextStyle(fontFamily: 'nunitoSans'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary3),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary3),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}

//DARK
ThemeData greenTheme(BuildContext context) {
  return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: generateMaterialColor(Palettes.primary4),
      primaryColorDark:
          Palettes.primary4, //generateMaterialColor(Palette.primary),
      primaryColor: Palettes.primary4,
      appBarTheme: AppBarTheme(
        backgroundColor: Palettes.primary4,
        // foregroundColor: Colors.red,
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Palettes.primary4),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(
                vertical: 10,
              ) //horizontal: 30
                  ),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Palettes.primary4),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              // overlayColor:  MaterialStateProperty.all<Color>(Colors.black26),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: Colors.white, fontFamily: 'nunitoSans')))),
      textTheme: TextTheme(
        headline3: TextStyle(fontFamily: 'Segoe'),
        headline1: TextStyle(fontFamily: 'Segoe'),
        headline2: TextStyle(fontFamily: 'Segoe'),
        headline4: TextStyle(fontFamily: 'Segoe'),
        headline5: TextStyle(fontFamily: 'Segoe'),
        headline6: TextStyle(fontFamily: 'Segoe'),
        bodyText1: TextStyle(fontFamily: 'Segoe'),
        bodyText2: TextStyle(fontFamily: 'Segoe'),
        subtitle1: TextStyle(fontFamily: 'Segoe'),
        subtitle2: TextStyle(fontFamily: 'Segoe'),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Palettes.primary4),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Palettes.primary4),
        ),
      ),
      switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.all<Color>(Colors.grey),
          thumbColor: MaterialStateProperty.all<Color>(Colors.white)),
      primaryIconTheme: IconThemeData(color: Colors.amber),
      iconTheme: IconThemeData(color: Colors.white));
}

ThemeData roseTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Palettes.primary5,
    primarySwatch: generateMaterialColor(Palettes.primary5),
    appBarTheme: AppBarTheme(backgroundColor: Colors.white
        //  foregroundColor: Colors.red,
        ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Palettes.primary5),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Palettes.primary5.withOpacity(1)),
            textStyle: MaterialStateProperty.all<TextStyle>(
                TextStyle(color: Colors.white, fontFamily: 'nunitoSans')))),
    textTheme: TextTheme(
      displaySmall: TextStyle(fontFamily: 'nunitoSans'),
      displayLarge: TextStyle(fontFamily: 'nunitoSans'),
      displayMedium: TextStyle(fontFamily: 'nunitoSans'),
      headlineMedium: TextStyle(fontFamily: 'nunitoSans'),
      headlineSmall: TextStyle(fontFamily: 'nunitoSans'),
      titleLarge: TextStyle(fontFamily: 'nunitoSans'),
      bodyLarge: TextStyle(
        fontFamily: 'nunitoSans',
      ),
      bodyMedium: TextStyle(fontFamily: 'nunitoSans'),
      titleMedium: TextStyle(fontFamily: 'nunitoSans'),
      titleSmall: TextStyle(fontFamily: 'nunitoSans'),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Palettes.primary5),
      ),
    ),
    iconTheme: IconThemeData(color: Colors.white),
  );
}
