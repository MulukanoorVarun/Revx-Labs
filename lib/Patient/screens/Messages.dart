import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  bool isNotificationsSelected = true; // To manage selected tab

  final List<Map<String, String>> notifications = [
    {"image": "assets/likitha.png", "text": "Liktha’s Diagnostics"},
    {"image": "assets/konark.png", "text": "Konark Diagnostic center"},
    {"image": "assets/galaxy.png", "text": "Galaxy Plus Laboratory"},
    {"image": "assets/digital.png", "text": "Digital Diagnostic Center"},
  ];

  final List<Map<String, String>> reminders = [
    {"image": "assets/likitha.png", "text": "Liktha’s Diagnostics"},
    {"image": "assets/konark.png", "text": "Konark Diagnostic center"},
    {"image": "assets/galaxy.png", "text": "Galaxy Plus Laboratory"},
    {"image": "assets/digital.png", "text": "Digital Diagnostic Center"},
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
            "Messages",
            style: TextStyle(
                color: primaryColor,
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
                            "Messages",
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
                            "Calls",
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
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: notifications.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: Color(0xffEDF6FF),
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(right: 16, top: 8,bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor, width: 1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                notifications[index]["image"]!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              notifications[index]["text"]!,
                              style: TextStyle(
                                color: Color(0xff3A3A3A),
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Active Now",
                            style: TextStyle(
                              color: Color(0xff00AB30),
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: reminders.length,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: Color(0xffEDF6FF),
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(right: 16, top: 8,bottom: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: primaryColor, width: 1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                reminders[index]["image"]!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              reminders[index]["text"]!,
                              style: TextStyle(
                                color: Color(0xff3A3A3A),
                                fontFamily: "Poppins",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(Icons.arrow_forward_ios_sharp),
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
