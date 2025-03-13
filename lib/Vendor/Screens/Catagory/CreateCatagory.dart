import 'package:flutter/material.dart';
import 'package:revxpharma/Utils/color.dart';

import '../../../Components/CustomAppButton.dart';
import '../../../Components/CutomAppBar.dart';
import '../../../Components/ShakeWidget.dart';
import '../ApprovalPending.dart';

class CreateNewCategory extends StatefulWidget {
  const CreateNewCategory({super.key});

  @override
  State<CreateNewCategory> createState() => _CreateNewCategoryState();
}

class _CreateNewCategoryState extends State<CreateNewCategory>  {
  TextEditingController _NameCategoryController = TextEditingController();
  TextEditingController _purposAnddescriptionController =
  TextEditingController();
  TextEditingController _textParameterController = TextEditingController();
  TextEditingController _proceduredescriptionController =
  TextEditingController();
  TextEditingController _priceController = TextEditingController();

  String _validateNamecategory = '';
  String _validatepurposeDescription = '';
  String _validatetestParametrers = '';
  String _validateprocedureDescription = '';
  String _validateprice = '';

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create New Category',
        actions: [Container()],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.050,
                child: TextFormField(
                  controller: _NameCategoryController,
                  keyboardType: TextInputType.text,
                  cursorColor: Color(0xff8856F4),
                  onTap: () {
                    setState(() {
                      // _validateTitle="";
                    });
                  },
                  onChanged: (v) {
                    setState(() {
                      // _validateTitle="";
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    hintText: "Name of the Category",
                    hintStyle: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                      letterSpacing: 0,
                      height: 19.36 / 14,
                      color: Color(0xffAFAFAF),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: const Color(0xffFCFAFF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                      const BorderSide(width: 1, color: Color(0xffd0cbdb)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                      const BorderSide(width: 1, color: Color(0xffd0cbdb)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                      const BorderSide(width: 1, color: Color(0xffd0cbdb)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                      const BorderSide(width: 1, color: Color(0xffd0cbdb)),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'RozhaOne',
                    overflow:
                    TextOverflow.ellipsis, // Add ellipsis for long text
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              if (_validateNamecategory.isNotEmpty) ...[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ShakeWidget(
                    key: Key("value"),
                    duration: Duration(milliseconds: 700),
                    child: Text(
                      _validateNamecategory,
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
                SizedBox(height: 3),
              ],
              SizedBox(
                height: 14,
              ),
              Container(
                height: h * 0.15,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xffE8ECFF))),
                child: TextFormField(
                  cursorColor: Color(0xff8856F4),
                  scrollPadding: const EdgeInsets.only(top: 5),
                  controller: _purposAnddescriptionController,
                  textInputAction: TextInputAction.done,
                  maxLines: 100,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    hintText: "Purpose and Description:",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0,
                      height: 1.2,
                      color: Color(0xffAFAFAF),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Color(0xffFCFAFF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                      BorderSide(width: 1, color: Color(0xffD0CBDB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide:
                      BorderSide(width: 1, color: Color(0xffD0CBDB)),
                    ),
                  ),
                ),
              ),
              if (_validatepurposeDescription.isNotEmpty) ...[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ShakeWidget(
                    key: Key("value"),
                    duration: Duration(milliseconds: 700),
                    child: Text(
                      _validatepurposeDescription,
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
                SizedBox(height: 3),
              ],
              SizedBox(
                height: 16,
              ),
              Container(
                height: h * 0.12,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xffE8ECFF))),
                child: TextFormField(
                  cursorColor: Color(0xff8856F4),
                  scrollPadding: const EdgeInsets.only(top: 5),
                  controller: _textParameterController,
                  textInputAction: TextInputAction.done,
                  maxLines: 100,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    hintText: "Test Parameters",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0,
                      height: 1.2,
                      color: Color(0xffAFAFAF),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Color(0xffFCFAFF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                      BorderSide(width: 1, color: Color(0xffD0CBDB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide:
                      BorderSide(width: 1, color: Color(0xffD0CBDB)),
                    ),
                  ),
                ),
              ),
              if (_validatetestParametrers.isNotEmpty) ...[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ShakeWidget(
                    key: Key("value"),
                    duration: Duration(milliseconds: 700),
                    child: Text(
                      _validatetestParametrers,
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
                SizedBox(height: 3),
              ],
              SizedBox(
                height: 16,
              ),
              Container(
                height: h * 0.15,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xffE8ECFF))),
                child: TextFormField(
                  cursorColor: Color(0xff8856F4),
                  scrollPadding: const EdgeInsets.only(top: 5),
                  controller: _proceduredescriptionController,
                  textInputAction: TextInputAction.done,
                  maxLines: 100,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    hintText: "Procedure Description:",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0,
                      height: 1.2,
                      color: Color(0xffAFAFAF),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Color(0xffFCFAFF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                      BorderSide(width: 1, color: Color(0xffD0CBDB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide:
                      BorderSide(width: 1, color: Color(0xffD0CBDB)),
                    ),
                  ),
                ),
              ),
              if (_validateprocedureDescription.isNotEmpty) ...[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ShakeWidget(
                    key: Key("value"),
                    duration: Duration(milliseconds: 700),
                    child: Text(
                      _validateprocedureDescription,
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
                SizedBox(height: 3),
              ],
              SizedBox(
                height: 16,
              ),
              Container(
                height: h * 0.12,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xffE8ECFF))),
                child: TextFormField(
                  cursorColor: Color(0xff8856F4),
                  scrollPadding: const EdgeInsets.only(top: 5),
                  controller: _priceController,
                  textInputAction: TextInputAction.done,
                  maxLines: 100,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    hintText: "Common Conditions",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      letterSpacing: 0,
                      height: 1.2,
                      color: Color(0xffAFAFAF),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Color(0xffFCFAFF),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide:
                      BorderSide(width: 1, color: Color(0xffD0CBDB)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      borderSide:
                      BorderSide(width: 1, color: Color(0xffD0CBDB)),
                    ),
                  ),
                ),
              ),
              if (_validateprice.isNotEmpty) ...[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ShakeWidget(
                    key: Key("value"),
                    duration: Duration(milliseconds: 700),
                    child: Text(
                      _validateprice,
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
                SizedBox(height: 3),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
        child: CustomAppButton(
            color: primaryColor,
            text: 'Submit for approval',
            onPlusTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ApprovalPending()));
            }),
      ),
    );
  }
}
