import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revxpharma/screens/Payment.dart';

import 'Appointment1.dart';

class Apointments extends StatefulWidget {
  const Apointments({super.key});

  @override
  State<Apointments> createState() => _ApointmentsState();
}

class _ApointmentsState extends State<Apointments> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Appointment",
          style: TextStyle(
            color: Color(0xff27BDBE),
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Sri Satya Diagnostics labs",
                    style: TextStyle(
                      color: Color(0xff1A1A1A),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 20,
                    padding: EdgeInsets.symmetric(horizontal: 13),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xffC00000),
                        width: 0.7,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Change",
                        style: TextStyle(
                          color: Color(0xffC00000),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 23),
              Text(
                "Selected Patient",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                width: w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Radio(
                      activeColor: Color(0xff27BDBE),
                      value: 1,
                      groupValue: 1, // Update this as needed
                      onChanged: (value) {
                        // Handle radio button change
                      },
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sandeep Reddy",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "48 Years / Male / B+ve",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Change",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                width: w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],

                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Selected Test : 1",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.delete_outline, color: Color(0xff000000)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          "Complete Blood Picture (CBP)",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "₹ 400",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                width: w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],

                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Add More Tests",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(10),
                width: w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],

                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Time slot",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 14),
                    Row(
                      children: [
                        Text(
                          "Start Time",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.keyboard_arrow_down),
                        Spacer(),
                        Text(
                          "End Time",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(Icons.keyboard_arrow_down),
                      ],
                    ),



                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Bill Summary",
                style: TextStyle(
                  color: Color(0xff1A1A1A),
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),

              Container(
                padding: EdgeInsets.all(10),
                width: w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],

                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No. of Tests",
                      style: TextStyle(
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Total MRP",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "₹ 400 .00",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),

                    Row(
                      children: [
                        Text(
                          "Discount Applied",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "₹ 100 .00",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 13,),
                    Divider(
                      color: Color(0xff808080),height: 1,


                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Text(
                          "Amount to be paid",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "₹ 300.00",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),







                  ],
                ),
              ),


              InkWell(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>appointmentscreens()));
              },
                child: Container(
                  margin: EdgeInsets.only(top: 40,bottom: 20),
                  width: w,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF00C4D3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      'Save & Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
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