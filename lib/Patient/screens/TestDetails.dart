import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Patient/logic/cubit/test_details/test_details_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/test_details/test_details_state.dart';
import 'package:revxpharma/Utils/media_query_helper.dart';

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
            return CircularProgressIndicator();
          } else if (state is TestDetailsLoaded) {
            return Column(
              children: [
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.only(left: 16),
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
                              fontSize: 12,
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
    );
  }
}
