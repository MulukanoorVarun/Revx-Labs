import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:revxpharma/Models/DiognisticCenterDetailModel.dart';
import 'package:revxpharma/Services/UserapiServices.dart';

import 'ScheduleAppointment.dart';

class DiagnosticInformation extends StatefulWidget {
  String diognosticId;
  DiagnosticInformation({required this.diognosticId});
  @override
  State<DiagnosticInformation> createState() => _DiagnosticInformationState();
}

class _DiagnosticInformationState extends State<DiagnosticInformation> {
  @override
  void initState() {
    getDignosticDetails();
    super.initState();
  }

  bool isLoading = true;

  Diognostic_details? diognosticdetails;

  Future<void> getDignosticDetails() async {
    var res = await UserApi.diognosticCenterDetails(widget.diognosticId);
    setState(() {
      if (res?.settings?.success == 1) {
        isLoading = false;
        diognosticdetails = res?.diognostic_details;
      } else {
        isLoading = false;
        print("Error fetching diagnostic details");
      }
    });
  }

  String formatOpeningDays(List<String>? days) {
    if (days == null || days.isEmpty) {
      return "Closed";
    }

    List<String> abbreviatedDays = days.map((day) {
      switch (day) {
        case "Monday":
          return "Mon";
        case "Tuesday":
          return "Tue";
        case "Wednesday":
          return "Wed";
        case "Thursday":
          return "Thu";
        case "Friday":
          return "Fri";
        case "Saturday":
          return "Sat";
        case "Sunday":
          return "Sun";
        default:
          return day;
      }
    }).toList();

    return abbreviatedDays.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: 120,
        leading: Container(),
        leadingWidth: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_sharp)),
            Image.network(
                diognosticdetails?.image??'',
           fit: BoxFit.contain,
              width: double.infinity,
              height: 80,
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xffffffff),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Color(0xff24AEB1),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First row: Image + Text
                    Row(
                      children: [
                        Image.network(
                          diognosticdetails?.image ?? '',
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(width: 10),
                        Text(
                          diognosticdetails?.name ?? '',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        )
                      ],
                    ),
                    SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/location.png",
                          height: 20,
                          width: 20,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              diognosticdetails?.location ?? "",
                              style: TextStyle(
                                  color: Color(
                                    0xff949494,
                                  ),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins"),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Open now",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff00BE13),
                                      fontFamily: "Poppins"),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  formatOpeningDays(
                                      diognosticdetails?.daysOpened),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    Text(
                      "Description ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff24AEB1),
                          fontFamily: "Poppins"),
                    ),
                    // Heading Text

                    SizedBox(height: 8),

                    Html(data: diognosticdetails?.description ?? '', style: {
                      "body": Style(
                        fontSize: FontSize(12),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                      ),
                    }),
                    SizedBox(height: 16),

                    // More Information Heading
                    Text(
                      "More Information",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        color: Color(0xff24AEB1),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact Person",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.person),
                                Text(
                                  diognosticdetails?.contactPerson??'',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff949494),
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact Number",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: "Poppins",
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.call),
                                Text(
                                  diognosticdetails?.contactMobile??'',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff949494),
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Address Heading and Address
                    Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(
                        height:
                            8), // Optional spacing between heading and address
                    Text(
                      "D.no : 1270, Opposite Rathnadeep Market, Kondapur, Hyderabad - 500081",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff949494),
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height: 26),

                    // Services Available Heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Services Available",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff24AEB1),
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                    Text(
                      "All types of tests in Pathology, Radiology ........",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff949494),
                        fontFamily: "Poppins",
                      ),
                    ),

                    SizedBox(height: 36),
                    // Buttons with curved borders
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              border: Border.all(color: Color(0xff27BDBE)),
                            ),
                            child: Text(
                              'Send Message',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff27BDBE),
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff24AEB1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ScheduleAnAppointment()));
                          },
                          // icon: Icon(Icons.add, color: Colors.white),
                          // iconAlignment: IconAlignment.end, // "+" icon
                          label: Text(
                            'Book Appointment',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
