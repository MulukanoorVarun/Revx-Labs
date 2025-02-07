import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:revxpharma/Components/CustomAppButton.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Vendor/Screens/Appointment.dart';
import 'package:revxpharma/Vendor/Screens/Catagory/CatagoryList.dart';
import 'package:revxpharma/Vendor/Screens/Catagory/VendorCatagory.dart';
import 'package:revxpharma/Vendor/Screens/PatientsList/Patients.dart';
import 'package:revxpharma/Vendor/Screens/Test/VendorTest.dart';

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  final List<String> daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  List<DateTime> dates = [];
  DateTime selectedDate = DateTime.now();
  DateTime currentMonth = DateTime.now();
  late ScrollController _scrollController;
  String formattedDate = '';
  @override
  void initState() {
    _scrollController = ScrollController();
    _generateDates();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
    super.initState();
  }

  void _scrollToSelectedDate() {
    final index = dates.indexWhere((date) =>
        date.day == selectedDate.day &&
        date.month == selectedDate.month &&
        date.year == selectedDate.year);

    if (index != -1) {
      final double offset = index * 55.0;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _generateDates() {
    final startOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final endOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);

    setState(() {
      dates = List.generate(
        endOfMonth.day,
        (index) => DateTime(currentMonth.year, currentMonth.month, index + 1),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: 'Dashboard', actions: []),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today Appointments',
                    style: TextStyle(
                        color: Color(0xff151515),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Appointments()));
                      },
                      icon: Icon(Icons.arrow_forward))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _buildProjectStatusCard(context),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Color(0xffD2CBFF),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xffE2E2E2), width: 2)),
                            child: Column(
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  'Pending',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  '6',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Color(0xffFFDDA9),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xffE2E2E2), width: 2)),
                            child: Column(
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  'Completed',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  '6',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Color(0xffFFBBBB),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Color(0xffE2E2E2), width: 2)),
                            child: Column(
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  'Cancelled',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  '6',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomAppButton(
                          text: 'Create new appointment',
                          onPlusTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Appointments()));
                          })
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Appointments',
                    style: TextStyle(
                        color: Color(0xff151515),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward))
                ],
              ),
              Text(
                '02',
                style: TextStyle(
                    color: Color(0xff151515),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 40),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 24,
                    color: Color(0xff808080),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    'Mar 01-07',
                    style: TextStyle(
                        color: Color(0xff808080),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 24,
                    color: Color(0xff808080),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(dates.length, (index) {
                            final isSelected =
                                dates[index].day == selectedDate.day &&
                                    dates[index].month == selectedDate.month &&
                                    dates[index].year == selectedDate.year;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDate = dates[index];
                                  formattedDate = DateFormat('yyyy-MM-dd')
                                      .format(selectedDate);
                                });
                                _scrollToSelectedDate();
                              },
                              child: ClipRect(
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  width: 51.5,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Color(0xff27BDBE)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dates[index].day.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        daysOfWeek[dates[index].weekday - 1],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff94A3B8),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: Color(0xff27BDBE),
                            size: 10,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'It represents appointments on that day ',
                            style: TextStyle(
                                color: Color(0xff808080),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'H',
                            style: TextStyle(
                                color: Color(0xffF26805),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'It represents Holiday',
                            style: TextStyle(
                                color: Color(0xff808080),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today Tests',
                    style: TextStyle(
                        color: Color(0xff151515),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Appointments()));
                      },
                      icon: Icon(Icons.arrow_forward))
                ],
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: RadialGradient(
                                colors: [
                                  Color(0xFF88E7FD),
                                  Color(0xFF086478),
                                ],
                                focal: Alignment.topRight,
                                radius: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/polygon.png',
                                  fit: BoxFit.contain,
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'MRI Scan',
                                  style: TextStyle(
                                      color: Color(0xff151515),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '10:30 AM',
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: RadialGradient(
                                colors: [
                                  Color(0xFF88E7FD),
                                  Color(0xFF086478),
                                ],
                                focal: Alignment.topRight,
                                radius: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/polygon.png',
                                  fit: BoxFit.contain,
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'CBC',
                                  style: TextStyle(
                                      color: Color(0xff151515),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '10:30 AM',
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: RadialGradient(
                                colors: [
                                  Color(0xFF88E7FD),
                                  Color(0xFF086478),
                                ],
                                focal: Alignment.topRight,
                                radius: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/polygon.png',
                                  fit: BoxFit.contain,
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'X-Ray',
                                  style: TextStyle(
                                      color: Color(0xff151515),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '10:30 AM',
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: w,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Color(0xffE2E2E2), width: 2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(colors: [
                                    Color(0xffA788FD),
                                    Color(0xff250878),
                                  ]),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Next patient',
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      fontSize: 12),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  child: Image.asset('assets/person.png'),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  width: w * 0.45,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        'Charan Konidela',
                                        style: TextStyle(
                                            color: Color(0xff808080),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins',
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        'MRI Scan',
                                        style: TextStyle(
                                            color: Color(0xff808080),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins',
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '10:30 AM',
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      fontSize: 14),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Quick Action',
                style: TextStyle(
                    color: Color(0xff151515),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 15),
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkResponse(onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>CatagoryList()));
                            },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: RadialGradient(
                                    colors: [
                                      Color(0xFF88E7FD),
                                      Color(0xFF086478),
                                    ],
                                    focal: Alignment.topRight,
                                    radius: 1.0,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Stack(
                                      children: [
                                        Image.asset(
                                          'assets/polygon.png',
                                          fit: BoxFit.contain,
                                          width: 38,
                                          height: 38,
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Categories',
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: InkResponse(onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorTest()));
                            },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: RadialGradient(
                                    colors: [
                                      Color(0xFFFDA388),
                                      Color(0xFF782308),
                                    ],
                                    focal: Alignment.topRight,
                                    radius: 1.0,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Stack(
                                      children: [
                                        Image.asset(
                                          'assets/polygon.png',
                                          fit: BoxFit.contain,
                                          width: 38,
                                          height: 38,
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Tests',
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: RadialGradient(
                                  colors: [
                                    Color(0xFF88A9FD),
                                    Color(0xFF082777),
                                  ],
                                  focal: Alignment.topRight,
                                  radius: 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Stack(
                                    children: [
                                      Image.asset(
                                        'assets/polygon.png',
                                        fit: BoxFit.contain,
                                        width: 38,
                                        height: 38,
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: 5,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Support',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: RadialGradient(
                                  colors: [
                                    Color(0xFFFD88B3),
                                    Color(0xFF780831),
                                  ],
                                  focal: Alignment.topRight,
                                  radius: 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Stack(
                                    children: [
                                      Image.asset(
                                        'assets/polygon.png',
                                        fit: BoxFit.contain,
                                        width: 38,
                                        height: 38,
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: 5,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Export data',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: RadialGradient(
                                  colors: [
                                    Color(0xFFA788FD),
                                    Color(0xFF250878),
                                  ],
                                  focal: Alignment.topRight,
                                  radius: 1.0,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Stack(
                                    children: [
                                      Image.asset(
                                        'assets/polygon.png',
                                        fit: BoxFit.contain,
                                        width: 38,
                                        height: 38,
                                      ),
                                      Positioned(
                                        right: 5,
                                        top: 5,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Payments',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: InkResponse(onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Patients()));
                            },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  gradient: RadialGradient(
                                    colors: [
                                      Color(0xFFDEFD88),
                                      Color(0xFF08774C),
                                    ],
                                    focal: Alignment.topRight,
                                    radius: 1.0,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Stack(
                                      children: [
                                        Image.asset(
                                          'assets/polygon.png',
                                          fit: BoxFit.contain,
                                          width: 38,
                                          height: 38,
                                        ),
                                        Positioned(
                                          right: 5,
                                          top: 5,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Color(0xff000000),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Patient',
                                            style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectStatusCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildCircularProgress(),
          SizedBox(width: 14),
          _buildProjectDetails(),
        ],
      ),
    );
  }

  Widget _buildCircularProgress() {
    double pendingProgress = 40.0;
    double completedProgress = 35.0;
    double cancelledProgress = 25.0;

    int totalAppointments = 12;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFfffff),
        shape: BoxShape.circle,
      ),
      width: 150,
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(136, 136),
            painter: RoundedProgressPainter(
                pendingProgress, completedProgress, cancelledProgress),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: "Inter",
                color: Colors.black, // Adjust the color as needed
              ),
              children: [
                TextSpan(
                  text: '$totalAppointments\n',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                TextSpan(
                  text: 'Appointments',
                  style: TextStyle(
                    fontSize: 12, // Smaller font size for the label
                    fontWeight: FontWeight.w400, // Regular weight for the label
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectDetails() {
    return Column(
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  _buildLegendItem(Color(0xffD2CBFF), "Pending"),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  _buildLegendItem(Color(0xffFFDDA9), "Completed"),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  _buildLegendItem(Color(0xffFFBBBB), "Cancelled"),
                ],
              ),
            ],
          )
        ]),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 27,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 10),
        Text(label,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                fontSize: 12,
                color: Color(0xff000000))),
      ],
    );
  }
}

class RoundedProgressPainter extends CustomPainter {
  final double pendingProgress;
  final double completedProgress;
  final double cancelledProgress;

  RoundedProgressPainter(
      this.pendingProgress, this.completedProgress, this.cancelledProgress);

  @override
  void paint(Canvas canvas, Size size) {
    print("Pending Progress: $pendingProgress");
    print("Completed Progress: $completedProgress");
    print("Cancelled Progress: $cancelledProgress");

    final Paint paintBackground = Paint()
      ..color = Colors.white10
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    // Colors for each section
    final Paint paintPending = Paint()
      ..color = Color(0xffD2CBFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final Paint paintCompleted = Paint()
      ..color = Color(0xffFFDDA9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final Paint paintCancelled = Paint()
      ..color = Color(0xffFFBBBB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;

    // Draw the background circle
    canvas.drawCircle(
      Offset(radius, radius),
      radius - paintBackground.strokeWidth / 2,
      paintBackground,
    );

    // Sweep angles for each status
    final double pendingAngle = 2 * 3.141592653589793 * (pendingProgress / 100);
    final double completedAngle =
        2 * 3.141592653589793 * (completedProgress / 100);
    final double cancelledAngle =
        2 * 3.141592653589793 * (cancelledProgress / 100);

    // Draw each progress arc (pending, completed, cancelled)
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius - paintPending.strokeWidth / 2),
      -3.141592653589793 / 2,
      pendingAngle,
      false,
      paintPending,
    );

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius - paintCompleted.strokeWidth / 2),
      -3.141592653589793 / 2 + pendingAngle,
      completedAngle,
      false,
      paintCompleted,
    );

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(radius, radius),
          radius: radius - paintCancelled.strokeWidth / 2),
      -3.141592653589793 / 2 + pendingAngle + completedAngle,
      cancelledAngle,
      false,
      paintCancelled,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint whenever progress changes
  }
}
