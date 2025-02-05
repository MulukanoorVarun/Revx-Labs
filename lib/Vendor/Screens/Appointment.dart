import 'package:flutter/material.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isTodaySelected = true;
  bool isTomarrowSelected = true;
  bool isThisWeekSelected = true;

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
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
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
                  Text(
                    'Appointments',
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              // TabBar below the title
              Container(
                decoration: BoxDecoration(color: Color(0xffffffff)),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: Color(0xff24AEB1),
                  indicatorWeight: 0.01,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.symmetric(horizontal: 35),
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
                            child: Text('Scheduled'))),
                    Tab(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Past'))),
                    Tab(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Cancelled'))),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffF5F7FB),
                    borderRadius: BorderRadius.circular(100)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkResponse(
                      onTap: () {
                        setState(() {
                          isTodaySelected = true;
                          isTomarrowSelected = false;
                          isThisWeekSelected = false;
                        });
                      },
                      child: Container(
                        width: w * 0.3,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isTodaySelected
                              ? const Color(0xff27BDBE)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            "Today",
                            style: TextStyle(
                              color: isTodaySelected
                                  ? Colors.white
                                  : const Color(0xff27BDBE),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkResponse(
                      onTap: () {
                        setState(() {
                          isTodaySelected = false;
                          isTomarrowSelected = true;
                          isThisWeekSelected = false;
                        });
                      },
                      child: Container(
                        width: w * 0.3,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isTomarrowSelected
                              ? const Color(0xff27BDBE)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            "Tomarrow",
                            style: TextStyle(
                              color: isTomarrowSelected
                                  ? Colors.white
                                  : const Color(0xff27BDBE),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkResponse(
                      onTap: () {
                        setState(() {
                          isTodaySelected = false;
                          isTomarrowSelected = false;
                          isThisWeekSelected = true;
                        });
                      },
                      child: Container(
                        width: w * 0.3,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isThisWeekSelected
                              ? const Color(0xff27BDBE)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            "This Week",
                            style: TextStyle(
                              color: isThisWeekSelected
                                  ? Colors.white
                                  : const Color(0xff27BDBE),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Text(
                      '22th April, Monday',
                      style: TextStyle(
                          color: Color(0xff151515),
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/uil_calender.png',
                      fit: BoxFit.contain,
                      height: 14,
                      width: 14,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Calender',
                      style: TextStyle(
                          color: Color(0xff27BDBE),
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        border: Border.all(
                            color: Color(
                              0xff27BDBE,
                            ),
                            width: 0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ramesh Kumar',
                                style: TextStyle(
                                    color: Color(0xff151515),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Poppins'),
                              ),
                              IconButton.filled(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/more_vertical.png',
                                    fit: BoxFit.contain,
                                    width: 24,
                                    height: 24,
                                  ))
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
