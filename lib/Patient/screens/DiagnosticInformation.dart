import 'package:flutter/material.dart';
import 'package:revxpharma/Models/DiognisticCenterDetailModel.dart';
import 'package:revxpharma/Services/UserapiServices.dart';

import 'ScheduleAppointment.dart';

class DiagnosticInformation extends StatefulWidget {
  @override
  State<DiagnosticInformation> createState() => _DiagnosticInformationState();
}

class _DiagnosticInformationState extends State<DiagnosticInformation> {
  @override
  void initState() {
    getDignosticDetails();
    super.initState();
  }

  Future<void> getDignosticDetails() async {
    var res = UserApi.diognosticCenterDetails();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        leading: Container(),
        leadingWidth: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.arrow_back_ios_sharp),
            Image.asset(
              "assets/likita.png",
              width: double.infinity,
              height: 80,
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffffffff),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First row: Image + Text
              Row(
                children: [
                  Image.asset(
                    "assets/hospital.png",
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Likitha’s Diagnostics Speciality lab",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                  )
                ],
              ),
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/location.png",
                    height: 20,
                    width: 20,
                    color: Colors.red,
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kondapur, Hyderabad",
                        style: TextStyle(
                            color: Color(
                              0xff949494,
                            ),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins"),
                      ),
                      Row(
                        children: [
                          Text(
                            "Open now",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff00BE13),
                                fontFamily: "Poppins"),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Opens Mon - Sat",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16),
              Text(
                "Description ",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff24AEB1),
                    fontFamily: "Poppins"),
              ),
              // Heading Text

              SizedBox(height: 8),

              // Description Text
              Text(
                "The Comprehensive Full Body Checkup with Vitamin D & B12 is ideal for people who want to monitor their overall health. It provides a range of tests to check the health of the Heart, Thyroid, Kidney, and Liver. It also includes tests for Blood Sugar, Complete Blood Count, Lipid Profile and Complete Urine Analysis. In addition, it includes tests for Vitamin D, Vitamin B12, and Iron levels",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    height: 1.7),
              ),
              SizedBox(height: 16),

              // More Information Heading
              Text(
                "More Information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  color: Color(0xff24AEB1),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact Person",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.person),
                          Text(
                            "John Doe",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff949494),
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact Number",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.call),
                          Text(
                            "+123 456 7890",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff949494),
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Address Heading and Address
              Text(
                "Address",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                  height: 8), // Optional spacing between heading and address
              Text(
                "D.no : 1270, Opposite Rathnadeep Market, Kondapur, Hyderabad - 500081",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff949494),
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: 26),

              // Services Available Heading
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Services Available",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff24AEB1),
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                ],
              ),
              Text(
                "All types of tests in Pathology, Radiology ........",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff949494),
                  fontFamily: "Poppins",
                ),
              ),

              SizedBox(height: 36),
              // Buttons with curved borders
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: Color(0xff27BDBE)),
                      ),
                      child: Text(
                        'Send Message',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff27BDBE),
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff24AEB1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScheduleAnAppointment()));
                    },
                    // icon: Icon(Icons.add, color: Colors.white),
                    // iconAlignment: IconAlignment.end, // "+" icon
                    label: Text(
                      'Book Appointment',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
