import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Utils/NoInternet.dart';
import '../logic/bloc/internet_status/internet_status_bloc.dart';
import 'OnBoarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String token="";
  String status="";

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<InternetStatusBloc, InternetStatusState>(
        listener: (context, state) {
          if (state is InternetStatusBackState) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>OnBoard()));
            });
          } else if (state is InternetStatusLostState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NoInternetWidget()),
            );
          }
        },
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              height: screenheight,
              child: Center(
                child: Image.asset(
                  "assets/logo.png",
                  width: 260,
                  height: 150,
                  fit:BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
