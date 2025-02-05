import 'package:flutter/material.dart';

import 'Patient/screens/Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: child ?? Container(),
        );
      },
      themeMode: ThemeMode.light,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        // primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        cardColor: Colors.white,
        searchBarTheme: const SearchBarThemeData(),
        tabBarTheme: const TabBarTheme(),
        dialogTheme: const DialogTheme(
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(5.0)), // Set the border radius of the dialog
          ),
        ),
        buttonTheme: const ButtonThemeData(),
        popupMenuTheme: const PopupMenuThemeData(
            color: Colors.white, shadowColor: Colors.white),
        appBarTheme: const AppBarTheme(
          surfaceTintColor: Colors.white,
        ),
        cardTheme: const CardTheme(
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          color: Colors.white,
        ),

        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            // overlayColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
            surfaceTintColor: Colors.white, backgroundColor: Colors.white),
        colorScheme: const ColorScheme.light(background: Colors.white)
            .copyWith(background: Colors.white),
      ),
      title: 'Revx Labs',
      debugShowCheckedModeBanner: false,

      home: Splash(),
    );
  }
}
