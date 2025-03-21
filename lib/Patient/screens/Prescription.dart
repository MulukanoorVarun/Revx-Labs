import 'package:flutter/material.dart';
import 'package:revxpharma/Components/CustomAppButton.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/ShakeWidget.dart';

class Prescription extends StatefulWidget {
  const Prescription({super.key});

  @override
  State<Prescription> createState() => _PrescriptionState();
}

class _PrescriptionState extends State<Prescription> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _aboutPrescriptionController = TextEditingController();
  TextEditingController _relationController = TextEditingController();
  String _validateName = '';
  String _validateAbout = '';
  String _validateRelation = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Prescription', actions: []),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 2),

                  ),
                ],
              ),
              child: Material(
                elevation: 0, // Set elevation to 0 when using BoxShadow
                borderRadius: BorderRadius.circular(30.0),
                child: TextField(
                  onTap: () {
                    setState(() {
                      _validateName = '';
                    });
                  },
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    border: InputBorder.none, // Removes the default border
                  ),
                ),
              ),
            ),
            if (_validateName.isNotEmpty) ...[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                width: MediaQuery.of(context).size.width,
                child: ShakeWidget(
                  key: Key("value"),
                  duration: Duration(milliseconds: 700),
                  child: Text(
                    _validateName,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ] else ...[
              SizedBox(height: 15),
            ],
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25), // Shadow color
                    spreadRadius: 1, // Adjusts the size of the shadow
                    blurRadius: 2, // How blurry the shadow is
                    offset: Offset(0, 2), // Position of the shadow
                  ),
                ],
              ),
              child: Material(
                elevation: 0, // Set elevation to 0 when using BoxShadow
                borderRadius: BorderRadius.circular(30.0),
                child: TextField(
                  onTap: () {
                    setState(() {
                      _validateAbout = '';
                    });
                  },
                  controller: _aboutPrescriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'About Prescription',
                    hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    border: InputBorder.none, // Removes the default border
                  ),
                ),
              ),
            ),
            if (_validateAbout.isNotEmpty) ...[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                width: MediaQuery.of(context).size.width,
                child: ShakeWidget(
                  key: Key("value"),
                  duration: Duration(milliseconds: 700),
                  child: Text(
                    _validateAbout,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ] else ...[
              SizedBox(height: 15),
            ],
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25), // Shadow color
                    spreadRadius: 1, // Adjusts the size of the shadow
                    blurRadius: 2, // How blurry the shadow is
                    offset: Offset(0, 2), // Position of the shadow
                  ),
                ],
              ),
              child: Material(
                elevation: 0, // Set elevation to 0 when using BoxShadow
                borderRadius: BorderRadius.circular(30.0),
                child: TextField(
                  onTap: () {
                    setState(() {
                      _validateRelation = '';
                    });
                  },
                  controller: _relationController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Relation',
                    hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    border: InputBorder.none, // Removes the default border
                  ),
                ),
              ),
            ),
            if (_validateRelation.isNotEmpty) ...[
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                width: MediaQuery.of(context).size.width,
                child: ShakeWidget(
                  key: Key("value"),
                  duration: Duration(milliseconds: 700),
                  child: Text(
                    _validateRelation,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ] else ...[
              SizedBox(height: 15),
            ],
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
