import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revxpharma/Components/CustomAppButton.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/ShakeWidget.dart';
import 'package:revxpharma/Utils/color.dart';

class Prescription extends StatefulWidget {
  const Prescription({super.key});

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _aboutPrescriptionController = TextEditingController();
  TextEditingController _relationController = TextEditingController();
  @override
  void initState() {
    _bottomsheet(context);
    super.initState();
  }
  String _validateName = '';
  String _validateAbout = '';
  String _validateRelation = '';
  Future _bottomsheet(BuildContext context) {
    final h = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: h * 0.8,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 3,
                  decoration: BoxDecoration(
                      color: CupertinoColors.inactiveGray,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              Image.asset(
                'assets/file_upload.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Text(
                'Upload Your Prescription',
                style: TextStyle(
                    color: Color(0xff1A1A1A),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400),
              ),

              Row(
                spacing: 10,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryColor,
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          size: 16,
                          color: Color(0xffffffff),
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: primaryColor, width: 1)),
                    child: Row(
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.photo,
                          size: 16,
                          color: Color(0xff202020),
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            color: Color(0xff202020),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: Color(0xffC5B8B8),
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: 'Note: ',
                  style: TextStyle(
                    color: Color(0xff1A1A1A),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Prescription should Contains',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Poppins',
                        color: Color(0xff1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: Color(0xffEAEBF4),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Stethoscope.png',
                            scale: 3,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            'Doctor\nDetails',
                            style: TextStyle(
                                color: Color(0xff1A1A1A),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xffEAEBF4),
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/CalendarDots.png',
                          scale: 3,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Date of\nPresription ',
                          style: TextStyle(
                              color: Color(0xff1A1A1A),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                        color: Color(0xffEAEBF4),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/UserList.png',
                            scale: 3,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            'Patient\nDetails',
                            style: TextStyle(
                                color: Color(0xff1A1A1A),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: Color(0xffEAEBF4),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Pill.png',
                            scale: 3,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            'Dosage\nDetails',
                            style: TextStyle(
                                color: Color(0xff1A1A1A),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Prescription', actions: []),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30.0),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.25),
            //         spreadRadius: 1,
            //         blurRadius: 2,
            //         offset: Offset(0, 2),
            //
            //       ),
            //     ],
            //   ),
            //   child: Material(
            //     elevation: 0, // Set elevation to 0 when using BoxShadow
            //     borderRadius: BorderRadius.circular(30.0),
            //     child: TextField(
            //       onTap: () {
            //         setState(() {
            //           _validateName = '';
            //         });
            //       },
            //       controller: _nameController,
            //       keyboardType: TextInputType.text,
            //       decoration: InputDecoration(
            //         hintText: 'Name',
            //         hintStyle: TextStyle(
            //           fontFamily: "Poppins",
            //           fontWeight: FontWeight.w400,
            //           fontSize: 14,
            //         ),
            //         contentPadding:
            //             EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            //         border: InputBorder.none, // Removes the default border
            //       ),
            //     ),
            //   ),
            // ),
            // if (_validateName.isNotEmpty) ...[
            //   Container(
            //     alignment: Alignment.topLeft,
            //     margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
            //     width: MediaQuery.of(context).size.width,
            //     child: ShakeWidget(
            //       key: Key("value"),
            //       duration: Duration(milliseconds: 700),
            //       child: Text(
            //         _validateName,
            //         style: TextStyle(
            //           fontFamily: "Poppins",
            //           fontSize: 12,
            //           color: Colors.red,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ),
            // ] else ...[
            //   SizedBox(height: 15),
            // ],
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30.0),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.25), // Shadow color
            //         spreadRadius: 1, // Adjusts the size of the shadow
            //         blurRadius: 2, // How blurry the shadow is
            //         offset: Offset(0, 2), // Position of the shadow
            //       ),
            //     ],
            //   ),
            //   child: Material(
            //     elevation: 0, // Set elevation to 0 when using BoxShadow
            //     borderRadius: BorderRadius.circular(30.0),
            //     child: TextField(
            //       onTap: () {
            //         setState(() {
            //           _validateAbout = '';
            //         });
            //       },
            //       controller: _aboutPrescriptionController,
            //       keyboardType: TextInputType.text,
            //       decoration: InputDecoration(
            //         hintText: 'About Prescription',
            //         hintStyle: TextStyle(
            //           fontFamily: "Poppins",
            //           fontWeight: FontWeight.w400,
            //           fontSize: 14,
            //         ),
            //         contentPadding:
            //             EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            //         border: InputBorder.none, // Removes the default border
            //       ),
            //     ),
            //   ),
            // ),
            // if (_validateAbout.isNotEmpty) ...[
            //   Container(
            //     alignment: Alignment.topLeft,
            //     margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
            //     width: MediaQuery.of(context).size.width,
            //     child: ShakeWidget(
            //       key: Key("value"),
            //       duration: Duration(milliseconds: 700),
            //       child: Text(
            //         _validateAbout,
            //         style: TextStyle(
            //           fontFamily: "Poppins",
            //           fontSize: 12,
            //           color: Colors.red,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ),
            // ] else ...[
            //   SizedBox(height: 15),
            // ],
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30.0),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.25), // Shadow color
            //         spreadRadius: 1, // Adjusts the size of the shadow
            //         blurRadius: 2, // How blurry the shadow is
            //         offset: Offset(0, 2), // Position of the shadow
            //       ),
            //     ],
            //   ),
            //   child: Material(
            //     elevation: 0, // Set elevation to 0 when using BoxShadow
            //     borderRadius: BorderRadius.circular(30.0),
            //     child: TextField(
            //       onTap: () {
            //         setState(() {
            //           _validateRelation = '';
            //         });
            //       },
            //       controller: _relationController,
            //       keyboardType: TextInputType.text,
            //       decoration: InputDecoration(
            //         hintText: 'Relation',
            //         hintStyle: TextStyle(
            //           fontFamily: "Poppins",
            //           fontWeight: FontWeight.w400,
            //           fontSize: 14,
            //         ),
            //         contentPadding:
            //             EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            //         border: InputBorder.none, // Removes the default border
            //       ),
            //     ),
            //   ),
            // ),
            // if (_validateRelation.isNotEmpty) ...[
            //   Container(
            //     alignment: Alignment.topLeft,
            //     margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
            //     width: MediaQuery.of(context).size.width,
            //     child: ShakeWidget(
            //       key: Key("value"),
            //       duration: Duration(milliseconds: 700),
            //       child: Text(
            //         _validateRelation,
            //         style: TextStyle(
            //           fontFamily: "Poppins",
            //           fontSize: 12,
            //           color: Colors.red,
            //           fontWeight: FontWeight.w500,
            //         ),
            //       ),
            //     ),
            //   ),
            // ] else ...[
            //   SizedBox(height: 15),
            // ],
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomAppButton(text: 'Upload', onPlusTap: () {}),
      ),
    );
  }
}
