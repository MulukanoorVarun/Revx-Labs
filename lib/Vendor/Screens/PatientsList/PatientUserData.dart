import 'package:flutter/material.dart';
import 'package:revxpharma/Utils/color.dart';

import '../../../Components/CustomAppButton.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  bool startTests = true;
  bool selectTests = false;
  bool completeTests = false;
  bool value = false;
  bool isLoading = false;

  void onChanged(bool? newValue) {
    setState(() {
      value = newValue ?? false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body:     SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (startTests == true) ...[
                  Text(
                    'Patient Details',
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: primaryColor, width: 0.5),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: w * 0.27,
                              child: Text(
                                'Name',
                                style: TextStyle(
                                    color: Color(0xff151515),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              'Ramesh Kumar',
                              style: TextStyle(
                                  color: Color(0xff151515),
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: w * 0.27,
                              child: Text(
                                'Age',
                                style: TextStyle(
                                    color: Color(0xff151515),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              '25',
                              style: TextStyle(
                                  color: Color(0xff151515),
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: w * 0.27,
                              child: Text(
                                'Blood Group',
                                style: TextStyle(
                                    color: Color(0xff151515),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              'B+ve',
                              style: TextStyle(
                                  color: Color(0xff151515),
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: w * 0.27,
                              child: Text(
                                'Date of Birth',
                                style: TextStyle(
                                    color: Color(0xff151515),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              '08/11/1998',
                              style: TextStyle(
                                  color: Color(0xff151515),
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: w * 0.27,
                              child: Text(
                                'Address',
                                style: TextStyle(
                                    color: Color(0xff151515),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                maxLines: 3,
                                '7/130, Kakatiya Appartments, Madhapur, Hyderabad - 500081',
                                style: TextStyle(
                                    color: Color(0xff151515),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: w * 0.27,
                              child: Text(
                                'City',
                                style: TextStyle(
                                    color: Color(0xff151515),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              'Hyderabad',
                              style: TextStyle(
                                  color: Color(0xff151515),
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: w * 0.27,
                              child: Text(
                                'Phone',
                                style: TextStyle(
                                    color: Color(0xff151515),
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Text(
                              '9876543210',
                              style: TextStyle(
                                  color: Color(0xff151515),
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment date',
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Tuesday 23th April',
                            style: TextStyle(
                                color: Color(0xff151515),
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment Time',
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '10 : 00 A.M',
                            style: TextStyle(
                                color: Color(0xff151515),
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No. of Tests',
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Icon(Icons.circle,
                                    size: 5, color: Colors.black),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '05',
                                style: TextStyle(
                                    color: Color(0xff151515),
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Test Duration',
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '1hr - 30 min',
                            style: TextStyle(
                                color: Color(0xff151515),
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Test type - Anemia',
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                        const EdgeInsets.only(left: 15, bottom: 10),
                        child: Row(
                          children: [
                            Icon(Icons.circle,
                                size: 5, color: Colors.black),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                maxLines: 2,
                                'Vitamin B12 Test',
                                style: TextStyle(
                                    color: Color(0xff151515),
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price of Tests',
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Rs.2600/-',
                            style: TextStyle(
                                color: Color(0xff151515),
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PaymentType',
                            style: TextStyle(
                                color: primaryColor,
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '1hr - 30 min',
                            style: TextStyle(
                                color: Color(0xff151515),
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
                if (selectTests == true) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Test type - Anemia',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Status',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                              ),
                              child: Icon(Icons.circle,
                                  size: 5, color: Colors.black),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: w * 0.55,
                                child: Text(
                                  maxLines: 2,
                                  'Vitamin B12 Test',
                                  style: TextStyle(
                                      color: Color(0xff151515),
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            Spacer(),
                            Checkbox(
                                activeColor: primaryColor,
                                value: value,
                                onChanged: onChanged)
                          ],
                        ),
                      );
                    },
                  ),
                  Text(
                    'Tests Status',
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    maxLines: 2,
                    'Completed',
                    style: TextStyle(
                        color: Color(0xff151515),
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Description',
                    style: TextStyle(
                        color: primaryColor,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    maxLines: 2,
                    'All Tests are completed successfully.',
                    style: TextStyle(
                        color: Color(0xff151515),
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ]
              ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: CustomAppButton(
            text: startTests
                ? 'Start Tests'
                : selectTests
                ? 'Mark as Complete'
                : 'Test Completed',
            onPlusTap: () {
              if (startTests == true) {
                setState(() {
                  isLoading = true;
                  startTests == false;
                  selectTests == true;
                  completeTests == false;
                });
              } else if (selectTests == true) {
                setState(() {
                  isLoading = true;
                  startTests == false;
                  selectTests == false;
                  completeTests == true;
                });
              }
            }),
      ),
    );
  }
}
