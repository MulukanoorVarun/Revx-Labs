import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import 'MyAppointments.dart';

class ApointmentSuccess extends StatefulWidget {
  final String appointmentmsg;
  const ApointmentSuccess({Key? key, required this.appointmentmsg})
      : super(key: key);

  @override
  State<ApointmentSuccess> createState() => _ApointmentSuccessState();
}

class _ApointmentSuccessState extends State<ApointmentSuccess> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
      context.pushReplacement('/my_appointments');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent back navigation
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/sucessfully.json',
                height: 150,
                width: 150,
              ),
              SizedBox(height: 20),
              Text(
                "${widget.appointmentmsg}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
