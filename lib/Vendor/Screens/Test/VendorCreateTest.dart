import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revxpharma/Components/CustomAppButton.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Vendor/Screens/ApprovalPending.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_categories/diognostic_get_categories_cubit.dart';

import '../../../Components/ShakeWidget.dart';

class CreateNewTest extends StatefulWidget {
  const CreateNewTest({super.key});

  @override
  State<CreateNewTest> createState() => _CreateNewTestState();
}

class _CreateNewTestState extends State<CreateNewTest> {
  TextEditingController _textNameController = TextEditingController();
  TextEditingController _purposAnddescriptionController =
      TextEditingController();
  TextEditingController _textParameterController = TextEditingController();
  TextEditingController _proceduredescriptionController =
      TextEditingController();
  TextEditingController _priceController = TextEditingController();

  String _validatetextName = '';
  String _validatecategory = '';
  String _validatepurposeDescription = '';
  String _validatetestParametrers = '';
  String _validateprocedureDescription = '';
  String _validateprice = '';
@override
  void initState() {
  context.read<DiognosticCategoryCubit>().getDiognosticCategorys();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create New Tests',
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
                  controller: _textNameController,
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
                    hintText: "Name of the test",
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
              if (_validatetextName.isNotEmpty) ...[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ShakeWidget(
                    key: Key("value"),
                    duration: Duration(milliseconds: 700),
                    child: Text(
                      _validatetextName,
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
              // DropdownButtonHideUnderline(
              //   child: DropdownButton2<String>(
              //     isExpanded: true,
              //     hint: const Row(
              //       children: [
              //         Text(
              //           'Select Category',
              //           style: TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.w400,
              //             fontFamily: "Inter",
              //             color: Color(0xffAFAFAF),
              //           ),
              //         ),
              //       ],
              //     ),
              //     items: servicelist
              //         .map((service) =>
              //         DropdownMenuItem(
              //           value: service,
              //           child: Text(
              //             service.projectName ??
              //                 '',
              //             style: const TextStyle(
              //               fontSize: 14,
              //             ),
              //             overflow: TextOverflow
              //                 .ellipsis,
              //           ),
              //         ))
              //         .toList(),
              //     value: serviceid != null &&
              //         serviceid != 0
              //         ? servicelist.firstWhere(
              //           (member) =>
              //       member.pid == serviceid,
              //       orElse: () =>
              //       servicelist[0],
              //     )
              //         : null,
              //     onChanged: (value) {
              //       setState(() {
              //         serviceid = value!.pid!;
              //         servicename =
              //         value!.projectName!;
              //         _validateservice = "";
              //       });
              //     },
              //     buttonStyleData: ButtonStyleData(
              //       height: 35,
              //       width: w * 0.4,
              //       padding: const EdgeInsets.only(
              //           left: 14, right: 14),
              //       decoration: BoxDecoration(
              //         borderRadius:
              //         BorderRadius.circular(7),
              //         border: Border.all(
              //           color: Color(0xffD0CBDB),
              //         ),
              //         color: Color(0xffFCFAFF),
              //       ),
              //     ),
              //     iconStyleData: const IconStyleData(
              //       icon: Icon(
              //         Icons.arrow_drop_down,
              //         size: 25,
              //       ),
              //       iconSize: 14,
              //       iconEnabledColor: Colors.black,
              //       iconDisabledColor: Colors.black,
              //     ),
              //     dropdownStyleData:
              //     DropdownStyleData(
              //       maxHeight: 200,
              //       decoration: BoxDecoration(
              //         borderRadius:
              //         BorderRadius.circular(14),
              //         color: Colors.white,
              //       ),
              //       scrollbarTheme:
              //       ScrollbarThemeData(
              //         radius:
              //         const Radius.circular(40),
              //         thickness:
              //         MaterialStateProperty.all(
              //             6),
              //         thumbVisibility:
              //         MaterialStateProperty.all(
              //             true),
              //       ),
              //     ),
              //     menuItemStyleData:
              //     const MenuItemStyleData(
              //       height: 40,
              //       padding: EdgeInsets.only(
              //           left: 14, right: 14),
              //     ),
              //   ),
              // ),
              if (_validatecategory.isNotEmpty) ...[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom: 5),
                  child: ShakeWidget(
                    key: Key("value"),
                    duration: Duration(milliseconds: 700),
                    child: Text(
                      _validatecategory,
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
                const SizedBox(
                  height: 15,
                ),
              ],
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
                height: MediaQuery.of(context).size.height * 0.050,
                child: TextFormField(
                  controller: _priceController,
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
                    hintText: "Price of the test ",
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
            color: Color(0xff27BDBE),
            text: 'Submit for approval',
            onPlusTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ApprovalPending()));
            }),
      ),
    );
  }
}
