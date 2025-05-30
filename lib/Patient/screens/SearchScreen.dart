import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                child: Column(
                  spacing: 8,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.6,
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
                      'No Data Found.',
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
              )
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
                        if ((testModel.data?.isEmpty ?? true) ||
                            searchQuery == "") {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 8,
                              children: [
                                Text(
                                  'Oops !',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'No Data Found.',
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
                                    widget.lat_lang ?? '', '', searchQuery,"");
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
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff949494),
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(10),
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
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  showSubTestsDialog(context,
                                                      labTests.subTests ?? []);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  side:  BorderSide(
                                                      color: primaryColor),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  elevation: 0,
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                ),
                                                child: Text(
                                                  'View Detail',
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontFamily: "Poppins"),
                                                ),
                                              ),
                                              BlocBuilder<CartCubit, CartState>(
                                                builder: (context, cartState) {
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
                                                            backgroundColor: labTests
                                                                        .exist_in_cart ??
                                                                    false
                                                                ? Color(
                                                                    0xff137B7C)
                                                                : const Color(
                                                                    0xff24AEB1),
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
                                                              color:
                                                                  Colors.white,
                                                              strokeWidth: 2,
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
                                                                      color: Colors
                                                                          .white,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .add_circle_outline,
                                                                      color: Colors
                                                                          .white,
                                                                    )
                                                            ],
                                                          ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            padding: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                                color: Color(0xffD40000)),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.location_on,
                                                    color: Colors.white,
                                                    size: 15),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    '${labTests.diagnosticCentre} - ${labTests.distance} away',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                      return SizedBox();
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
