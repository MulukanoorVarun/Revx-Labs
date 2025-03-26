import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_behavior.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revxpharma/Components/CustomSnackBar.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_state.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';
import 'package:revxpharma/Patient/screens/DiagnosticInformation.dart';
import 'package:revxpharma/Patient/screens/Diagnosticcenter.dart';
import 'package:revxpharma/Utils/color.dart';
import 'package:speech_to_text/speech_to_text.dart%20' as stt;

import 'Appointment.dart';

class Searchscreen extends StatefulWidget {
  String lat_lang;
  Searchscreen({super.key, required this.lat_lang});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  bool _isLoding = false;

  TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
  }


  Timer? _debounce; // Declare debounce timer at class level
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffEFF4F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        leading: IconButton.filled(
          visualDensity: VisualDensity.compact,
          style: IconButton.styleFrom(
            backgroundColor: primaryColor, // Set background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
          ),
          icon: Icon(Icons.arrow_back, color: Colors.white), // Back icon color
          onPressed: () {
            Navigator.pop(context); // Navigate back when pressed
          },
        ),
        title: TextField(
          controller: _searchController,
          onChanged: (c) {
            if (_debounce?.isActive ?? false) _debounce!.cancel();
            _debounce = Timer(const Duration(milliseconds: 500), () {
              setState(() {
                if (c.length > 2) {
                  searchQuery = c.toLowerCase();
                  context
                      .read<TestCubit>()
                      .fetchTestList(widget.lat_lang, '', searchQuery,"");
                } else {
                  searchQuery = "";
                }
              });
            });
          },
          decoration: InputDecoration(
            focusColor: primaryColor,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xffDADADA),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xffDADADA),
                )),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            isCollapsed: true,
            hintText: 'Search Diagnostic tests...',
            hintStyle: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFamily: "Inter",
            ),
          ),
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 16,
            decorationColor: primaryColor,
            fontFamily: "Inter",
            overflow: TextOverflow.ellipsis,
          ),
          textAlignVertical: TextAlignVertical.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (_searchController.text == "") ...[
              Center(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5, // Limit height
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Use minimum size
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.6,
                        ),
                        Text(
                          'Oops !',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'No Data Found.',
                          style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Try Searching with a different name.',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ] else ...[
              BlocListener<CartCubit, CartState>(
                listener: (context, state) {
                  if (state is CartSuccessState) {
                    CustomSnackBar.show(context, "${state.message}");
                  } else if (state is CartErrorState) {
                    CustomSnackBar.show(context, "${state.errorMessage}");
                  }
                },
                child: Expanded(
                  child: BlocBuilder<TestCubit, TestState>(
                    builder: (context, state) {
                      if (state is TestStateLoading) {
                        return _shimmerList();
                      } else if (state is TestStateLoaded ||
                          state is TestStateLoadingMore) {
                        final testModel = (state is TestStateLoaded)
                            ? (state as TestStateLoaded).testModel
                            : (state as TestStateLoadingMore).testModel;
                        if ((testModel.data?.isEmpty ?? true)) {
                          return Center(
                            child: SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: MediaQuery.of(context).size.height * 0.5, // Limit height
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min, // Use minimum size
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Oops !',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      'No Data Found.',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Try Searching with a different name.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent * 0.9) {
                              if (state is TestStateLoaded &&
                                  state.hasNextPage) {
                                context.read<TestCubit>().fetchMoreTestList(widget.lat_lang, '', searchQuery,"");
                              }
                              return false;
                            }
                            return false;
                          },
                          child: CustomScrollView(
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                    final labTests = testModel.data?[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: TouchRipple(
                                        longTapBehavior: TouchRippleBehavior(
                                          lowerPercent: 0.00001,
                                        ),
                                        rippleBorderRadius:
                                        BorderRadius.circular(10),
                                        previewDuration:
                                        Duration(milliseconds: 1000),
                                        onTap: () {
                                          // Delay navigation to allow ripple effect to show
                                          Future.delayed(
                                              Duration(milliseconds: 200), () {
                                            context.push(
                                                '/test_details?location=${labTests?.diagnosticCentre} - ${labTests?.distance}&id=${labTests?.id ?? ""}');
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xff949494),
                                                width: 0.5),
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                spacing: 10,
                                                children: [
                                                  Container(
                                                    width: w * 0.25,
                                                    height: w * 0.31,
                                                    decoration: BoxDecoration(),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          8),
                                                      child: Image.network(
                                                        labTests?.testDetails
                                                            ?.image ??
                                                            '',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: w * 0.53,
                                                    child: Column(
                                                      spacing: 6,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          textAlign:
                                                          TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          labTests?.testDetails
                                                              ?.testName ??
                                                              '',
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            fontFamily:
                                                            "Poppins",
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          '₹ ${labTests?.testDetails?.price ?? 0}/-',
                                                          style:
                                                          const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            fontFamily:
                                                            "Poppins",
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          'No of tests : ${labTests?.testDetails?.noOfTests ?? 0}',
                                                          style:
                                                          const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontFamily:
                                                            "Poppins",
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        // BlocBuilder<CartCubit,
                                                        //     CartState>(
                                                        //   builder: (context,
                                                        //       cartState) {
                                                        //     int? patient = 0;
                                                        //     bool isLoading = cartState
                                                        //             is CartLoadingState &&
                                                        //         cartState
                                                        //                 .testId ==
                                                        //             labTests
                                                        //                 ?.id;
                                                        //     return ElevatedButton(
                                                        //       onPressed:
                                                        //           isLoading
                                                        //               ? null
                                                        //               : () {
                                                        //                     showModalBottomSheet(
                                                        //                       context: context,
                                                        //                       builder: (context) {
                                                        //                         final h = MediaQuery.of(context).size.height; // Corrected height calculation
                                                        //                         return StatefulBuilder(
                                                        //                           builder: (context, setState) {
                                                        //                             return Container(
                                                        //                               height: h * 0.5,
                                                        //                               padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                                                        //                               decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
                                                        //                               child: Column(
                                                        //                                 spacing: 10,
                                                        //                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                        //                                 children: [
                                                        //                                   Center(
                                                        //                                     child: Container(
                                                        //                                       width: 60,
                                                        //                                       height: 3,
                                                        //                                       decoration: BoxDecoration(color: CupertinoColors.inactiveGray, borderRadius: BorderRadius.circular(8)),
                                                        //                                     ),
                                                        //                                   ),
                                                        //                                   Text(
                                                        //                                     'Book For',
                                                        //                                     style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w500),
                                                        //                                   ),
                                                        //                                   Divider(height: 2, color: Color(0xffDADADA)),
                                                        //                                   Column(
                                                        //                                     children: [
                                                        //                                       if (patient != null && patient! > 0) ...[
                                                        //                                         Row(
                                                        //                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //                                           children: [
                                                        //                                             Text(
                                                        //                                               'Remove Selection',
                                                        //                                               style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500),
                                                        //                                             ),
                                                        //                                             IconButton.outlined(visualDensity: VisualDensity.compact,
                                                        //                                                 onPressed: (){
                                                        //                                                   context.read<CartCubit>().removeFromCart(labTests?.id ?? "", context);
                                                        //
                                                        //                                             }, icon: Icon(Icons.delete_outline,color: Colors.red,))
                                                        //                                           ],
                                                        //                                         )
                                                        //                                       ],
                                                        //                                       Row(
                                                        //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //                                         children: [
                                                        //                                           Text(
                                                        //                                             'Patient 1',
                                                        //                                             style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500),
                                                        //                                           ),
                                                        //                                           Row(spacing: 12,
                                                        //                                             children: [
                                                        //                                               Text(
                                                        //                                                 '₹ ${(1) * (labTests?.testDetails?.price ?? 0)}',
                                                        //                                                 style:
                                                        //                                                 const TextStyle(
                                                        //                                                   fontSize: 14,
                                                        //                                                   fontWeight:
                                                        //                                                   FontWeight.w600,
                                                        //                                                   fontFamily:
                                                        //                                                   "Poppins",
                                                        //                                                   color: Colors.black,
                                                        //                                                 ),
                                                        //                                               ),
                                                        //
                                                        //
                                                        //                                               Radio(
                                                        //                                                 activeColor: primaryColor,
                                                        //                                                 value: 1, // Unique value for Patient 1
                                                        //                                                 groupValue: patient,
                                                        //                                                 onChanged: (value) {
                                                        //                                                   setState(() {
                                                        //                                                     patient = value;
                                                        //                                                     context.read<CartCubit>().addToCart({
                                                        //                                                       "test": "${labTests?.id}",
                                                        //                                                       'no_of_persons': '${patient}'
                                                        //                                                     }, context);
                                                        //                                                     print('Selected patient number = $patient');
                                                        //                                                     context.pop();
                                                        //                                                   });
                                                        //                                                 },
                                                        //                                               ),
                                                        //                                             ],
                                                        //                                           ),
                                                        //                                         ],
                                                        //                                       ),
                                                        //                                       Divider(height: 2, color: Color(0xffDADADA)),
                                                        //
                                                        //                                       // Patient 2
                                                        //                                       Row(
                                                        //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //                                         children: [
                                                        //                                           Text(
                                                        //                                             'Patient 2',
                                                        //                                             style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500),
                                                        //                                           ),
                                                        //                                           Row(spacing: 12,
                                                        //                                             children: [
                                                        //                                               Text(
                                                        //                                                 '₹ ${(2) * (labTests?.testDetails?.price ?? 0)}',
                                                        //                                                 style:
                                                        //                                                 const TextStyle(
                                                        //                                                   fontSize: 14,
                                                        //                                                   fontWeight:
                                                        //                                                   FontWeight.w600,
                                                        //                                                   fontFamily:
                                                        //                                                   "Poppins",
                                                        //                                                   color: Colors.black,
                                                        //                                                 ),
                                                        //                                               ),
                                                        //                                               Radio(
                                                        //                                                 activeColor: primaryColor,
                                                        //                                                 value: 2, // Unique value for Patient 2
                                                        //                                                 groupValue: patient,
                                                        //                                                 onChanged: (value) {
                                                        //                                                   setState(() {
                                                        //                                                     patient = value;
                                                        //                                                     context.read<CartCubit>().addToCart({
                                                        //                                                       "test": "${labTests?.id}",
                                                        //                                                       'no_of_persons': '${patient}'
                                                        //                                                     }, context);
                                                        //                                                     print('Selected patient number = $patient');
                                                        //
                                                        //                                                     context.pop();
                                                        //                                                   });
                                                        //                                                 },
                                                        //                                               ),
                                                        //                                             ],
                                                        //                                           ),
                                                        //                                         ],
                                                        //                                       ),
                                                        //                                       Divider(height: 2, color: Color(0xffDADADA)),
                                                        //
                                                        //                                       // Patient 3
                                                        //                                       Row(
                                                        //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //                                         children: [
                                                        //                                           Text(
                                                        //                                             'Patient 3',
                                                        //                                             style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500),
                                                        //                                           ),
                                                        //                                           Row(spacing: 12,
                                                        //                                             children: [
                                                        //                                               Text(
                                                        //                                                 '₹ ${(3) * (labTests?.testDetails?.price ?? 0)}',
                                                        //                                                 style:
                                                        //                                                 const TextStyle(
                                                        //                                                   fontSize: 14,
                                                        //                                                   fontWeight:
                                                        //                                                   FontWeight.w600,
                                                        //                                                   fontFamily:
                                                        //                                                   "Poppins",
                                                        //                                                   color: Colors.black,
                                                        //                                                 ),
                                                        //                                               ),
                                                        //                                               Radio(
                                                        //                                                 activeColor: primaryColor,
                                                        //                                                 value: 3,
                                                        //                                                 groupValue: patient,
                                                        //                                                 onChanged: (value) {
                                                        //                                                   setState(() {
                                                        //                                                     patient = value;
                                                        //                                                     context.read<CartCubit>().addToCart({
                                                        //                                                       "test": "${labTests?.id}",
                                                        //                                                       'no_of_persons': '${patient}'
                                                        //                                                     }, context);
                                                        //                                                     print('Selected patient number = $patient');
                                                        //
                                                        //                                                     context.pop();
                                                        //                                                   });
                                                        //                                                 },
                                                        //                                               ),
                                                        //                                             ],
                                                        //                                           ),
                                                        //                                         ],
                                                        //                                       ),
                                                        //                                       Divider(height: 2, color: Color(0xffDADADA)),
                                                        //                                       Row(
                                                        //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //                                         children: [
                                                        //                                           Text(
                                                        //                                             'Patient 4',
                                                        //                                             style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500),
                                                        //                                           ),
                                                        //                                           Row(spacing: 12,
                                                        //                                             children: [
                                                        //                                               Text(
                                                        //                                                 '₹ ${(4) * (labTests?.testDetails?.price ?? 0)}',
                                                        //                                                 style:
                                                        //                                                 const TextStyle(
                                                        //                                                   fontSize: 14,
                                                        //                                                   fontWeight:
                                                        //                                                   FontWeight.w600,
                                                        //                                                   fontFamily:
                                                        //                                                   "Poppins",
                                                        //                                                   color: Colors.black,
                                                        //                                                 ),
                                                        //                                               ),
                                                        //                                               Radio(
                                                        //                                                 activeColor: primaryColor,
                                                        //                                                 value: 4,
                                                        //                                                 groupValue: patient,
                                                        //                                                 onChanged: (value) {
                                                        //                                                   setState(() {
                                                        //                                                     patient = value;
                                                        //                                                     context.read<CartCubit>().addToCart({
                                                        //                                                       "test": "${labTests?.id}",
                                                        //                                                       'no_of_persons': '${patient}'
                                                        //                                                     }, context);
                                                        //                                                     print('Selected patient number = $patient');
                                                        //
                                                        //                                                     context.pop();
                                                        //                                                   });
                                                        //                                                 },
                                                        //                                               ),
                                                        //                                             ],
                                                        //                                           ),
                                                        //                                         ],
                                                        //                                       ),
                                                        //                                       Divider(height: 2, color: Color(0xffDADADA)),
                                                        //
                                                        //                                       // Patient 5
                                                        //                                       Row(
                                                        //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        //                                         children: [
                                                        //                                           Text(
                                                        //                                             'Patient 5',
                                                        //                                             style: TextStyle(color: Colors.black, fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w500),
                                                        //                                           ),
                                                        //                                           Row(spacing: 12,
                                                        //                                             children: [
                                                        //                                               Text(
                                                        //                                                 '₹ ${(5) * (labTests?.testDetails?.price ?? 0)}',
                                                        //                                                 style:
                                                        //                                                 const TextStyle(
                                                        //                                                   fontSize: 14,
                                                        //                                                   fontWeight:
                                                        //                                                   FontWeight.w600,
                                                        //                                                   fontFamily:
                                                        //                                                   "Poppins",
                                                        //                                                   color: Colors.black,
                                                        //                                                 ),
                                                        //                                               ),
                                                        //
                                                        //                                               Radio(
                                                        //                                                 activeColor: primaryColor,
                                                        //                                                 value: 5,
                                                        //                                                 groupValue: patient,
                                                        //                                                 onChanged: (value) {
                                                        //                                                   setState(() {
                                                        //                                                     patient = value;
                                                        //                                                     context.read<CartCubit>().addToCart({
                                                        //                                                       "test": "${labTests?.id}",
                                                        //                                                       'no_of_persons': '${patient}'
                                                        //                                                     }, context);
                                                        //                                                     print('Selected patient number = $patient');
                                                        //
                                                        //                                                     context.pop();
                                                        //                                                   });
                                                        //                                                 },
                                                        //                                               ),
                                                        //                                             ],
                                                        //                                           ),
                                                        //                                         ],
                                                        //                                       ),
                                                        //                                     ],
                                                        //                                   )
                                                        //                                 ],
                                                        //                               ),
                                                        //                             );
                                                        //                           },
                                                        //                         );
                                                        //                       },
                                                        //                     );
                                                        //                 },
                                                        //       style: ElevatedButton
                                                        //           .styleFrom(
                                                        //               visualDensity:
                                                        //                   VisualDensity
                                                        //                       .compact,
                                                        //               backgroundColor: labTests
                                                        //                           ?.existInCart ??
                                                        //                       false
                                                        //                   ? primaryColor
                                                        //                   : primaryColor,
                                                        //               shape:
                                                        //                   RoundedRectangleBorder(
                                                        //                 borderRadius:
                                                        //                     BorderRadius.circular(30),
                                                        //               ),
                                                        //               elevation:
                                                        //                   0),
                                                        //       child: Row(
                                                        //         crossAxisAlignment:
                                                        //             CrossAxisAlignment
                                                        //                 .center,
                                                        //         mainAxisAlignment:
                                                        //             MainAxisAlignment
                                                        //                 .center,
                                                        //         children: [
                                                        //           isLoading
                                                        //               ? CircularProgressIndicator(
                                                        //                   color:
                                                        //                       Colors.white,
                                                        //                   strokeWidth:
                                                        //                       2,
                                                        //                 )
                                                        //               : labTests?.existInCart ??
                                                        //                       false
                                                        //                   ? Text(
                                                        //                       '${patient} Patient',
                                                        //                       style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                                                        //                     )
                                                        //                   : Text(
                                                        //                       'Add Test',
                                                        //                       style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                                                        //                     ),
                                                        //           SizedBox(
                                                        //             width: 10,
                                                        //           ),
                                                        //           labTests?.existInCart ??
                                                        //                   false
                                                        //               ? Icon(
                                                        //                   Icons
                                                        //                       .arrow_drop_down_sharp,
                                                        //                   color:
                                                        //                       Colors.white,
                                                        //                 )
                                                        //               : Icon(
                                                        //                   Icons
                                                        //                       .add_circle_outline,
                                                        //                   color:
                                                        //                       Colors.white,
                                                        //                 )
                                                        //         ],
                                                        //       ),
                                                        //     );
                                                        //   },
                                                        // ),
                                                        BlocBuilder<CartCubit, CartState>(
                                                          builder: (context, cartState) {
                                                            return ElevatedButton(
                                                              onPressed: cartState is CartLoadingState && cartState.testId == labTests?.id
                                                                  ? null
                                                                  : () {
                                                                showModalBottomSheet(
                                                                  context: context,
                                                                  builder: (context) {
                                                                    return StatefulBuilder(
                                                                      builder: (BuildContext context, StateSetter setModalState) {
                                                                        int modalPatientCount = labTests?.noOfPersons??0; // Use the button's current count
                                                                        return Container(
                                                                          height: MediaQuery.of(context).size.height * 0.5,
                                                                          padding: const EdgeInsets.all(16),
                                                                          decoration: const BoxDecoration(
                                                                            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                                                                          ),
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Center(
                                                                                child: Container(
                                                                                  width: 60,
                                                                                  height: 3,
                                                                                  decoration: BoxDecoration(
                                                                                    color: CupertinoColors.inactiveGray,
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 10),
                                                                              const Text(
                                                                                'Book For',
                                                                                style: TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontFamily: 'Poppins',
                                                                                  fontSize: 18,
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                              ),
                                                                              const Divider(height: 2, color: Color(0xffDADADA)),
                                                                              Expanded(
                                                                                child: ListView(
                                                                                  children: [
                                                                                    if (labTests?.existInCart ?? false) ...[
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          const Text(
                                                                                            'Remove Selection',
                                                                                            style: TextStyle(
                                                                                              color: Colors.black,
                                                                                              fontFamily: 'Poppins',
                                                                                              fontSize: 14,
                                                                                              fontWeight: FontWeight.w500,
                                                                                            ),
                                                                                          ),
                                                                                          IconButton.outlined(
                                                                                            visualDensity: VisualDensity.compact,
                                                                                            onPressed: () {
                                                                                              context.read<CartCubit>().removeFromCart(labTests?.id ?? "");
                                                                                              setModalState(() {
                                                                                                modalPatientCount = 1; // Reset to 1 on removal
                                                                                              });
                                                                                              context.pop();
                                                                                            },
                                                                                            icon: const Icon(
                                                                                              Icons.delete_outline,
                                                                                              color: Colors.red,
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      const Divider(height: 2, color: Color(0xffDADADA)),
                                                                                    ],
                                                                                    ...List.generate(5, (index) {
                                                                                      final patientCount = index + 1;
                                                                                      return Column(
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Text(
                                                                                                'Patient $patientCount',
                                                                                                style: const TextStyle(
                                                                                                  color: Colors.black,
                                                                                                  fontFamily: 'Poppins',
                                                                                                  fontSize: 14,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                              ),
                                                                                              Row(
                                                                                                spacing: 12,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    '₹ ${(patientCount) * (labTests?.testDetails?.price ?? 0)}',
                                                                                                    style: const TextStyle(
                                                                                                      fontSize: 14,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontFamily: "Poppins",
                                                                                                      color: Colors.black,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Radio<int>(
                                                                                                    activeColor: primaryColor,
                                                                                                    value: patientCount,
                                                                                                    groupValue: modalPatientCount, // Use modal-specific count
                                                                                                    onChanged: (value) {
                                                                                                      setModalState(() {
                                                                                                        modalPatientCount = patientCount; // Update modal state
                                                                                                      });
                                                                                                      if(labTests?.existInCart??false){
                                                                                                        context.read<CartCubit>().updateCart(
                                                                                                            labTests?.id??"",
                                                                                                            patientCount
                                                                                                        );
                                                                                                      }else{
                                                                                                        context.read<CartCubit>().addToCart({
                                                                                                          "test": "${labTests?.id}",
                                                                                                          'no_of_persons': patientCount
                                                                                                        });
                                                                                                      }
                                                                                                      Navigator.pop(context);
                                                                                                    },
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          const Divider(height: 2, color: Color(0xffDADADA)),
                                                                                        ],
                                                                                      );
                                                                                    }),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              style: ElevatedButton.styleFrom(
                                                                visualDensity: VisualDensity.compact,
                                                                backgroundColor: primaryColor,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(30),
                                                                ),
                                                                elevation: 0,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  if (cartState is CartLoadingState && cartState.testId == labTests?.id)
                                                                    const CircularProgressIndicator(
                                                                      color: Colors.white,
                                                                      strokeWidth: 2,
                                                                    )
                                                                  else
                                                                    Text(
                                                                      labTests?.existInCart ?? false
                                                                          ? '${labTests?.noOfPersons} Patient${labTests?.noOfPersons != 1 ? 's' : ''}'
                                                                          : 'Add Test',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontFamily: "Poppins",
                                                                      ),
                                                                    ),
                                                                  const SizedBox(width: 10),
                                                                  Icon(
                                                                    labTests?.existInCart ?? false
                                                                        ? Icons.arrow_drop_down_sharp
                                                                        : Icons.add_circle_outline,
                                                                    color: Colors.white,
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),

                                              // SizedBox(height: 5),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment
                                              //           .spaceBetween,
                                              //   children: [
                                              //     ElevatedButton(
                                              //       onPressed: () {
                                              //         // Navigator.push(
                                              //         //     context,
                                              //         //     MaterialPageRoute(
                                              //         //         builder: (context) =>
                                              //         //             TestDetails()));
                                              //
                                              //         // showSubTestsDialog(context,
                                              //         //     labTests.subTests ?? []);
                                              //       },
                                              //       style: ElevatedButton
                                              //           .styleFrom(
                                              //         backgroundColor:
                                              //             Colors.white,
                                              //         side: BorderSide(
                                              //             color: primaryColor),
                                              //         shape:
                                              //             RoundedRectangleBorder(
                                              //           borderRadius:
                                              //               BorderRadius
                                              //                   .circular(30),
                                              //         ),
                                              //         elevation: 0,
                                              //         visualDensity:
                                              //             VisualDensity.compact,
                                              //       ),
                                              //       child: Text(
                                              //         'View Detail',
                                              //         style: TextStyle(
                                              //             color: primaryColor,
                                              //             fontFamily:
                                              //                 "Poppins"),
                                              //       ),
                                              //     ),
                                              //     BlocBuilder<CartCubit,
                                              //         CartState>(
                                              //       builder:
                                              //           (context, cartState) {
                                              //         bool isLoading = cartState
                                              //                 is CartLoadingState &&
                                              //             cartState.testId ==
                                              //                 labTests.id;
                                              //         return ElevatedButton(
                                              //           onPressed: isLoading
                                              //               ? null
                                              //               : () {
                                              //                   if (labTests
                                              //                           .existInCart ??
                                              //                       false) {
                                              //                     context
                                              //                         .read<
                                              //                             CartCubit>()
                                              //                         .removeFromCart(
                                              //                             labTests.id ??
                                              //                                 "",
                                              //                             context);
                                              //                   } else {
                                              //                     context
                                              //                         .read<
                                              //                             CartCubit>()
                                              //                         .addToCart({
                                              //                       "test":
                                              //                           "${labTests.id}"
                                              //                     }, context);
                                              //                   }
                                              //                 },
                                              //           style: ElevatedButton
                                              //               .styleFrom(
                                              //                   visualDensity:
                                              //                       VisualDensity
                                              //                           .compact,
                                              //                   backgroundColor:
                                              //                       labTests.existInCart ??
                                              //                               false
                                              //                           ? primaryColor
                                              //                           : primaryColor,
                                              //                   shape:
                                              //                       RoundedRectangleBorder(
                                              //                     borderRadius:
                                              //                         BorderRadius
                                              //                             .circular(
                                              //                                 30),
                                              //                   ),
                                              //                   elevation: 0),
                                              //           child: isLoading
                                              //               ? const SizedBox(
                                              //                   width: 20,
                                              //                   height: 20,
                                              //                   child:
                                              //                       CircularProgressIndicator(
                                              //                     color: Colors
                                              //                         .white,
                                              //                     strokeWidth:
                                              //                         2,
                                              //                   ),
                                              //                 )
                                              //               : Row(
                                              //                   children: [
                                              //                     Text(
                                              //                       labTests.existInCart ??
                                              //                               false
                                              //                           ? 'Remove'
                                              //                           : 'Add Test',
                                              //                       style: TextStyle(
                                              //                           color: Colors
                                              //                               .white,
                                              //                           fontFamily:
                                              //                               "Poppins"),
                                              //                     ),
                                              //                     SizedBox(
                                              //                       width: 10,
                                              //                     ),
                                              //                     labTests.existInCart ??
                                              //                             false
                                              //                         ? Icon(
                                              //                             Icons
                                              //                                 .cancel_outlined,
                                              //                             color:
                                              //                                 Colors.white,
                                              //                           )
                                              //                         : Icon(
                                              //                             Icons
                                              //                                 .add_circle_outline,
                                              //                             color:
                                              //                                 Colors.white,
                                              //                           )
                                              //                   ],
                                              //                 ),
                                              //         );
                                              //       },
                                              //     ),
                                              //   ],
                                              // ),
                                              if (labTests?.distance !=
                                                  null) ...[
                                                Container(
                                                  margin: const EdgeInsets.only(top: 10),
                                                  padding:
                                                  const EdgeInsets.all(3),
                                                  decoration:
                                                  const BoxDecoration(
                                                      color: Color(
                                                          0xffD40000)),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.location_on,
                                                          color: Colors.white,
                                                          size: 15),
                                                      const SizedBox(width: 8),
                                                      Expanded(
                                                        child: Text(
                                                          '${labTests?.diagnosticCentre} - ${labTests?.distance} away',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .white,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: testModel.data?.length ?? 0,
                                ),
                              ),
                              if (state is TestStateLoadingMore)
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 0.8),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      } else if (state is TestStateError) {
                        return const Center(child: Text("Error loading data"));
                      }
                      return const Center(child: Text("No Data Available"));
                    },
                  ),
                ),
              ),
            ]
            // )
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          int cartCount = 0;
          bool isLoading = false;

          if (cartState is CartLoaded) {
            cartCount = cartState.cartCount;
          } else if (cartState is CartSuccessState) {
            cartCount = cartState.cartCount;
          } else if (cartState is CartLoadingState) {
            isLoading = true;
          }

          // Hide the bottom bar when cartCount is 0
          if (cartCount == 0 && !isLoading) {
            return const SizedBox.shrink(); // Hides the widget completely
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, -2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Cart count with loader side by side
                    Row(
                      children: [
                        const Text(
                          "No of Tests: ",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        if (isLoading)
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        else
                          Text(
                            "$cartCount",
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                      ],
                    ),

                    // Continue button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Apointments()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:  primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                        elevation: 6,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _shimmerList() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Expanded(
        child: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          width: w,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xff949494), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerText(120, 10, context),
              SizedBox(height: 8),
              shimmerText(120, 10, context),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  shimmerContainer(140, 40, context),
                  shimmerContainer(140, 40, context),
                ],
              ),
              SizedBox(height: 26),
              shimmerContainer(w, 25, context),
            ],
          ),
        );
      },
    ));
  }

  void showSubTestsDialog(BuildContext context, List<String> subTests) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 350,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Subtests",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: subTests.isNotEmpty
                              ? ListView.builder(
                                  itemCount: subTests.length,
                                  itemBuilder: (context, index) {
                                    String subTest = subTests[index];
                                    return ListTile(
                                      visualDensity: VisualDensity.compact,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      minTileHeight: 30,
                                      title: Text(
                                        "${subTest}",
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    "No subtests available",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -60,
                    left: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
