import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_behavior.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/bloc/internet_status/internet_status_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_state.dart';
import 'package:revxpharma/Patient/logic/cubit/prescritpionUpload/PrescriptionUploadCubit.dart';
import 'package:revxpharma/Patient/logic/cubit/prescritpionUpload/PrescriptionUploadStates.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';
import 'package:revxpharma/Utils/color.dart';
import '../../Components/CustomSnackBar.dart';
import '../../Utils/ImageUtils.dart';
import '../../Utils/constants.dart';

class alltests extends StatefulWidget {
  String lat_lang;
  String catId;
  String conditionId;
  String catName;
  String diagnosticID;
  String scanId;
  String XrayId;

  alltests({
    super.key,
    required this.lat_lang,
    required this.catId,
    required this.conditionId,
    required this.diagnosticID,
    required this.catName,
    required this.scanId,
    required this.XrayId,
  });

  @override
  State<alltests> createState() => _alltestsState();
}

class _alltestsState extends State<alltests> {
  @override
  void initState() {
    context.read<TestCubit>().fetchTestList(
        widget.lat_lang ?? '', widget.catId ?? '', widget.conditionId ?? '', '', widget.diagnosticID,widget.scanId,widget.XrayId);
    print("ScanID::${widget.scanId}");
    print("XrayID::${widget.XrayId}");
    context.read<CartCubit>().getCartList();
    super.initState();
  }
  String _getAppBarTitle() {
    if (widget.catName.isNotEmpty) {
      return widget.catName;
    } else if (widget.XrayId.isNotEmpty) {
      return "X-Ray’s";
    } else if (widget.scanId.isNotEmpty) {
      return "Scans";
    } else {
      return "All Tests";
    }
  }

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      // Compress the image
      File? compressedFile = await ImageUtils.compressImage(
        File(pickedFile.path),
      );
      if (compressedFile != null) {
        setState(() {
          _image = compressedFile;
        });
      }
    }
  }

  Future<void> _pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      // Compress the image
      File? compressedFile = await ImageUtils.compressImage(
        File(pickedFile.path),
      );
      if (compressedFile != null) {
        setState(() {
          _image = compressedFile;
        });
      }
    }
  }

  bool isLabTestSelected = true;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
          title: _getAppBarTitle(),
          // "${widget.catName.isNotEmpty ? widget.catName : 'All Tests'}",
          actions: []),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocListener<InternetStatusBloc, InternetStatusState>(
              listener: (context, state) {
                if (state is InternetStatusLostState) {
                  Future.microtask(() {
                    context.push('/no_internet');
                  });
                }
              },
              child: BlocListener<CartCubit, CartState>(
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 8,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Text(
                                  'Oops !',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'No Data Found!',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Try Searching with a diffrent name. ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        }
                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent * 0.9) {
                              if (state is TestStateLoaded &&
                                  state.hasNextPage) {
                                context.read<TestCubit>().fetchMoreTestList(
                                    widget.lat_lang ?? '',
                                    widget.catId ?? '',  widget.conditionId ?? '',
                                    "",

                                    widget.diagnosticID,widget.scanId,widget.XrayId);
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
                                          padding: const EdgeInsets.all(10),
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
                                                    height: w * 0.28,
                                                    decoration: BoxDecoration(),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child:CachedNetworkImage(
                                                        imageUrl: labTests?.testDetails?.image??"",
                                                        fit: BoxFit.cover,
                                                        placeholder: (context, url) =>
                                                            Center(
                                                              child: spinkits
                                                                  .getSpinningLinespinkit(),
                                                            ),
                                                        errorWidget:
                                                            (context, url, error) =>
                                                            Container(
                                                              color: Colors.grey[200],
                                                              child: Image.asset('assets/testimg.jpg')
                                                            ),
                                                      )
                                                    ),
                                                  ),
                                                  Container(
                                                    width: w * 0.53,
                                                    child: Column(
                                                      spacing: 2,
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
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                        BlocBuilder<CartCubit,
                                                            CartState>(
                                                          builder: (context,
                                                              cartState) {
                                                            return ElevatedButton(
                                                              onPressed: cartState
                                                                          is CartLoadingState &&
                                                                      cartState
                                                                              .testId ==
                                                                          labTests
                                                                              ?.id
                                                                  ? null
                                                                  : () {
                                                                      showModalBottomSheet(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (context) {
                                                                          return StatefulBuilder(
                                                                            builder:
                                                                                (BuildContext context, StateSetter setModalState) {
                                                                              int modalPatientCount = labTests?.noOfPersons ?? 0; // Use the button's current count
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
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                    ),
                                                                                    if (labTests?.existInCart ?? false) ...[
                                                                                      const Divider(height: 10, color: Color(0xffDADADA)),
                                                                                    ],
                                                                                    Expanded(
                                                                                      child: ListView.separated(
                                                                                        itemCount: (labTests?.existInCart ?? false) ? 6 : 5, // 5 patients + 1 for remove section if in cart
                                                                                        separatorBuilder: (context, index) => const Divider(
                                                                                          height: 15,
                                                                                          color: Color(0xffDADADA),
                                                                                        ),
                                                                                        itemBuilder: (context, index) {
                                                                                          if ((labTests?.existInCart ?? false) && index == 0) {
                                                                                            return Row(
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
                                                                                                IconButton.filled(
                                                                                                  style: IconButton.styleFrom(
                                                                                                    backgroundColor: Colors.red.shade100,
                                                                                                    shape: const CircleBorder(),
                                                                                                  ),
                                                                                                  visualDensity: VisualDensity.compact,
                                                                                                  onPressed: () {
                                                                                                    context.read<CartCubit>().removeFromCart(labTests?.id ?? "");
                                                                                                    context.pop();
                                                                                                  },
                                                                                                  icon: const Icon(
                                                                                                    Icons.delete_outline,
                                                                                                    color: Colors.red,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            );
                                                                                          }

                                                                                          final patientIndex = (labTests?.existInCart ?? false) ? index - 1 : index;
                                                                                          final patientCount = patientIndex + 1;

                                                                                          return Row(
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
                                                                                                    '₹${(patientCount) * (labTests?.testDetails?.price ?? 0)}',
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
                                                                                                    groupValue: modalPatientCount,
                                                                                                    onChanged: (value) {
                                                                                                      setModalState(() {
                                                                                                        modalPatientCount = patientCount;
                                                                                                      });
                                                                                                      if (labTests?.existInCart ?? false) {
                                                                                                        context.read<CartCubit>().updateCart(
                                                                                                              labTests?.id ?? "",
                                                                                                              patientCount,
                                                                                                            );
                                                                                                      } else {
                                                                                                        context.read<CartCubit>().addToCart({
                                                                                                          "test": "${labTests?.id}",
                                                                                                          'no_of_persons': patientCount,
                                                                                                        });
                                                                                                      }
                                                                                                      Navigator.pop(context);
                                                                                                    },
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        },
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
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                visualDensity:
                                                                    VisualDensity
                                                                        .compact,
                                                                backgroundColor:
                                                                    primaryColor,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                                elevation: 0,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  if (cartState
                                                                          is CartLoadingState &&
                                                                      cartState
                                                                              .testId ==
                                                                          labTests
                                                                              ?.id)
                                                                    const CircularProgressIndicator(
                                                                      color: Colors
                                                                          .white,
                                                                      strokeWidth:
                                                                          2,
                                                                    )
                                                                  else
                                                                    Text(
                                                                      labTests?.existInCart ??
                                                                              false
                                                                          ? '${labTests?.noOfPersons} Patient${labTests?.noOfPersons != 1 ? 's' : ''}'
                                                                          : 'Add Test',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            "Poppins",
                                                                      ),
                                                                    ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Icon(
                                                                    labTests?.existInCart ??
                                                                            false
                                                                        ? Icons
                                                                            .arrow_drop_down_sharp
                                                                        : Icons
                                                                            .add_circle_outline,
                                                                    color: Colors
                                                                        .white,
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
                                              // const Divider(
                                              //   height: 12,
                                              //   color: Color(0xffE6E6E6),
                                              //   thickness: 1,
                                              // ),
                                              // Row(
                                              //   children: [
                                              //     if (labTests?.testDetails
                                              //             ?.fastingRequired ==
                                              //         true) ...[
                                              //       Image.asset(
                                              //           'assets/ForkKnife.png',
                                              //           scale: 2.5),
                                              //       const SizedBox(width: 8),
                                              //       const Text(
                                              //         'Fast Required',
                                              //         style: TextStyle(
                                              //           color:
                                              //               Color(0xff555555),
                                              //           fontFamily: 'Poppins',
                                              //           fontSize: 12,
                                              //           fontWeight:
                                              //               FontWeight.w400,
                                              //         ),
                                              //       ),
                                              //     ],
                                              //     Spacer(),
                                              //     Image.asset('assets/file.png',
                                              //         scale: 2.5),
                                              //     SizedBox(width: 8),
                                              //     Text(
                                              //       'Reports in ${labTests?.testDetails?.reportsDeliveredIn ?? 0} min',
                                              //       style: const TextStyle(
                                              //         color: Color(0xff555555),
                                              //         fontFamily: 'Poppins',
                                              //         fontSize: 12,
                                              //         fontWeight:
                                              //             FontWeight.w400,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),

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
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
                                                  padding:
                                                      const EdgeInsets.all(2),
                                                  decoration:
                                                       BoxDecoration(
                                                          color: Color(0xffD40000).withOpacity(0.6)),
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
                                                          style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10),
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
                              // Show "Upload Prescription" card only when pagination ends
                              if (state is TestStateLoaded && !state.hasNextPage)
                                SliverToBoxAdapter(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.symmetric(vertical: 16),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: const Color(0xff949494), width: 0.5),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.upload_file,
                                          size: 50,
                                          color: primaryColor,
                                        ),
                                        const SizedBox(height: 20),
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            _showBottomSheet(context);
                                          },
                                          icon: const Icon(Icons.cloud_upload, color: Colors.white),
                                          label: const Text(
                                            "Upload Prescription",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins",
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              // Loading indicator for when more tests are being loaded
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
            )
            // ] else ...[
            //   BlocBuilder<ConditionCubit, ConditionBasedState>(
            //     builder: (context, Conditionstate) {
            //       if (Conditionstate is ConditionBasedLoading) {
            //         return _shimmerList1();
            //       } else if (Conditionstate is ConditionBasedLoaded) {
            //         return Expanded(
            //             child: ListView.builder(
            //           itemCount:
            //               Conditionstate.conditionBasedModel.data?.length,
            //           itemBuilder: (context, index) {
            //             final items =
            //                 Conditionstate.conditionBasedModel.data?[index];
            //             return GestureDetector(
            //               onTap: () {
            //                 // Handle card click, navigate or perform an action
            //               },
            //               child: Container(
            //                 margin: EdgeInsets.only(bottom: 10),
            //                 decoration: BoxDecoration(
            //                   border:
            //                       Border.all(color: Colors.grey, width: 1),
            //                   borderRadius: BorderRadius.circular(6),
            //                 ),
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(16.0),
            //                   child: Row(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       // Product name and price
            //                       Column(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           Text(
            //                             items?.name ?? '',
            //                             style: const TextStyle(
            //                               fontSize: 14,
            //                               fontWeight: FontWeight.w400,
            //                               fontFamily: "Poppins",
            //                               color: Colors.black,
            //                             ),
            //                           ),
            //                           const SizedBox(height: 6),
            //                           // Space between product name and price
            //                           Text(
            //                             ('${items?.testsAvailable.toString() ?? ''} Tests Available'),
            //                             style: const TextStyle(
            //                               fontSize: 14,
            //                               fontWeight: FontWeight.w500,
            //                               fontFamily: "Poppins",
            //                               color: Color(0xff808080),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                       // Dummy image instead of noOfTests
            //                       Icon(
            //                         Icons.arrow_forward_ios_outlined,
            //                         size: 16,
            //                         weight: 1,
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             );
            //           },
            //         ));
            //       } else if (Conditionstate is ConditionBasedError) {
            //         return Center(
            //             child: Text("Error loading ConditionBaseddata"));
            //       }
            //       return Center(child: Text("No Data Available"));
            //     },
            //   ),
            // ]
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
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.pushReplacement('/appointments');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
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
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showImageViewer(BuildContext context) {
    if (_image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text('Payment Proof'),
            ),
            body: Center(
              child: PhotoView(
                imageProvider: FileImage(_image!),
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes: const PhotoViewHeroAttributes(
                  tag: 'payment-image',
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void _showBottomSheet(BuildContext context) {
    bool showImageOptions = false; // Track if buttons should be shown
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter bottomSheetSetState) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  // _buildTextField(
                  //   icon: Icons.payment,
                  //   controller: _transectionController,
                  //   validation: _validateTransection,
                  //   hintText: 'Enter Transaction ID',
                  //   keyboardType: TextInputType.text,
                  // ),
                  const SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_image == null) {
                            bottomSheetSetState(() {
                              showImageOptions =
                              !showImageOptions; // Toggle visibility
                            });
                          } else {
                            _showImageViewer(
                              context,
                            ); // Show full image if already selected
                          }
                        },
                        child: DottedBorder(
                          color: Colors.grey,
                          strokeWidth: 1,
                          dashPattern: const [6, 3],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _image == null
                                    ? Icon(
                                  Icons.upload_file,
                                  color: Colors.grey[600],
                                  size: 30,
                                )
                                    : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    _image!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _image == null
                                      ? 'Choose File'
                                      : 'Prescription',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                    fontFamily: 'lexend',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (_image != null)
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              bottomSheetSetState(() {
                                setState(() {
                                  _image = null;
                                });
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (showImageOptions && _image == null) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              await _pickImageFromCamera();
                              bottomSheetSetState(() {
                                showImageOptions =
                                false; // Hide after selection
                              });
                            },
                            icon: Icon(Icons.camera_alt, color: primaryColor),
                            label: Text(
                              'Camera',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: primaryColor,
                                fontFamily: "lexend",
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(color: primaryColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              await _pickImageFromGallery();
                              bottomSheetSetState(() {
                                showImageOptions =
                                false; // Hide after selection
                              });
                            },
                            icon: Icon(Icons.photo_library, color: primaryColor),
                            label: Text(
                              'Gallery',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: primaryColor,
                                fontFamily: "lexend",
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(color: primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 24),
                  BlocConsumer<UploadPrescriptionCubit, UploadPrescriptionState>(
                    listener: (context, state) {
                      if (state is UploadPrescriptionStateSuccessState) {
                        context.pushReplacement('/booking_successfully');
                        CustomSnackBar.show(
                          context,
                          state.successModel.settings?.message ?? 'Booking successful',
                        );
                      } else if (state is UploadPrescriptionStateError) {
                        CustomSnackBar.show(context, state.message);
                      }
                    },
                    builder: (context, state) {
                      bool isLoading = state is UploadPrescriptionStateLoading;
                      bool isFormValid = _image != null;
                      return SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: isFormValid && !isLoading
                              ? () {
                            Map<String,dynamic> data={
                              "prescription_image": _image!.path
                            };
                            context.read<UploadPrescriptionCubit>().uploadPrescription(data);
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white, // Text/icon color when enabled
                            disabledBackgroundColor: primaryColor.withOpacity(0.5), // When disabled
                            disabledForegroundColor: Colors.white.withOpacity(0.5), // When disabled
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: isLoading
                              ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            'Submit',
                            style: TextStyle(
                              fontFamily: "lexend",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _shimmerList() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return ListView.builder(
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
    );
  }

  Widget _shimmerList1() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Expanded(
        child: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  shimmerText(120, 12, context),
                  SizedBox(height: 10),
                  shimmerText(120, 12, context),
                ],
              ),
              shimmerContainer(10, 10, context),
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
                        context.pop();
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
