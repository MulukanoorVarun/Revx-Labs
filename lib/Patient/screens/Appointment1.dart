import 'package:flutter/material.dart';

import 'Payment.dart';

class appointmentscreens extends StatefulWidget {
  const appointmentscreens({super.key});

  @override
  State<appointmentscreens> createState() => _appointmentscreensState();
}

class _appointmentscreensState extends State<appointmentscreens> {
  int selectedAddressIndex = 0; // To track which card's radio button is selected

  // Dummy list of addresses
  final List<Map<String, String>> _addressList = [
    {'name': 'Home', 'address': 'Sri Satya Diagnostics lab,D.no 1256, Opp Ratnadeep Super Market,Kondapur,Hyderabad-500081, IL'},
    {'name': 'Office', 'address': 'Sri Lakshmi Diagnostics lab,D.no 1256, Opp Ratnadeep Super Market,Kondapur,Hyderabad-500081, IL'},
    {'name': 'Grandparents', 'address': 'Rainbow Diagnostics lab,D.no 1256, Opp Ratnadeep Super Market,Kondapur,Hyderabad -500081, IL'},
    {'name': 'Friend\'s Place', 'address': 'Rainbow labs, Opp Ratnadeep  SuperMarket,Kondapur,Hyderabad -500081, IL'},
  ];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff24AEB1)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Appointment",
          style: TextStyle(
            color: Color(0xff24AEB1),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff24AEB1)),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                "Selected Diagnostic Lab",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            const SizedBox(height: 10), // Space before the address list

            // List of address cards
            // Use a Container to ensure size constraints
            Container(
              constraints: BoxConstraints(maxHeight: h*0.7), // Adjust maxHeight as needed
              child: ListView.builder(
                shrinkWrap: true, // Ensure ListView only takes up as much space as needed
                physics: NeverScrollableScrollPhysics(), // Prevent ListView from scrolling
                itemCount: _addressList.length, // Number of address cards
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 10), // Add margin between cards
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: index,
                          groupValue: selectedAddressIndex,
                          onChanged: (int? value) {
                            setState(() {
                              selectedAddressIndex = value ?? 0;
                            });
                          },
                          activeColor: const Color(0xff24AEB1), // Radio button color
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _addressList[index]['address']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, color: Colors.black),
                          onPressed: () {
                            // Handle edit action here
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outlined, color: Colors.black),
                          onPressed: () {
                            // Handle delete action here
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20), // Add space before Selected Date & Time
            // Selected Date & Time Heading
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Selected Date & Time",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle change action here
                    },
                    child: const Text(
                      "Change",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Poppins",
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10), // Space before Date & Time card

            // Date & Time card
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: EdgeInsets.only(left: 15,right: 15,top: 15,),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "20 Sunday, 2024",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    "13:56 PM",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20), // Space before the continue button

            // Continue to Payment Button
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 15,right: 15,top: 15,),// Use double.infinity for full width
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xff24AEB1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Payment()));
                },
                child: const Text(
                  'Continue to Payment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            SizedBox(height: 100,)
          ],
        ),
      )
    );
  }
}