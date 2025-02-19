import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/conditionbased/condition_state.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';

class alltests extends StatefulWidget {
  String lat_lang;
  String catId;
  alltests({super.key,required this.lat_lang, required this.catId});

  @override
  State<alltests> createState() => _alltestsState();
}

class _alltestsState extends State<alltests> {
  @override
  void initState() {
    context.read<TestCubit>().fetchTestList(widget.lat_lang ?? '', widget.catId ?? '');
    super.initState();
  }

  bool isLabTestSelected = true;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0xff24AEB1)),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "All Tests",
                style: TextStyle(
                  color: Color(0xff24AEB1),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image(
                image: AssetImage("assets/filter.png"),
                width: 16,
                height: 18,
              ),
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xff24AEB1)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white, // Background color of the search box
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Color(0xffDADADA)) // Rounded corners
                    ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search for lab tests (CBP, X-Ray..)",
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        color: Color(0xffb6b6b6)),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    prefixIcon: Icon(Icons.search, color: Color(0xff949494)),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Space between the search field and product grid
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xff27BDBE), width: 1),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLabTestSelected = true;
                        });
                      },
                      child: Container(
                        width: w * 0.45,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isLabTestSelected
                              ? const Color(0xff27BDBE)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            "Labs Tests",
                            style: TextStyle(
                              color: isLabTestSelected
                                  ? Colors.white
                                  : const Color(0xff27BDBE),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLabTestSelected = false;
                        });
                        context.read<ConditionCubit>().fetchConditionBased();
                      },
                      child: Container(
                        width: w * 0.465,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: !isLabTestSelected
                              ? const Color(0xff27BDBE)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            "Condition based",
                            style: TextStyle(
                              color: !isLabTestSelected
                                  ? Colors.white
                                  : const Color(0xff27BDBE),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (isLabTestSelected) ...[
                BlocBuilder<TestCubit, TestState>(builder: (context, state) {
                  if (state is TestStateLoading) {
                    return _shimmerList();
                  } else if (state is TestStateLoaded) {
                    return Expanded(
                        child: ListView.builder(
                          itemCount: state.testModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final lab_tests = state.testModel.data?[index];
                            print('lab_tests: $lab_tests');
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff949494), width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lab_tests?.testName ?? '',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '₹ ${lab_tests!.price.toString()}/-',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins",
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(horizontal: 30),
                                          backgroundColor: Colors.white,
                                          side: BorderSide(color: Color(0xff27BDBE)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(30)),
                                          ),
                                            visualDensity: VisualDensity.compact
                                        ),
                                        child: Text(
                                          'View Detail',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: Color(0xff27BDBE),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric( horizontal: 25),
                                          backgroundColor: Color(0xff24AEB1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          visualDensity: VisualDensity.compact
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Add Test',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'Poppins',
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.add_circle_outline,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(color: Color(0xffD40000)),
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            '${lab_tests.diagnosticCentre} - ${lab_tests.distance} away',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                              fontSize: 12,
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
                        )
                    );
                  } else if (state is TestStateError) {
                    return Center(child: Text("Error loading data"));
                  }
                  return Center(child: Text("No Data Available"));
                }),
              ] else ...[
                BlocBuilder<ConditionCubit, ConditionBasedState>(
                  builder: (context, Conditionstate) {
                    if (Conditionstate is ConditionBasedLoading) {
                      return _shimmerList1();
                    } else if (Conditionstate is ConditionBasedLoaded) {
                      return Expanded(
                        child:ListView.builder(
                          itemCount: Conditionstate.conditionBasedModel.data?.length,
                          itemBuilder: (context, index) {
                            final items = Conditionstate.conditionBasedModel.data?[index];
                            return GestureDetector(
                              onTap: () {
                                // Handle card click, navigate or perform an action
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Product name and price
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            items?.name ?? '',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          // Space between product name and price
                                          Text(
                                            ('${items?.testsAvailable.toString() ?? ''} Tests Available'),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                              color: Color(0xff808080),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Dummy image instead of noOfTests
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 16,
                                        weight: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      );
                    } else if (Conditionstate is ConditionBasedError) {
                      return Center(
                          child: Text("Error loading ConditionBaseddata"));
                    }

                    return Center(child: Text("No Data Available"));
                  },
                ),
              ]
            ],
          ),
        ));
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
    )
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
        )
    );
  }
}
