import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../Components/ShakeWidget.dart';
import 'Dashboard.dart';
import 'Register.dart';

class OtpVerify extends StatefulWidget {
  @override
  _OtpVerifyState createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  final TextEditingController otpController = TextEditingController();
  final FocusNode focusNodeOTP = FocusNode();
  String _verifyMessage = "";
  double screenWidth = 0; // Initialize this to the actual screen width if needed

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width; // Get screen width

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50,left: 15,right: 15,bottom: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Welcome Text
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Verify mobile number with OTP',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Image.asset(
                    "assets/otp.png",
                    width: 200,
                    height: 200,
                  ),
                ),

                // Phone Number Input Field
                SizedBox(height: 20),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: PinCodeTextField(
                    autoUnfocus: true,
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    blinkWhenObscuring: true,
                    autoFocus: true,
                    autoDismissKeyboard: false,
                    showCursor: true,
                    animationType: AnimationType.fade,
                    focusNode: focusNodeOTP,
                    hapticFeedbackTypes: HapticFeedbackTypes.heavy,
                    controller: otpController,
                    onTap: () {
                      setState(() {
                        _verifyMessage = "";
                      });
                    },
                    onChanged: (v) {
                      setState(() {
                        _verifyMessage = "";
                      });
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 50,
                      fieldWidth: 50,
                      fieldOuterPadding: EdgeInsets.only(left: 0, right: 3),
                      activeFillColor: Color(0xFFF4F4F4),
                      activeColor: Color(0xff2DB3FF),
                      selectedColor: Color(0xff2DB3FF),
                      selectedFillColor: Color(0xFFF4F4F4),
                      inactiveFillColor: Color(0xFFF4F4F4),
                      inactiveColor: Color(0xFFD2D2D2),
                      inactiveBorderWidth: 1.5,
                      selectedBorderWidth: 2.2,
                      activeBorderWidth: 2.2,
                    ),
                    textStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                    cursorColor: Colors.black,
                    enableActiveFill: true,
                    keyboardType: TextInputType.numberWithOptions(),
                    textInputAction: (Platform.isAndroid)
                        ? TextInputAction.none
                        : TextInputAction.done,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      ),
                    ],
                    enablePinAutofill: true,
                    useExternalAutoFillGroup: true,
                    beforeTextPaste: (text) {
                      return true;
                    },
                  ),
                ),
                if (_verifyMessage.isNotEmpty) ...[
                  Center(
                    child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                      width: screenWidth * 0.6,
                      child:
                      ShakeWidget(
                        key: Key("value"),
                        duration: Duration(milliseconds: 700),
                        child: Text(
                          _verifyMessage,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 13,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                Align(
                  alignment: Alignment.topRight,
                  child:
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Text(
                      "Resend OTP"
                    ),
                  ),
                ),

                SizedBox(height: 20),
                // Get OTP Button
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Dashboard()));
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
                      'Verify',
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
                  margin: EdgeInsets.symmetric(horizontal: 10.0), // Margin for spacing
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
                          SizedBox(width: 12.0), // Spacing between icon and text
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
                  margin: EdgeInsets.symmetric(horizontal: 10.0), // Margin for spacing
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
                          SizedBox(width: 12.0), // Spacing between icon and text
                          Text(
                            'Sign in with Apple',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400
                            ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
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
                              fontFamily: "Poppins"
                          ),
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
