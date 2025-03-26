import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/appointment_details/appointment_details_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:revxpharma/Utils/color.dart';
import '../logic/cubit/appointment_details/appointment_details_cubit.dart';

class ApointmentDetails extends StatefulWidget {
  String id;
  ApointmentDetails({super.key, required this.id});

  @override
  State<ApointmentDetails> createState() => _ApointmentDetailsState();
}

class _ApointmentDetailsState extends State<ApointmentDetails> {
  @override
  void initState() {
    context.read<AppointmentDetailsCubit>().fetchAppointmentDetails(widget.id);
    super.initState();
  }

  Future<void> downloadInvoice(String url) async {
    try {
      print("Checking storage permission...");
      var status = await Permission.mediaLibrary.status;

      if (!status.isGranted) {
        print("Storage permission not granted. Requesting...");
        await Permission.mediaLibrary.request();
      }
      status = await Permission.mediaLibrary.status;
      if (status.isGranted) {
        print("Storage permission granted.");
        Directory dir =
            Directory('/storage/emulated/0/Download/'); // for Android
        if (!await dir.exists()) {
          print(
              "Download directory does not exist. Using external storage directory.");
          dir = await getExternalStorageDirectory() ?? Directory.systemTemp;
        } else {
          print("Download directory exists: ${dir.path}");
        }

        String generateFileName(String originalName) {
          // Extract file extension
          String extension = originalName.split('.').last;
          // Generate unique identifier
          String uniqueId = DateTime.now().millisecondsSinceEpoch.toString();
          // Return unique filename with the same extension
          String fileName = "Prescription_$uniqueId.$extension";
          print("Generated filename: $fileName");
          return fileName;
        }

        // Start downloading the file
        print("Starting download from: $url");
        FileDownloader.downloadFile(
          url: url.toString().trim(),
          name: generateFileName("Order_invoice.docx"), // Adjusted here
          notificationType: NotificationType.all,
          downloadDestination: DownloadDestinations.publicDownloads,
          onDownloadRequestIdReceived: (downloadId) {
            print('Download request ID received: $downloadId');
          },
          onProgress: (fileName, progress) {
            print('Downloading $fileName: $progress%');
          },
          onDownloadError: (String error) {
            print('DOWNLOAD ERROR: $error');
          },
          onDownloadCompleted: (path) {
            print('Download completed! File saved at: $path');
            setState(() {
              // Update UI if necessary
            });
          },
        );
      } else {
        print("Storage permission denied.");
      }
    } catch (e, s) {
      print('Exception caught: $e');
      print('Stack trace: $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(title: "Appointment Details", actions: []),
      body: BlocBuilder<AppointmentDetailsCubit, AppointmentDetailsState>(
          builder: (context, state) {
        if (state is AppointmentDetailsLoading) {
          return _shimmerList();
        } else if (state is AppointmentDetailsLoaded) {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "OrderID : ${state.appointmentDetails?.appointmentData?.appointmentNumber ?? ''}",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${state.appointmentDetails?.appointmentData?.appointmentDate ?? ''}",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          "${state.appointmentDetails?.appointmentData?.diagnosticCentre?.name ?? ''}",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: primaryColor),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
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
                            width: w * 0.8, // 90% of screen width
                            child: Text(
                              "${state.appointmentDetails?.appointmentData?.diagnosticCentre?.location ?? ''}",
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
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 10, top: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffA9A9A9), width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.appointmentDetails?.appointmentData
                                  ?.appointmentTests?.length ??
                              0,
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                            height: 16,
                          ),
                          itemBuilder: (context, index) {
                            final test = state.appointmentDetails
                                ?.appointmentData?.appointmentTests?[index];
                            // final test = state.appointmentDetails
                            //     ?.appointment_data?.appointmentTests?[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        width: w * 0.18,
                                        height: w * 0.18,
                                        test?.testDetails?.testDetailsModel
                                                ?.image ??
                                            '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${test?.testDetails?.testDetailsModel?.testName ?? ''}',
                                          style: TextStyle(
                                            color: Color(0xff222222),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          '₹ ${test?.testDetails?.testDetailsModel?.price ?? 0}',
                                          style: TextStyle(
                                            color: Color(0xff222222),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          child: Center(
                                            child: Text(
                                              "Patients ${test?.noOfPersons}",
                                              style: TextStyle(
                                                  color: primaryColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Bill Summary",
                    style: TextStyle(
                      color: Color(0xff1A1A1A),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffA9A9A9), width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Order Amount",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                fontSize: 14,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              child: Text(
                                '₹ ${state.appointmentDetails?.appointmentData?.totalAmount ?? ''}',
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  if (state.appointmentDetails?.appointmentData?.appointmentReports?.isNotEmpty ?? false)...[
                    ElevatedButton(
                      onPressed: () {
                        downloadInvoice(state.appointmentDetails?.appointmentData?.appointmentReports?[0].reportUrl??"");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor, // Background color
                        foregroundColor: primaryColor, // Text/icon color
                        elevation: 8, // Shadow elevation
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12), // Rounded corners
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ), // Button padding
                        minimumSize: const Size(360, 30), // Button size
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.download_rounded,
                            size: 24,
                            color: Colors.white,
                          ),
                          SizedBox(width: 8), // Space between icon and text
                          Text(
                            'Download Invoice',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                                color: Colors.white,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        }
        return Center(child: Text("No Data Available"));
      }),
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   color: Colors.white,
      //   elevation: 10,
      //   child: ElevatedButton.icon(
      //     onPressed: () {
      //     },
      //     icon: Icon(Icons.download, color: Colors.white,applyTextScaling: true,),
      //     label: Text("Download Report", style: TextStyle(color: Colors.white,fontFamily: "Poppins")),
      //     style: ElevatedButton.styleFrom(
      //       elevation: 0,
      //       backgroundColor: primaryColor, // Change color as needed
      //       padding: EdgeInsets.symmetric(vertical: 12),
      //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      //     ),
      //   ),
      // ),
    );
  }

  Widget _shimmerList() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerText(120, 12, context),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerRectangle(20, context),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width *
                          0.8, // 90% of screen width
                      child: shimmerText(120, 12, context)),
                ],
              ),
            ],
          ),
          SizedBox(height: 23),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    height: 16,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              shimmerText(160, 12, context),
                              shimmerRectangle(20, context),
                            ],
                          ),
                          const SizedBox(height: 4),
                          shimmerText(60, 12, context)
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          shimmerText(120, 12, context),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    shimmerText(80, 12, context),
                    Spacer(),
                    shimmerText(60, 12, context),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    shimmerText(60, 12, context),
                    Spacer(),
                    shimmerText(60, 12, context),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Divider(
                  color: Color(0xff808080),
                  height: 1,
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    shimmerText(100, 12, context),
                    Spacer(),
                    shimmerText(60, 12, context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
