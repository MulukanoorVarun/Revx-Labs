import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Models/DiognisticCenterDetailModel.dart';
import 'package:revxpharma/Patient/logic/cubit/diagnostic_detail/diagnostic_detail_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/diagnostic_detail/diagnostic_detail_state.dart';
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
    context.read<DiagnostocDetailCubit>().fetchDiagnosticDetails(widget.diognosticId??"");
    super.initState();
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
    return BlocBuilder<DiagnostocDetailCubit, DiagnosticDetailState>(
        builder: (context, state) {

          if (state is DiagnosticDetailLoading) {
            return _shimmer(context); // 🔄 Show loading
          } else if (state is DiagnosticDetailLoaded) {


            String? startTimeStr = state.diagnostic_details.diognostic_details?.startTime;
            String? endTimeStr = state.diagnostic_details.diognostic_details?.endTime;

            DateTime? openingTime;
            DateTime? closingTime;
            bool isOpen = false;

            if (startTimeStr != null && startTimeStr.isNotEmpty &&
                endTimeStr != null && endTimeStr.isNotEmpty) {
              try {
                openingTime = DateFormat("HH:mm:ss").parse(startTimeStr);
                closingTime = DateFormat("HH:mm:ss").parse(endTimeStr);


                DateTime now = DateTime.now();
                DateTime currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
                DateTime openingToday = DateTime(now.year, now.month, now.day, openingTime.hour, openingTime.minute, openingTime.second);
                DateTime closingToday = DateTime(now.year, now.month, now.day, closingTime.hour, closingTime.minute, closingTime.second);

                isOpen = currentTime.isAfter(openingToday) && currentTime.isBefore(closingToday);
              } catch (e) {
                debugPrint("Error parsing time: $e");
              }
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
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
                      state.diagnostic_details.diognostic_details?.image ?? '',
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: 80,
                    ),
                  ],
                ),
              ),
              backgroundColor: Color(0xffffffff),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            state.diagnostic_details.diognostic_details?.image ?? '',
                            height: 24,
                            width: 24,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              state.diagnostic_details.diognostic_details?.name ?? '',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins"),
                            ),
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
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width *
                                    0.8, // 90% of screen width
                                child: Text(
                                  state.diagnostic_details.diognostic_details?.location ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xff949494),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ),
                              isOpen?
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
                                    formatOpeningDays(   state.diagnostic_details.diognostic_details?.daysOpened,),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      fontFamily: "Poppins",
                                    ),
                                  ),


                                ],
                              ): Text(
                                "Close now",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff00BE13),
                                    fontFamily: "Poppins"),
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

                      Html(data: state.diagnostic_details.diognostic_details?.description ?? '', style: {
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
                                    state.diagnostic_details.diognostic_details?.contactPerson ?? '',
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
                                    state.diagnostic_details.diognostic_details?.contactMobile ?? '',
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
          }  else if (state is DiagnosticDetailError) {
      return Center(child: Text(state.message));
    }
    return Center(child: Text("No Data"));
        });
  }

  Widget _shimmer(BuildContext context) {
    double w = MediaQuery
        .of(context)
        .size
        .width;
    double h = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Column(children: [
        Expanded(
            child: ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Center(
                              child: shimmerContainer(w * 0.7, 120, context),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                shimmerRectangle(30, context),
                                SizedBox(
                                  width: 10,
                                ),
                                shimmerText(180, 16, context),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                shimmerRectangle(30, context),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    shimmerText(180, 16, context),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    shimmerText(180, 16, context),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            shimmerText(120, 16, context),
                            SizedBox(
                              height: 16,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      shimmerText(w, 16, context),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            shimmerText(160, 16, context),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      shimmerText(120, 16, context),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          shimmerCircle(30, context),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          shimmerText(120, 16, context),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        shimmerText(120, 16, context),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            shimmerCircle(30, context),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            shimmerText(120, 16, context),
                                          ],
                                        )
                                      ]),
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            shimmerText(120, 16, context),
                            SizedBox(
                              height: 10,
                            ),
                            shimmerText(200, 16, context),
                            SizedBox(
                              height: 10,
                            ),
                            shimmerText(160, 16, context),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  shimmerText(200, 16, context),
                                  shimmerText(60, 16, context),
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                            shimmerText(w, 16, context),
                          ]));
                }))
      ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          shimmerContainer(160, 40, context),
          shimmerContainer(160, 40, context)
        ]),
      ),
    );
  }

}
