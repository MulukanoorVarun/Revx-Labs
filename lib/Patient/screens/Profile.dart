import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AccountSettings.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:

        Icon(Icons.arrow_back_ios_new,size: 20,),
        title: Center(
          child: Text(
            "Profile Information",
            style: TextStyle(
                color: Color(0xff27BDBE),
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          Icon(
            Icons.more_vert,
            size: 24,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius:60,

                    backgroundColor: Color(0xffffffff),
                    foregroundImage: AssetImage(

                      'assets/person.png',
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "Sandeep Reddy",
                    style: TextStyle(
                        color: Color(0xff151515),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "9876543210",
                    style: TextStyle(
                        color: Color(0xff151515),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins"),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Text("My Profile",
                style: TextStyle(
                    color: Color(0xff151515),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,

                    fontFamily: "Poppins")),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Image.asset(
                  "assets/apointments.png",
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  width: 24,
                ),
                Text("My Appointments",
                    style: TextStyle(
                        color: Color(0xff151515),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins")),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 24,
                )
              ],
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Image.asset(
                  "assets/carbon_book.png",
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  width: 24,
                ),
                Text("Medical Reports",
                    style: TextStyle(
                        color: Color(0xff151515),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins")),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 24,
                )
              ],
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Image.asset(
                  "assets/location.png",
                  height: 24,
                  width: 24,
                ),
                SizedBox(
                  width: 24,
                ),
                Text("Address",
                    style: TextStyle(
                        color: Color(0xff151515),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins")),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 24,
                )
              ],
            ),
            SizedBox(height: 40,),
            InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Accountsettings()));
            },
              child:
              Row(
                children: [
                  Image.asset(
                    "assets/settings.png",
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Text("Settings",
                      style: TextStyle(
                          color: Color(0xff151515),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins")),
                  Spacer(),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 24,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
