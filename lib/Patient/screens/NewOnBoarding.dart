import 'package:flutter/material.dart';

class NewOnBoarding extends StatefulWidget {
  const NewOnBoarding({super.key});

  @override
  State<NewOnBoarding> createState() => _NewOnBoardingState();
}

class _NewOnBoardingState extends State<NewOnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffECF2FF),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset(
              height: 200,
              width: 200,
              'assets/REVX_LOGO-removebg.png',
              fit: BoxFit.contain,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Color(0xff2D3894)),
                      color: Color(0xffCDE7FC),
                      borderRadius: BorderRadius.circular(11)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Image.asset(
                        'assets/ct-scan.png',
                        fit: BoxFit.contain,
                        height: 48,
                        width: 48,
                      ),
                      Text(
                        'Scan',
                        style: TextStyle(
                            color: Color(0xff2A3890),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Color(0xff2D3894)),
                      borderRadius: BorderRadius.circular(11)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Image.asset(
                        'assets/blood-test 1.png',
                        fit: BoxFit.contain,
                        height: 48,
                        width: 48,
                      ),
                      Text(
                        'Test’s',
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Color(0xff2D3894)),
                      borderRadius: BorderRadius.circular(11)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Image.asset(
                        'assets/x-rays 1.png',
                        fit: BoxFit.contain,
                        height: 48,
                        width: 48,
                      ),
                      Text(
                        'X-Ray’s',
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: Color(0xff2D3894)),
                      borderRadius: BorderRadius.circular(11)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      Image.asset(
                        'assets/healthcare 1.png',
                        fit: BoxFit.contain,
                        height: 48,
                        width: 48,
                      ),
                      Text(
                        'Package’s',
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
