import 'package:flutter/cupertino.dart';
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
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 2,
                  color: Color(0xffFAF9F6),
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12), // Inner padding for content
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Container
                        Container(
                          width: w * 0.25,
                          height: w * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              state.testDetailsModel.data?.testDetails?.image ?? "",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.broken_image,
                                size: 50,
                                color: Colors.grey,
                              ), // Fallback for broken images
                            ),
                          ),
                        ),
                        const SizedBox(width: 12), // Spacing between image and text
                        // Details Column
                        SizedBox(
                          width: w * 0.56,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.testDetailsModel.data?.testDetails?.testName ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height:5),
                              Text(
                                '₹ ${state.testDetailsModel.data?.testDetails?.price ?? 0}/-',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'No of tests: ${state.testDetailsModel.data?.testDetails?.noOfTests ?? 0}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color: Colors.black54,
                                ),
                              ),
                              const SizedBox(height: 5),
                              BlocBuilder<CartCubit, CartState>(
                                builder: (context, cartState) {
                                  return ElevatedButton(
                                    onPressed: cartState is CartLoadingState && cartState.testId == state.testDetailsModel.data?.id
                                        ? null
                                        : () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (BuildContext context, StateSetter setModalState) {
                                              int modalPatientCount = state.testDetailsModel.data?.noOfPersons??0; // Use the button's current count
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
                                                          if (state.testDetailsModel.data?.existInCart ?? false) ...[
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
                                                                    context.read<CartCubit>().removeFromCart(state.testDetailsModel.data?.id ?? "");
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
                                                                          '₹ ${(patientCount) * (state.testDetailsModel.data?.testDetails?.price ?? 0)}',
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
                                                                            if(state.testDetailsModel.data?.existInCart??false){
                                                                              context.read<CartCubit>().updateCart(
                                                                                  state.testDetailsModel.data?.id??"",
                                                                                  patientCount
                                                                              );
                                                                            }else{
                                                                              context.read<CartCubit>().addToCart({
                                                                                "test": "${state.testDetailsModel.data?.id}",
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
                                        if (cartState is CartLoadingState && cartState.testId == state.testDetailsModel.data?.id)
                                          const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          )
                                        else
                                          Text(
                                            state.testDetailsModel.data?.existInCart ?? false
                                                ? '${state.testDetailsModel.data?.noOfPersons} Patient${state.testDetailsModel.data?.noOfPersons != 1 ? 's' : ''}'
                                                : 'Add Test',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins",
                                            ),
                                          ),
                                        const SizedBox(width: 10),
                                        Icon(
                                          state.testDetailsModel.data?.existInCart ?? false
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
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
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
                  child:TabBarView(
                    controller: _tabController,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Html(
                                data: state.testDetailsModel.data?.testDetails?.description ?? '',
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(12),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Html(
                                data: state.testDetailsModel.data?.testDetails?.overview ?? '',
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(12),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Html(
                                data: state.testDetailsModel.data?.testDetails?.ranges ?? '',
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(12),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Html(
                                data: state.testDetailsModel.data?.testDetails?.testResultInterpretation ?? '',
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(12),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            children: [
                              Html(
                                data: state.testDetailsModel.data?.testDetails?.riskAssessment ?? '',
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(12),
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                  ),
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
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
