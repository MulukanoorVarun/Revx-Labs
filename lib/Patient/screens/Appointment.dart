import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/screens/ScheduleAppointment.dart';
import 'package:revxpharma/Utils/color.dart';

import '../logic/cubit/cart/cart_cubit.dart';
import '../logic/cubit/cart/cart_state.dart';
import 'Appointment1.dart';

class Apointments extends StatefulWidget {
  const Apointments({super.key});

  @override
  State<Apointments> createState() => _ApointmentsState();
}

class _ApointmentsState extends State<Apointments> {
  @override
  void initState() {
    context.read<CartCubit>().getCartList();
    super.initState();
  }

  final List<Map<String, dynamic>> tests = [
    {"name": "Complete Blood Picture (CBP)", "price": 400},
    {"name": "Liver Function Test (LFT)", "price": 600},
    {"name": "Lipid Profile", "price": 800},
  ];

  String vendorID="";
  String startTime="";
  String endTime="";
  double? totalamount;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(title: "Appointment   ", actions: []),
      body: BlocBuilder<CartCubit, CartState>(builder: (context, cartState) {
        if (cartState is CartLoadingState) {
          return _shimmerList();
        } else if (cartState is CartLoaded) {
          vendorID= cartState.cartList?.data?.diagnosticCentre?.id??"";
          startTime= cartState.cartList?.data?.diagnosticCentre?.starttime??"";
          endTime= cartState.cartList?.data?.diagnosticCentre?.endtime??"";
          totalamount= cartState.cartList?.data?.totalAmount??0.0 ;
          if(totalamount!=0.0 && totalamount!=null){
            return SingleChildScrollView(
              child: Padding(
                padding:
                EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image.network(
                        //   "${cartState.cartList?.data?.diagnosticCentre?.image}",
                        //   height: 24,
                        //   width: 24,
                        // ),
                        // SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            "${cartState.cartList?.data?.diagnosticCentre?.name}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins"),
                          ),
                        )
                      ],
                    ),
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
                                "${cartState.cartList?.data?.diagnosticCentre?.location}",
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
                    SizedBox(height: 10),
                    // Text(
                    //   "Selected Patient",
                    //   style: TextStyle(
                    //     color: Color(0xff000000),
                    //     fontWeight: FontWeight.w400,
                    //     fontFamily: "Poppins",
                    //     fontSize: 16,
                    //   ),
                    // ),
                    // SizedBox(height: 10),
                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   width: w,
                    //   decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black.withOpacity(0.25),
                    //         spreadRadius: 1,
                    //         blurRadius: 2,
                    //         offset: Offset(0, 1),
                    //       ),
                    //     ],
                    //     color: Colors.white,
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Radio(
                    //         activeColor: primaryColor,
                    //         value: 1,
                    //         groupValue: 1, // Update this as needed
                    //         onChanged: (value) {
                    //           // Handle radio button change
                    //         },
                    //       ),
                    //       SizedBox(width: 10),
                    //       Expanded(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               "Sandeep Reddy",
                    //               style: TextStyle(
                    //                 color: Color(0xff000000),
                    //                 fontWeight: FontWeight.w400,
                    //                 fontFamily: "Poppins",
                    //                 fontSize: 16,
                    //               ),
                    //             ),
                    //             SizedBox(height: 6),
                    //             Text(
                    //               "48 Years / Male / B+ve",
                    //               style: TextStyle(
                    //                 color: Color(0xff000000),
                    //                 fontWeight: FontWeight.w400,
                    //                 fontFamily: "Poppins",
                    //                 fontSize: 12,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Text(
                    //         "Change",
                    //         style: TextStyle(
                    //           color: Color(0xff000000),
                    //           fontWeight: FontWeight.w600,
                    //           fontFamily: "Poppins",
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 10,),
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
                            itemCount: cartState.cartList?.data?.cartTests?.length??0,
                            separatorBuilder: (context, index) => const Divider(
                              color: Colors.grey,
                              thickness: 0.5,
                              height: 16,
                            ),
                            itemBuilder: (context, index) {
                              final test = cartState.cartList?.data?.cartTests?[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text("${test?.testName??""}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            visualDensity: VisualDensity.compact,
                                            onPressed: () {
                                              context.read<CartCubit>().removeFromCart(test?.testId ?? "",context);
                                            },
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Color(0xff000000),
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "₹${test?.testPrice??""}",
                                      style: const TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 10),
                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   width: w,
                    //   decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black.withOpacity(0.25),
                    //         spreadRadius: 1,
                    //         blurRadius: 2,
                    //         offset: Offset(0, 1),
                    //       ),
                    //     ],
                    //     color: Colors.white,
                    //   ),
                    //   child: Center(
                    //     child: Text(
                    //       "Add More Tests",
                    //       style: TextStyle(
                    //         color: Color(0xff000000),
                    //         fontWeight: FontWeight.w400,
                    //         fontFamily: "Poppins",
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                    // Container(
                    //   padding: EdgeInsets.all(10),
                    //   width: w,
                    //   decoration: BoxDecoration(
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.black.withOpacity(0.25),
                    //         spreadRadius: 1,
                    //         blurRadius: 2,
                    //         offset: Offset(0, 1),
                    //       ),
                    //     ],
                    //     color: Colors.white,
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         "Select Time slot",
                    //         style: TextStyle(
                    //           color: Color(0xff000000),
                    //           fontWeight: FontWeight.w400,
                    //           fontFamily: "Poppins",
                    //           fontSize: 16,
                    //         ),
                    //       ),
                    //       SizedBox(height: 14),
                    //       Row(
                    //         children: [
                    //           Text(
                    //             "Start Time",
                    //             style: TextStyle(
                    //               color: Color(0xff000000),
                    //               fontWeight: FontWeight.w400,
                    //               fontFamily: "Poppins",
                    //               fontSize: 12,
                    //             ),
                    //           ),
                    //           SizedBox(width: 5),
                    //           Icon(Icons.keyboard_arrow_down),
                    //           Spacer(),
                    //           Text(
                    //             "End Time",
                    //             style: TextStyle(
                    //               color: Color(0xff000000),
                    //               fontWeight: FontWeight.w400,
                    //               fontFamily: "Poppins",
                    //               fontSize: 12,
                    //             ),
                    //           ),
                    //           SizedBox(width: 5),
                    //           Icon(Icons.keyboard_arrow_down),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    Text(
                      "Bill Summary",
                      style: TextStyle(
                        color: Color(0xff1A1A1A),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 10,),
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
                                "No. of Tests",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${cartState.cartList?.data?.cartTests?.length}",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Total MRP",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "₹${cartState.cartList?.data?.totalAmount}",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
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
                              Text(
                                "Amount to be paid",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "₹${cartState.cartList?.data?.totalAmount}",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else{
            return Center(child: Text("No Data Available"));
          }
        }
        return Center(child: Text("No Data Available"));
      }),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          if (cartState is CartLoaded) {
            if (cartState.cartList?.data?.totalAmount != null && cartState.cartList!.data!.totalAmount != 0.0) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScheduleAnAppointment(
                          vendorID: vendorID,
                          starttime: startTime,
                          endtime: endTime,
                          totalamount: cartState.cartList!.data!.totalAmount.toString(), // ✅ Fix: Use from state
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:  primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Save & Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            }
          }
          // ✅ Fix: Ensure a return widget in all cases
          return SizedBox.shrink();
        },
      ),
    );
  }
  Widget _shimmerList(){
    return  Padding(
      padding:
      EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 10),
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
          SizedBox(height: 10,),
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width *
                        0.8, // 90% of screen width
                    child: shimmerText(120, 12, context)
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 23),

          Container(
            padding:  EdgeInsets.all(10),
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
                  physics:  NeverScrollableScrollPhysics(),
                  itemCount:6,
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
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
