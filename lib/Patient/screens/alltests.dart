import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_behavior.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/bloc/internet_status/internet_status_bloc.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_state.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_state.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';
import 'package:revxpharma/Patient/screens/TestDetails.dart';
import 'package:revxpharma/Utils/NoInternet.dart';
import 'package:revxpharma/Utils/color.dart';

import '../../Components/CustomSnackBar.dart';
import 'Appointment.dart';

class alltests extends StatefulWidget {
  String lat_lang;
  String catId;
  String catName;
  String diagnosticID;
  alltests(
      {super.key,
      required this.lat_lang,
      required this.catId,
      required this.diagnosticID,
      required this.catName});

  @override
  State<alltests> createState() => _alltestsState();
}

class _alltestsState extends State<alltests> {
  @override
  void initState() {
    context.read<TestCubit>().fetchTestList(
        widget.lat_lang ?? '', widget.catId ?? '', '', widget.diagnosticID);
    context.read<CartCubit>().getCartList();
    super.initState();
  }

  bool isLabTestSelected = true;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(
          title: "${widget.catName.isNotEmpty ? widget.catName : 'All Tests'}",
          actions: []),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocListener<InternetStatusBloc, InternetStatusState>(
              listener: (context, state) {
                if (state is InternetStatusLostState) {
                  Future.microtask(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => NoInternetWidget()),
                    );
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
                                    widget.catId ?? '',
                                    '',
                                    widget.diagnosticID);
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
                                              const Duration(milliseconds: 200),
                                              () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TestDetails(
                                                          location:
                                                              '${labTests.diagnosticCentre} - ${labTests.distance}',
                                                          id: labTests.id ?? "",
                                                        )));
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
                                              Text(
                                                labTests?.testName ?? '',
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "Poppins",
                                                  color: Colors.black,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                '₹ ${labTests!.price}/-',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins",
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             TestDetails()));

                                                      // showSubTestsDialog(context,
                                                      //     labTests.subTests ?? []);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.white,
                                                      side: BorderSide(
                                                          color: primaryColor),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      elevation: 0,
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                    ),
                                                    child: Text(
                                                      'View Detail',
                                                      style: TextStyle(
                                                          color: primaryColor,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                  ),
                                                  BlocBuilder<CartCubit,
                                                      CartState>(
                                                    builder:
                                                        (context, cartState) {
                                                      bool isLoading = cartState
                                                              is CartLoadingState &&
                                                          cartState.testId ==
                                                              labTests.id;
                                                      return ElevatedButton(
                                                        onPressed: isLoading
                                                            ? null
                                                            : () {
                                                                if (labTests
                                                                        .exist_in_cart ??
                                                                    false) {
                                                                  context
                                                                      .read<
                                                                          CartCubit>()
                                                                      .removeFromCart(
                                                                          labTests.id ??
                                                                              "",
                                                                          context);
                                                                } else {
                                                                  context
                                                                      .read<
                                                                          CartCubit>()
                                                                      .addToCart({
                                                                    "test":
                                                                        "${labTests.id}"
                                                                  }, context);
                                                                }
                                                              },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                visualDensity:
                                                                    VisualDensity
                                                                        .compact,
                                                                backgroundColor:
                                                                    labTests.exist_in_cart ??
                                                                            false
                                                                        ? primaryColor
                                                                        : primaryColor,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                                elevation: 0),
                                                        child: isLoading
                                                            ? const SizedBox(
                                                                width: 20,
                                                                height: 20,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  color: Colors
                                                                      .white,
                                                                  strokeWidth:
                                                                      2,
                                                                ),
                                                              )
                                                            : Row(
                                                                children: [
                                                                  Text(
                                                                    labTests.exist_in_cart ??
                                                                            false
                                                                        ? 'Remove'
                                                                        : 'Add Test',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            "Poppins"),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  labTests.exist_in_cart ??
                                                                          false
                                                                      ? Icon(
                                                                          Icons
                                                                              .cancel_outlined,
                                                                          color:
                                                                              Colors.white,
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .add_circle_outline,
                                                                          color:
                                                                              Colors.white,
                                                                        )
                                                                ],
                                                              ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              if (labTests.distance !=
                                                  null) ...[
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 10),
                                                  padding:
                                                      const EdgeInsets.all(6),
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
                                                          '${labTests.diagnosticCentre} - ${labTests.distance} away',
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
