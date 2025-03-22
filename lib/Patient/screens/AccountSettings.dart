import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Authentication/LogInWithEmail.dart';
import 'package:revxpharma/Patient/screens/Profile.dart';
import 'package:revxpharma/Patient/screens/ProfileSettings.dart';
import 'package:revxpharma/Utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Authentication/ChangePassword.dart';

class Accountsettings extends StatefulWidget {
  const Accountsettings({super.key});

  @override
  State<Accountsettings> createState() => _AccountsettingsState();
}

class _AccountsettingsState extends State<Accountsettings> {
  bool isSms = false;
  bool isPush = false;
  bool isPromotional = false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Account Settings",
          style: TextStyle(
            color: primaryColor,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Update your settings like notifications, payments, profile edit etc.",
                style: TextStyle(
                    color: Color(0xff868686),
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  context.push('/profile');
                },
                child: Container(
                  width: w,
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/profile.png",
                        height: 15,
                        width: 15,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Profile Information",
                              style: TextStyle(
                                  color: Color(0xff010F07),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Poppins")),
                          SizedBox(
                            height: 8,
                          ),
                          Text("Change your account information",
                              style: TextStyle(
                                  color: Color(0xff010F07),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                context.push('/change_password');
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/lock.png",
                      height: 15,
                      width: 15,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Change Password",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins")),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Change your password",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins")),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
              context.push('/account_settings');
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/card.png",
                      height: 15,
                      width: 15,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Payment Methods",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins")),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Add your credit & debit cards",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins")),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                 context.push('/account_settings');
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/marker.png",
                      height: 15,
                      width: 15,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Container(
                      width: w * 0.7,
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Locations",
                              style: TextStyle(
                                  color: Color(0xff010F07),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Poppins")),
                          SizedBox(
                            height: 8,
                          ),
                          Text("Add or remove your delivery locations",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Color(0xff010F07),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  context.push('/account_settings');
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/facebook.png",
                      height: 15,
                      width: 15,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Add Social Account",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins")),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Add Facebook, Twitter etc ",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins")),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  context.push('/account_settings');
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/refer.png",
                      height: 15,
                      width: 15,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Refer to Friends",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins")),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Get 10 for reffering friends",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins")),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Notifications",
                style: TextStyle(
                    color: Color(0xff010F07),
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  context.push('/account_settings');
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/ring.png",
                      height: 15,
                      width: 15,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Push Notifications",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins")),
                        SizedBox(
                          height: 8,
                        ),
                        Text("For daily update you will get it",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins")),
                      ],
                    ),
                    Spacer(),
                    Switch(
                      activeColor: Color(0xffEEA734),
                      inactiveThumbColor: Color(0xff868686),
                      value: isPush,
                      onChanged: (value) {
                        setState(() {
                          isPush = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  context.push('/account_settings');
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/ring.png",
                      height: 15,
                      width: 15,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SMS Notifications",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins")),
                        SizedBox(
                          height: 12,
                        ),
                        Text("For daily update you will get it",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins")),
                      ],
                    ),
                    Spacer(),
                    Switch(
                      activeColor: Color(0xffEEA734),
                      inactiveThumbColor: Color(0xff868686),
                      value: isSms,
                      onChanged: (value) {
                        setState(() {
                          isSms = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  context.push('/account_settings');
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/ring.png",
                      height: 15,
                      width: 15,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Container(
                      width: w * 0.6,
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Promotional Notifications",
                              style: TextStyle(
                                  color: Color(0xff010F07),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Poppins")),
                          SizedBox(
                            height: 12,
                          ),
                          Text("For daily update you will get it",
                              maxLines: 2,
                              style: TextStyle(
                                  color: Color(0xff010F07),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                    Spacer(),
                    Switch(
                      activeColor: primaryColor,
                      inactiveThumbColor: Color(0xff868686),
                      value: isPromotional,
                      onChanged: (value) {
                        setState(() {
                          isPromotional = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "More",
                style: TextStyle(
                    color: Color(0xff010F07),
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),

              InkWell(
                onTap: () {
                  context.push('/account_settings');
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/rating.png",
                      height: 16,
                      width: 16,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rate Us",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins")),
                        SizedBox(
                          height: 12,
                        ),
                        Text("Rate us playstore, appstor",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins")),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),

              InkWell(
                onTap: () {
                  context.push('/account_settings');
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/faq.png",
                      height: 15,
                      width: 15,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("FAQ",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                fontFamily: "Poppins")),
                        SizedBox(
                          height: 12,
                        ),
                        Text("Frequently asked questions",
                            style: TextStyle(
                                color: Color(0xff010F07),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins")),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),

              InkWell(
                onTap: () {
                  _showLogoutDialog(context);
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/logout.png",
                      height: 25,
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Text("Logout",
                        style: TextStyle(
                            color: Color(0xff010F07),
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Poppins")),

                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 4.0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 14.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Power Icon Positioned Above Dialog
                Positioned(
                  top: -35.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 6.0, color: Colors.white),
                      shape: BoxShape.circle,
                      color: Colors.red.shade100, // Light red background
                    ),
                    child: const Icon(
                      Icons.power_settings_new,
                      size: 40.0,
                      color: Colors.red, // Power icon color
                    ),
                  ),
                ),

                // Dialog Content
                Positioned.fill(
                  top: 30.0, // Moves content down
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15.0),
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                            fontFamily: "Poppins"
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "Are you sure you want to logout?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                              fontFamily: "Poppins"
                          ),
                        ),
                        const SizedBox(height: 20.0),

                        // Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // No Button (Filled)
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () => context.pop(),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                  primaryColor, // Filled button color
                                  foregroundColor: Colors.white, // Text color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: const Text("No",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: "Poppins"
                                  ),
                                ),
                              ),
                            ),

                            // Yes Button (Outlined)
                            SizedBox(
                              width: 100,
                              child: OutlinedButton(
                                onPressed: () async {
                                  SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                                  sharedPreferences.remove('access_token');
                                  context.push('/login');
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                  primaryColor, // Text color
                                  side: BorderSide(
                                      color: primaryColor), // Border color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: const Text(
                                  "Yes",
                                  style: TextStyle( fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
