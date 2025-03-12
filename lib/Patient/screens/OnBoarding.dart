import 'package:flutter/material.dart';
import 'package:revxpharma/Utils/Preferances.dart';
import 'Onboard1.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {

  @override
  void initState() {
  PreferenceService().saveString('on_boarding', '1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffE2F5FF),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 92, left: 24, right: 24),
                child: Image.asset(
                  "assets/onboarding1.png",
                  width: w,
                  height: h * 0.4, // Adjusted height for better fit
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: h * 0.3,
              width: w,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                color: const Color(0xffBBE9FE),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFE1E7FD),
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Schedule appointments and ready for the lab tests ",
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Find experienced specialist doctors and book your appointments hassle-free ",
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>OnBoardOne()));
                  },
                    child: Container(
                      width: w,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xff008675),
                      ),
                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
