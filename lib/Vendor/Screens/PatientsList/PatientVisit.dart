import 'package:flutter/material.dart';
import 'package:revxpharma/Utils/color.dart';
import 'package:revxpharma/Vendor/Screens/PatientsList/PatientUserData.dart';

class PatientVisit extends StatefulWidget {
  const PatientVisit({super.key});

  @override
  State<PatientVisit> createState() => _PatientVisitState();
}

class _PatientVisitState extends State<PatientVisit> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Visits : 3',
              style: TextStyle(
                color: Color(0xff808080),
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Appointments Cancelled : 1',
              style: TextStyle(
                color: Color(0xff808080),
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 2.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left side of the card
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '23 Apr',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              'Tuesday',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Cash paid',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: w * 0.2,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  '₹ 2500',
                                  style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        // Right side - empty container with border
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: primaryColor, width: 0.8),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // Column for test details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Test type',
                                    style: TextStyle(
                                      color: Color(0xff808080),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 18,
                                    color: Color(0xff808080),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Complete Blood Picture',
                                style: TextStyle(
                                  color: Color(0xff151515),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Medical Reports',
                                    style: TextStyle(
                                      color: Color(0xff151515),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.file_download_outlined,
                                    size: 16,
                                    color: Color(0xff0057FF),
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    'Download',
                                    style: TextStyle(
                                      color: Color(0xff0057FF),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.zero),
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.cyan.shade50)),
                                  onPressed: () {
                                  Navigator.pop(context);
                                  },
                                  child: Text(
                                    'View User Data',
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        fontFamily: 'Poppins'),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
