import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Patient/screens/NewOnBoarding.dart';
import 'package:revxpharma/Services/ApiClient.dart';
import 'package:revxpharma/Utils/media_query_helper.dart';
import 'package:revxpharma/router.dart';
import 'package:revxpharma/state_injector.dart';

import 'Patient/screens/Splash.dart';

void main() {
  ApiClient.setupInterceptors();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MultiRepositoryProvider(
      providers: StateInjector.repositoryProviders,
      child: MultiBlocProvider(
        providers: StateInjector.blocProviders,
        child: MaterialApp.router(
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
                  borderRadius: BorderRadius.all(Radius.circular(
                      5.0)), // Set the border radius of the dialog
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
                  surfaceTintColor: Colors.white,
                  backgroundColor: Colors.white),
              colorScheme: const ColorScheme.light(background: Colors.white)
                  .copyWith(background: Colors.white),
            ),
            title: 'Revx Labs',
            debugShowCheckedModeBanner: false,
            routerConfig: goRouter),
      ),
    );
  }
}
