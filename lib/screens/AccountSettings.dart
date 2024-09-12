import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revxpharma/screens/ChangePassword.dart';

class Accountsettings extends StatefulWidget {
  const Accountsettings({super.key});

  @override
  State<Accountsettings> createState() => _AccountsettingsState();
}

class _AccountsettingsState extends State<Accountsettings> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Account Settings",
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accountsettings()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accountsettings()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accountsettings()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accountsettings()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accountsettings()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accountsettings()));
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
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          isSelected = value;
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accountsettings()));
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
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          isSelected = value;
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accountsettings()));
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

                    Switch(
                      activeColor: Color(0xffEEA734),
                      inactiveThumbColor: Color(0xff868686),
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          isSelected = value;
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accountsettings()));
                },
                child: Row(
                  children: [
                    Image.asset(
                      "assets/rating.png",
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accountsettings()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Accountsettings()));
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
}
