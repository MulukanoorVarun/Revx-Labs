import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Patient/logic/cubit/test_details/test_details_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/test_details/test_details_state.dart';
import 'package:revxpharma/Utils/media_query_helper.dart';

import '../logic/cubit/cart/cart_cubit.dart';
import '../logic/cubit/cart/cart_state.dart';
import 'Appointment.dart';

class TestDetails extends StatefulWidget {
  String location;
  String id;
  TestDetails({super.key, required this.location, required this.id});

  @override
  State<TestDetails> createState() => _TestDetailsState();
}

class _TestDetailsState extends State<TestDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    context.read<TestDetailsCubit>().getTestDetails(widget.id);
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Test Details',
        actions: [],
      ),
      body: BlocBuilder<TestDetailsCubit, TestDetailsState>(
        builder: (context, state) {
          if (state is TestDetailsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TestDetailsLoaded) {
            return Column(
              children: [
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: 16,bottom: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red, size: 18),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${widget.location} away',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff949494), width: 0.5),
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.testDetailsModel.data?.testName ?? '',
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: SizeConfig.fontSize(12),
                            fontFamily: 'pjs',
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'No.of Tests: ${state.testDetailsModel.data?.noOfTests.toString() ?? ''}',
                        style: TextStyle(
                            color: Color(0xff000000).withOpacity(0.5),
                            fontSize: SizeConfig.fontSize(10),
                            fontFamily: 'pjs',
                            fontWeight: FontWeight.w400),
                      ),
                      BlocBuilder<CartCubit, CartState>(
                        builder: (context, cartState) {
                          bool isLoading = cartState is CartLoadingState &&
                              cartState.testId == state.testDetailsModel.data?.id;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end, // Align button to right
                            children: [
                              ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                  if (state.testDetailsModel.data?.existInCart ?? false) {
                                    context
                                        .read<CartCubit>()
                                        .removeFromCart(state.testDetailsModel.data?.id ?? "", context);
                                  } else {
                                    context
                                        .read<CartCubit>()
                                        .addToCart({"test": "${state.testDetailsModel.data?.id}"}, context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  visualDensity: VisualDensity.compact,
                                  backgroundColor: state.testDetailsModel.data?.existInCart ?? false
                                      ? Color(0xff137B7C)
                                      : const Color(0xff24AEB1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                                child: isLoading
                                    ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                    : Row(
                                  children: [
                                    Text(
                                      state.testDetailsModel.data?.existInCart ?? false
                                          ? 'Remove'
                                          : 'Add Test',
                                      style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                                    ),
                                    SizedBox(width: 10),
                                    state.testDetailsModel.data?.existInCart ?? false
                                        ? Icon(Icons.cancel_outlined, color: Colors.white)
                                        : Icon(Icons.add_circle_outline, color: Colors.white),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color(0xff27BDBE).withOpacity(0.5), // Shadow color
                        blurRadius: 1, // Shadow blur radius
                        offset: Offset(0, 0.1),
                      ),
                    ],
                    border: Border(
                      bottom: BorderSide(
                        color: Color(0xff27BDBE).withOpacity(0.1),
                        width: 0.5,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: Color(0xff27BDBE),
                    indicatorWeight: 4,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width(4),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: 'pjs',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.fontSize(12),
                      color: Color(0xff27BDBE),
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontFamily: 'pjs',
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey,
                      fontSize: SizeConfig.fontSize(11),
                    ),
                    tabs: [
                      Tab(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Description'),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Parameters'),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Open Jobs'),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Review'),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Html(
                                data: state.testDetailsModel.data
                                        ?.procedureDescription ??
                                    '',
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(12),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                })
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            );
          } else if (state is TestDetailsError) {
            return Center(
              child: Text(state.error),
            );
          }
          return Center(child: Text("No Data"));
        },
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Apointments()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff27BDBE),
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
}
