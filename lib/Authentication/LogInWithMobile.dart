import 'package:flutter/material.dart';

import 'OtpVerify.dart';
import '../Patient/screens/UserSelectionScreen.dart';

class LoginMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Welcome Text
                Text(
                  'Welcome!',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter"),
                ),
                SizedBox(height: 8),
                Text(
                  'Log in with your mobile number',
                  style: TextStyle(
                      fontSize: 16, color: Colors.grey, fontFamily: "Inter"),
                ),
                SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    "assets/login.png",
                    width: 200,
                    height: 200,
                  ),
                ),
                // Phone Number Input Field
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25), // Shadow color
                        spreadRadius: 1, // Adjusts the size of the shadow
                        blurRadius: 2, // How blurry the shadow is
                        offset: Offset(0, 2), // Position of the shadow
                      ),
                    ],
                  ),
                  child: Material(
                    elevation: 0, // Set elevation to 0 when using BoxShadow
                    borderRadius: BorderRadius.circular(30.0),
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone_android_outlined, color: Color(0xff808080)),
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        border: InputBorder.none, // Removes the default border
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50),
                // Get OTP Button
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OtpVerify()));
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF00C4D3),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Get OTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // OR Text
                Text(
                  'Or',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),

                // Sign in with Google Button
                Container(
                  width: double.infinity, // Full width
                  height: 50.0, // Set height for the button
                  margin: EdgeInsets.symmetric(
                      horizontal: 10.0), // Margin for spacing
                  child: Material(
                    color: Colors.white, // Button background color
                    borderRadius: BorderRadius.circular(30.0),
                    elevation: 2, // Shadow effect
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30.0),
                      onTap: () {
                        // Implement Sign in with Google functionality
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/google.png', // Google icon asset
                            height: 24.0,
                          ),
                          SizedBox(
                              width: 12.0), // Spacing between icon and text
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  width: double.infinity, // Full width
                  height: 50.0, // Set height for the button
                  margin: EdgeInsets.symmetric(
                      horizontal: 10.0), // Margin for spacing
                  child: Material(
                    color: Colors.white, // Button background color
                    borderRadius: BorderRadius.circular(30.0),
                    elevation: 2, // Shadow effect
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30.0),
                      onTap: () {
                        // Implement Sign in with Apple functionality
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/apple.png', // Apple icon asset
                            height: 24.0,
                          ),
                          SizedBox(
                              width: 12.0), // Spacing between icon and text
                          Text(
                            'Sign in with Apple',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),

                // Registration Link
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserSelectionScreen()));
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Don't you have an account? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Register",
                          style: TextStyle(
                              color: Color(0xFF00C4D3), // Register link color
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
