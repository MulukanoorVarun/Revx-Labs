import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Dashboard.dart';

class paymentoptionscreen extends StatelessWidget {
  const paymentoptionscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80,left: 16,right: 16,bottom: 20),
        child: Column(
          children: [
            const SizedBox(height: 30), // Space from top

            // Checkbox image at the top, centered
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/checkedimage.png', // Replace with your checkbox image path
                height: 80, // Adjust the height according to your image
                width: 80,  // Adjust the width according to your image
              ),
            ),
            const SizedBox(height: 20), // Space between image and text

            // Success message text
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Your Appointment has been booked successfully on 20 Sunday @ 10:00 A.M",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins",
                    color: Color(0xff151515)
                ),
              ),
            ),
            const SizedBox(height: 40), // Space between text and the image

            // Centered image below the success text
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                  'assets/bookedappointment.png', // Replace with your image path
                  height: 250, // Adjust the height according to your image
                  width: screenWidth  // Adjust the width according to your image
              ),
            ),

            const Spacer(), // Push the buttons to the bottom

            // First button: Filled "Continue" button
            Container(
              width: screenWidth,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xff24AEB1), // Border color
                ),
                borderRadius: BorderRadius.circular(30), // Curved corners
              ),
              child: TextButton(
                onPressed: () {
                  // Handle set reminder action here
                },
                child: const Text(
                  'Set a  Reminder',
                  style: TextStyle(
                    color: Color(0xff27BDBE),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15), // Space between the buttons

            // Second button: Outlined "Set Reminder" button

            Container(
              width: screenWidth,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xff24AEB1), // Filled button background color
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Dashboard()));
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30), // Space at the bottom
          ],
        ),
      ),
    );
  }
}