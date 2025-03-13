import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:revxpharma/Utils/color.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool isTodaySelected = true;
  bool isTomarrowSelected = false;
  bool isThisWeekSelected = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
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
                  indicatorColor: primaryColor,
                  indicatorWeight: 0.01,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.symmetric(horizontal: 35),
                  labelStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: primaryColor,
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
              if (_tabController.index == 0) ...[
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
                                ?  primaryColor
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              "Today",
                              style: TextStyle(
                                color: isTodaySelected
                                    ? Colors.white
                                    :  primaryColor,
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
                                ?  primaryColor
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              "Tomarrow",
                              style: TextStyle(
                                color: isTomarrowSelected
                                    ? Colors.white
                                    :  primaryColor,
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
                                ?  primaryColor
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              "This Week",
                              style: TextStyle(
                                color: isThisWeekSelected
                                    ? Colors.white
                                    :  primaryColor,
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
              ] else ...[
                Container()
              ],
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
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Calender',
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
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
                            color: primaryColor,
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
                              // IconButton.filled(
                              //   style: ButtonStyle(
                              //       backgroundColor: MaterialStateProperty.all(
                              //           Colors.white)),
                              //   onPressed: () {},
                              //   icon:
                              DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  customButton: const Icon(
                                    Icons.more_vert_rounded,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                  items: [
                                    ...MenuItems.firstItems.map(
                                      (item) => DropdownMenuItem<MenuItem>(
                                        value: item,
                                        child: MenuItems.buildItem(item),
                                      ),
                                    ),
                                    DropdownMenuItem<Divider>(
                                      enabled: false,
                                      child: Divider(color: Colors.white),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    if (value != null) {
                                      MenuItems.onChanged(context,
                                          value as MenuItem, "address_id_here");
                                    }
                                  },
                                  dropdownStyleData: DropdownStyleData(
                                    width: 200,
                                    padding: EdgeInsets.symmetric(vertical: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white,
                                    ),
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    customHeights: [
                                      ...List<double>.filled(
                                          MenuItems.firstItems.length, 48),
                                      8,
                                    ],
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16),
                                  ),
                                ),
                              ),

                              // )
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            '1 Hour slot',
                            style: TextStyle(
                                color: Color(0xff151515),
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: 'Poppins'),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Mon 22 April  -  10:30 A.M',
                            style: TextStyle(
                                color: Color(0xff151515),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontFamily: 'Poppins'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Complete blood picture',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontFamily: 'Poppins'),
                              ),
                              OutlinedButton(
                                  style: ButtonStyle(
                                      visualDensity: VisualDensity.comfortable,
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 0)),
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              color: primaryColor,
                                              width: 0.5)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent)),
                                  onPressed: () {},
                                  child: Text(
                                    'Pending',
                                    style: TextStyle(
                                        color: Color(0xff151515),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: 'Poppins'),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            height: 1,
                            color: Color(0xffCACACA),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Notes : Test is incomplete',
                            style: TextStyle(
                                color: Color(0xff151515),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                fontFamily: 'Poppins'),
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

class MenuItem {
  final List<Widget> textButtons;

  MenuItem({
    required this.textButtons,
  });
}

abstract class MenuItems {
  static List<MenuItem> get firstItems {
    return [
      MenuItem(
        textButtons: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Update Status",
              style: TextStyle(
                color: Color(0xff151515),
                fontWeight: FontWeight.w400,
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
      MenuItem(
        textButtons: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Edit Appointment",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xff151515),
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
      MenuItem(
        textButtons: [
          TextButton(
            onPressed: () {},
            child: Text(
              overflow: TextOverflow.ellipsis,
              "Reschedule Appointment",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xff151515),
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
      MenuItem(
        textButtons: [
          TextButton(
            onPressed: () {},
            child: Text(
              overflow: TextOverflow.ellipsis,
              "Cancel Appointment",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: Color(0xff151515),
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    ];
  }

  static Widget buildItem(MenuItem item) {
    return Column(
      children: item.textButtons,
    );
  }

  static void onChanged(
      BuildContext context, MenuItem item, String addressId) {}
}
