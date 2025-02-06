import 'package:flutter/material.dart';
import 'package:revxpharma/Components/CustomAppButton.dart';

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
                  fontWeight: FontWeight.w400),
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
                  fontWeight: FontWeight.w400),
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
                        borderRadius: BorderRadius.circular(4)),
                    elevation: 2.0,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '23 Apr',
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Poppins'),
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
                                    fontFamily: 'Poppins'),
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
                                    fontFamily: 'Poppins'),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(width: w*0.2,
                                padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xff27BDBE),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Text(
                                    '₹ 2500',
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontFamily: 'Poppins',fontSize: 14,fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 10,),
                          Divider(thickness: 0.8,color: Color(0xff27BDBE),)
                        ],
                      ),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
