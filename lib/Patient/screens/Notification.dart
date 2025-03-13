import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revxpharma/Utils/color.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool isNotificationsSelected = true; // To manage selected tab

  final List<String> notifications = [
    "Your profile has been updated",
    "Your profile has been updated",
    "Your profile has been updated",
    "Your profile has been updated"
  ];

  final List<String> reminders = [
    "You have an appointment on 20th April Sunday at 10:00 AM",
    "You have an appointment on 20th April Sunday at 10:00 AM",
    "You have an appointment on 20th April Sunday at 10:00 AM",
    "You have an appointment on 20th April Sunday at 10:00 AM"
  ];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
        ),
        title: Center(
          child: Text(
            "Notifications",
            style: TextStyle(
                color: primaryColor,
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:10.0),
            child: Icon(
              Icons.more_vert,
              size: 24,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: primaryColor, width: 1),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isNotificationsSelected = true;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: w * 0.44, // Adjusted width to match the design
                        decoration: BoxDecoration(
                          color: isNotificationsSelected
                              ? primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Notifications",
                            style: TextStyle(
                              color: isNotificationsSelected
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isNotificationsSelected = false;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: w * 0.44, // Adjusted width to match the design
                        decoration: BoxDecoration(
                          color: !isNotificationsSelected
                              ? primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Reminders",
                            style: TextStyle(
                              color: !isNotificationsSelected
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              if (isNotificationsSelected)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff000000), width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              notifications[index],
                              style: TextStyle(
                                color: Color(0xff3A3A3A),
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "View",
                            style: TextStyle(
                              color: primaryColor,
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Delete",
                            style: TextStyle(
                                color: Color(0xff3A3A3A),
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  },
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                      margin: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff000000), width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              reminders[index],
                              style: TextStyle(
                                color: Color(0xff3A3A3A),
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "View",
                            style: TextStyle(
                              color: primaryColor,
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Delete",
                            style: TextStyle(
                                color: Color(0xff3A3A3A),
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
