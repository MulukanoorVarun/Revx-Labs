import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:revxpharma/Components/CustomAppButton.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Vendor/Screens/PatientsList/PatientMedicalReports.dart';
import 'package:revxpharma/Vendor/Screens/PatientsList/PatientUserData.dart';
import 'package:revxpharma/Vendor/Screens/PatientsList/PatientVisit.dart';

class PateintDetails extends StatefulWidget {
  const PateintDetails({super.key});

  @override
  State<PateintDetails> createState() => _PateintDetailsState();
}

class _PateintDetailsState extends State<PateintDetails>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 0,
        toolbarHeight: 95,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  child: Image.asset('assets/person.png', fit: BoxFit.contain),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Ramesh Kumar',
                  style: TextStyle(
                    color: Color(0xff000000),
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(color: Color(0xffffffff)),
              child: TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Color(0xff24AEB1),
                indicatorWeight: 0.01,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.symmetric(horizontal: 30),
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xff24AEB1),
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Color(0xff808080),
                  fontSize: 13,
                ),
                tabs: [
                  Tab(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('User Data'))),
                  Tab(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Medical Reports'))),
                  Tab(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Visits'))),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        UserData(),
        MedicalReports(),
        PatientVisit()


      ]),

    );
  }
}
