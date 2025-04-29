import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:revxpharma/Patient/screens/NewOnBoarding.dart';
import 'package:revxpharma/Services/ApiClient.dart';
import 'package:revxpharma/Utils/media_query_helper.dart';
import 'package:revxpharma/router.dart';
import 'package:revxpharma/state_injector.dart';

import 'Patient/screens/Splash.dart';
import 'Utils/Preferances.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
    playSound: true);

Future<void> main() async {
  ApiClient.setupInterceptors();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyCJx7GVCwtcRE7s2BGcQat2tOKCtCHak3c",
            appId: "1:987805631234:android:254900181738d103c5381b",
            messagingSenderId: "987805631234",
            projectId: "revx-labs",
          ),
        )
      : await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey:
                "AIzaSyAk5-HuV9Kq2iXsopciBiv7qkggAYjPHPI", // Use your actual API key
            appId:
                "1:987805631234:ios:f4ce0983ba7acffdc5381b", // Use your actual iOS app ID
            messagingSenderId:
                "987805631234", // Use your actual messagingSenderId
            projectId: "revx-labs", // Use your actual project ID
            iosBundleId:
                "com.revxlabs.in", // Replace with your actual iOS bundle ID
          ),
        );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permissions (iOS)
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // Get the APNs token (iOS)
  if (Platform.isIOS) {
    String? apnsToken = await messaging.getAPNSToken();
    print("APNs Token: $apnsToken");
  }

  // Get the FCM token
  String? fcmToken = await messaging.getToken();
  print("FCM Token: $fcmToken");
  if (fcmToken != null) {
    PreferenceService().saveString("fbstoken", fcmToken);
  }

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // Create notification channel (Android)
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  const DarwinInitializationSettings iosInitSettings =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: iosInitSettings,
  );

  flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      // Handle notification tapped logic
    },
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      showNotification(notification, android, message.data);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    // Handle notification opened when app was in background
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('A Background message just showed up :  ${message.data}');
}

// Function to display local notifications
void showNotification(RemoteNotification notification,
    AndroidNotification android, Map<String, dynamic> data) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id', // Your channel ID
    'your_channel_name', // Your channel name
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    icon: '@mipmap/ic_launcher',
  );
  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    notification.hashCode,
    notification.title,
    notification.body,
    platformChannelSpecifics,
    payload: jsonEncode(data),
  );
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
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
