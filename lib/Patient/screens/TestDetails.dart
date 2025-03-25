import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Patient/logic/cubit/test_details/test_details_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/test_details/test_details_state.dart';
import 'package:revxpharma/Utils/color.dart';
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
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
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
                  padding: EdgeInsets.only(left: 16, bottom: 10),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.red, size: 18),
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: 16, right: 16, bottom: 16, top: 8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      width: w * 0.25,
                      height: w * 0.3,
                      decoration: BoxDecoration(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          '${state.testDetailsModel.data?.testDetails?.image ?? ""}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: w * 0.56,
                      child: Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            state.testDetailsModel.data?.testDetails
                                    ?.testName ??
                                "",
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '₹ ${state.testDetailsModel.data?.testDetails?.price ?? 0}/-',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'No of tests : ${state.testDetailsModel.data?.testDetails?.noOfTests ?? 0}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                          ),
                          BlocBuilder<CartCubit, CartState>(
                            builder: (context, cartState) {
                              bool isLoading = cartState is CartLoadingState &&
                                  cartState.testId ==
                                      state.testDetailsModel.data?.id;
                              return ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () {
                                        if (state.testDetailsModel.data
                                                ?.existInCart ??
                                            false) {
                                          context
                                              .read<CartCubit>()
                                              .removeFromCart(
                                                  state.testDetailsModel.data
                                                          ?.testDetails?.id ??
                                                      "",
                                                  context);
                                        } else {
                                          context.read<CartCubit>().addToCart({
                                            "test":
                                                "${state.testDetailsModel.data?.testDetails?.id}"
                                          }, context);
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                    visualDensity: VisualDensity.compact,
                                    backgroundColor: state.testDetailsModel.data
                                                ?.existInCart ??
                                            false
                                        ? primaryColor
                                        : primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isLoading
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          )
                                        : Text(
                                            state.testDetailsModel.data
                                                        ?.existInCart ??
                                                    false
                                                ? 'Remove'
                                                : 'Add Test',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins"),
                                          ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    state.testDetailsModel.data?.existInCart ??
                                            false
                                        ? Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            Icons.add_circle_outline,
                                            color: Colors.white,
                                          )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.5),
                        blurRadius: 1,
                        offset: Offset(0, 0.1),
                      ),
                    ],
                    border: Border(
                      bottom: BorderSide(
                        color: primaryColor.withOpacity(0.1),
                        width: 0.5,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    indicatorColor: primaryColor,
                    indicatorWeight: 4,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabAlignment: TabAlignment.start,
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width(2),
                    ),
                    labelStyle: TextStyle(
                      fontFamily: 'pjs',
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.fontSize(12),
                      color: primaryColor,
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
                          child: Text('Overview'),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Ranges'),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Test Result Iinterpretation'),
                        ),
                      ),
                      Tab(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Risk Assessment'),
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
                                data: state.testDetailsModel.data?.testDetails?.description??'',
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(12),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                })
                          ],
                        ),
                      )),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Html(
                                    data: state.testDetailsModel.data?.testDetails?.overview??'',
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize(12),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    })
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Html(
                                    data: state.testDetailsModel.data?.testDetails?.ranges??'',
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize(12),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    })
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Html(
                                    data: state.testDetailsModel.data?.testDetails?.testResultInterpretation??'',
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize(12),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    })
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Html(
                                    data: state.testDetailsModel.data?.testDetails?.riskAssessment??'',
                                    style: {
                                      "body": Style(
                                        fontSize: FontSize(12),
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w400,
                                      ),
                                    })
                              ],
                            ),
                          )),
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
}
