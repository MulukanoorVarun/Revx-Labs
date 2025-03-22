import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Authentication/ChangePassword.dart';
import 'package:revxpharma/Authentication/LogInWithEmail.dart';
import 'package:revxpharma/Authentication/OtpVerify.dart';
import 'package:revxpharma/Patient/screens/AccountSettings.dart';
import 'package:revxpharma/Patient/screens/ApointmentDetails.dart';
import 'package:revxpharma/Patient/screens/Appointment.dart';
import 'package:revxpharma/Patient/screens/BookedApointmentsuccessfully.dart';
import 'package:revxpharma/Patient/screens/Dashboard.dart';
import 'package:revxpharma/Patient/screens/DiagnosticInformation.dart';
import 'package:revxpharma/Patient/screens/Diagnosticcenter.dart';
import 'package:revxpharma/Patient/screens/MyAppointments.dart';
import 'package:revxpharma/Patient/screens/OnBoarding.dart';
import 'package:revxpharma/Patient/screens/Onboard1.dart';
import 'package:revxpharma/Patient/screens/Payment.dart';
import 'package:revxpharma/Patient/screens/Permission.dart';
import 'package:revxpharma/Patient/screens/Profile.dart';
import 'package:revxpharma/Patient/screens/Register.dart';
import 'package:revxpharma/Patient/screens/ScheduleAppointment.dart';
import 'package:revxpharma/Patient/screens/SearchScreen.dart';
import 'package:revxpharma/Patient/screens/Splash.dart';
import 'package:revxpharma/Patient/screens/UserSelectionScreen.dart';
import 'package:revxpharma/Patient/screens/alltests.dart';
import 'package:revxpharma/Utils/NoInternet.dart';


final GoRouter goRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(path: '/', builder: (context, state) => Splash()),
  GoRoute(
    path: '/on_board',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(OnBoard(), state);
    },
  ),
  GoRoute(
    path: '/otp_verify',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(OtpVerify(), state);
    },
  ),
  GoRoute(
    path: '/on_board1',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(OnBoardOne(), state);
    },
  ),
  GoRoute(
    path: '/my_permissions',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(MyPermission(), state);
    },
  ),
  GoRoute(
    path: '/login',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(LogInWithEmail(), state);
    },
  ),
  GoRoute(
    path: '/dashboard',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(Dashboard(), state);
    },
  ),
  GoRoute(
    path: '/user_selection',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(UserSelectionScreen(), state);
    },
  ),

  GoRoute(
    path: '/registarion',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(RegisterScreen(), state);
    },
  ),
  GoRoute(
    path: '/no_internet',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(NoInternetWidget(), state);
    },
  ),
  GoRoute(
    path: '/profile',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(Profile(), state);
    },
  ),   GoRoute(
    path: '/account_settings',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(Accountsettings(), state);
    },
  ),
  GoRoute(
    path: '/change_password',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(ChangePassword(), state);
    },
  ),
  GoRoute(
    path: '/appointments',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(Apointments(), state);
    },
  ),
  GoRoute(
    path: '/all_tests',
    pageBuilder: (context, state) {
      final latLang = state.pathParameters['lat_lang'] ?? '';
      final catId = state.pathParameters['catId'] ?? '';
      final catName = state.pathParameters['catName'] ?? '';
      final diagnosticID = state.pathParameters['diagnosticID'] ?? '';

      return buildSlideTransitionPage(
        alltests(
          lat_lang: latLang,
          catId: catId,
          diagnosticID: diagnosticID,
          catName: catName,
        ),
        state,
      );
    },
  ),
  GoRoute(
    path: '/search_screen',
    pageBuilder: (context, state) {
      final latLang = state.pathParameters['lat_lang'] ?? '';
      return buildSlideTransitionPage(Searchscreen(lat_lang: latLang), state);
    },
  ),
  GoRoute(
    path: '/diognostic_center/:',
    pageBuilder: (context, state) {
      final latLng = state.pathParameters['lat_lang'] ?? '';
      return buildSlideTransitionPage(Diagnosticcenter(lat_lng: latLng), state);
    },
  ),
  GoRoute(
    path: '/diognostic_information',
    pageBuilder: (context, state) {
      final diognostic_id = state.uri.queryParameters['diognosticId'] ?? '';
      return buildSlideTransitionPage(
          DiagnosticInformation(diognosticId: diognostic_id), state);
    },
  ),
  GoRoute(
    path: '/payment',
    pageBuilder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return buildSlideTransitionPage(Payment(data: data), state);
    },
  ),
  GoRoute(
    path: '/apointment_success',
    pageBuilder: (context, state) {
      final appointmentmsg = state.uri.queryParameters['appointmentmsg'] ?? '';
      return buildSlideTransitionPage(
          ApointmentSuccess(appointmentmsg: appointmentmsg), state);
    },
  ),
  GoRoute(
    path: '/my_appointments',
    pageBuilder: (context, state) {
      return buildSlideTransitionPage(Myappointments(), state);
    },
  ),
  GoRoute(
    path: '/appointments_details',
    pageBuilder: (context, state) {
      final id = state.uri.queryParameters['id'] ?? "";
      return buildSlideTransitionPage(ApointmentDetails(id: id), state);
    },
  ),
  GoRoute(
    path: '/shedule_appointment',
    pageBuilder: (context, state) {
      final vendor_id = state.uri.queryParameters['vendorID'] ?? '';
      final start_time = state.uri.queryParameters['starttime'] ?? '';
      final end_time = state.uri.queryParameters['endtime'] ?? '';
      final totel_amount = state.uri.queryParameters['totalamount'] ?? '';
      return buildSlideTransitionPage(
          ScheduleAnAppointment(
              vendorID: vendor_id,
              starttime: start_time,
              endtime: end_time,
              totalamount: totel_amount),
          state);
    },
  ),
]);

Page<dynamic> buildSlideTransitionPage(Widget child, GoRouterState state) {
  if (Platform.isIOS) {
    return CupertinoPage(key: state.pageKey, child: child);
  }
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
