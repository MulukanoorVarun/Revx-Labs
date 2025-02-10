import 'package:flutter/material.dart';

import '../../Vendor/Screens/VendorRegisterScreen.dart';
import 'Register.dart';


class UserSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select User Type", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,fontFamily: "Poppins"))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            Text("Register as:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,fontFamily: "Poppins")),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildUserCard(
                  context,
                  "Vendor",
                  "assets/lab.webp",
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VendorRegisterScreen()));
                  },
                ),
                _buildUserCard(
                  context,
                  "Patient",
                  "assets/patient.webp", // Replace with actual image path
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
            child: Image.asset(imagePath, height: 100, width: 100, fit: BoxFit.cover),
          ),
          SizedBox(height: 10),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,fontFamily: "Poppins")),
        ],
      ),
    );
  }




}
