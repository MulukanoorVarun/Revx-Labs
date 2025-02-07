import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Patient/logic/bloc/internet_status/internet_status_bloc.dart';

class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InternetStatusBloc, InternetStatusState>(
        listener: (context, state) {
          if (state is InternetStatusBackState) {
            // If internet is back, automatically go back to the previous screen
            Navigator.pop(context);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/nointernet.jpg",
                width: 200,
                height: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: Text(
                  "Connect to the Internet",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Text(
                  "You are Offline. Please Check Your Connection",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Manually trigger internet check
                  context.read<InternetStatusBloc>().add(CheckInternetEvent());
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 38),
                  child: Container(
                    width: 240,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xff02017d),
                    ),
                    child: Center(
                      child: Text(
                        "Retry",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
