import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/ShakeWidget.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Components/debugPrint.dart';
import 'package:revxpharma/Patient/screens/ScheduleAppointment.dart';
import 'package:revxpharma/Utils/color.dart';
import '../logic/cubit/cart/cart_cubit.dart';
import '../logic/cubit/cart/cart_state.dart';
import 'Appointment1.dart';

class Apointments extends StatefulWidget {
  const Apointments({super.key});

  @override
  State<Apointments> createState() => _ApointmentsState();
}

class _ApointmentsState extends State<Apointments> {
  @override
  void initState() {
    context.read<CartCubit>().getCartList();
    _initializeDates();
    super.initState();
  }

  String vendorID = "";
  String startTime = "";
  String endTime = "";
  int? totalamount;
  List<String> daysOpened = []; // Add this to store available days
  final List<String> patientOptions = [
    '1 Patient',
    '2 Patients',
    '3 Patients',
    '4 Patients',
    '5 Patients'
  ];
  int _selectedDateIndex = 0;
  List<DateTime> _dates = [];

  DateTime? _selectedDate;
  String selectedDate = "";
  String selectedTime = "";

  void _initializeDates() {
    DateTime now = DateTime.now();
    _generateDatesForMonth(now.year, now.month);
    _selectedDate = _dates.isNotEmpty ? _dates[0] : now;
    selectedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
    timeSlots = generateTimeSlots(startTime, endTime, _selectedDate!);
    print("starttime: $startTime, endtime: $endTime");
  }

  void _generateDatesForMonth(int year, int month) {
    DateTime now = DateTime.now();
    int lastDay = DateTime(year, month + 1, 0).day;
    List<DateTime> allDates = List.generate(
      lastDay,
          (index) => DateTime(year, month, index + 1),
    );

    // Filter dates based on daysOpened
    List<String> lowercaseDays = daysOpened.map((day) => day.toLowerCase()).toList();
    _dates = allDates.where((date) {
      String weekday = DateFormat('EEEE').format(date).toLowerCase();
      // If daysOpened is empty, show all dates; otherwise, filter by opened days
      return daysOpened.isEmpty ||
          (lowercaseDays.contains(weekday) &&
              (date.isAfter(now.subtract(Duration(days: 1))) ||
                  (date.day == now.day && date.month == now.month && date.year == now.year)));
    }).toList();

    print("Generated dates for $year-$month: ${_dates.map((d) => DateFormat('yyyy-MM-dd EEE').format(d)).toList()}");
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = now;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? firstDate,
      firstDate: firstDate,
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime date) {
        if (daysOpened.isEmpty) return true; // Show all days if daysOpened is empty
        String weekday = DateFormat('EEEE').format(date).toLowerCase();
        return daysOpened.map((day) => day.toLowerCase()).contains(weekday);
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        // Regenerate dates for the full selected month with daysOpened filter
        _generateDatesForMonth(pickedDate.year, pickedDate.month);

        // Find index of selected date or closest available date
        _selectedDateIndex = _dates.indexWhere((date) =>
        date.day == pickedDate.day &&
            date.month == pickedDate.month &&
            date.year == pickedDate.year);

        if (_selectedDateIndex == -1 && _dates.isNotEmpty) {
          // If exact date not available, select closest available date
          _selectedDateIndex = 0;
          DateTime closestDate = _dates.reduce((a, b) =>
          a.difference(pickedDate).abs() < b.difference(pickedDate).abs() ? a : b);
          _selectedDateIndex = _dates.indexOf(closestDate);
          _selectedDate = _dates[_selectedDateIndex];
          selectedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
        }

        timeSlots = generateTimeSlots(startTime, endTime, _selectedDate!);
        validateSelectedDate = "";

        print("Selected date: $selectedDate, Index: $_selectedDateIndex");

        if (_selectedDateIndex >= 0 && _selectedDateIndex < _dates.length) {
          _scrollController1.animateTo(
            _selectedDateIndex * 70.0,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  void _onDateSelected(int index) {
    setState(() {
      _selectedDateIndex = index;
      _selectedDate = _dates[index];
      selectedDate = DateFormat('yyyy-MM-dd').format(_dates[index]);
      validateSelectedDate = "";
      _scrollController1.animateTo(
        index * 70.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      timeSlots = generateTimeSlots(startTime, endTime, _dates[index]);
      print("Selected Date: $selectedDate");
    });
  }

  List<String> generateTimeSlots(
      String startTime, String endTime, DateTime selectedDate) {
    List<String> timeSlots = [];
    DateFormat format = DateFormat("HH:mm:ss");
    DateTime start;
    DateTime end;
    try {
      start = format.parse(startTime.isEmpty ? "09:00:00" : startTime);
      end = format.parse(endTime.isEmpty ? "17:00:00" : endTime);
    } catch (e) {
      print("Error parsing time: $e, using defaults 09:00:00 - 17:00:00");
      start = format.parse("09:00:00");
      end = format.parse("17:00:00");
    }

    DateTime now = DateTime.now();
    bool isToday = selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;

    if (end.isBefore(start)) {
      end = end.add(Duration(days: 1));
    }

    while (start.isBefore(end)) {
      DateTime fullDateTime = DateTime(selectedDate.year, selectedDate.month,
          selectedDate.day, start.hour, start.minute);

      if (!isToday || fullDateTime.isAfter(now)) {
        timeSlots.add(DateFormat("HH:mm").format(start));
      }
      start = start.add(Duration(minutes: 30));
    }

    return timeSlots;
  }

  void onSelectTime(int index) {
    setState(() {
      selectedIndex = index;
      selectedTime = "${timeSlots[index]}:00";
      validateSelectedTime = "";
      print("Selected Time: $selectedTime");
      _scrollController.animateTo(
        index * 70.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  List<String> timeSlots = [];
  int selectedIndex = -1;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController1 = ScrollController();

  String validateSelectedDate = "";
  String validateSelectedTime = "";
  void submitData() {
    setState(() {
      validateSelectedDate =
      selectedDate.isEmpty ? "Please Select Appointment Date" : "";
      validateSelectedTime =
      selectedTime.isEmpty ? "Please Select Appointment Time" : "";
    });
    if (validateSelectedDate.isEmpty && validateSelectedTime.isEmpty) {
      Map<String, dynamic> data = {
        'diagnostic_centre': vendorID,
        'appointment_date': selectedDate,
        'start_time': selectedTime,
        'total_amount': totalamount
      };
      try {
        context.push('/payment', extra: data);
        LogHelper.printLog('Appointment data:', data);
      } catch (error) {
        LogHelper.printLog('Error while booking:', error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(title: "Appointment   ", actions: []),
      body: BlocBuilder<CartCubit, CartState>(builder: (context, cartState) {
        if (cartState is CartLoadingState) {
          return _shimmerList();
        } else if (cartState is CartLoaded) {
          vendorID = cartState.cartList?.data?.diagnosticCentre?.id ?? "";
          startTime =
              cartState.cartList?.data?.diagnosticCentre?.startTime ?? "";
          endTime = cartState.cartList?.data?.diagnosticCentre?.endTime ?? "";
          totalamount = cartState.cartList?.data?.totalAmount ?? 0;
          daysOpened = cartState.cartList?.data?.diagnosticCentre?.daysOpened ?? []; // Update daysOpened

          // Regenerate dates when daysOpened is available
          if (daysOpened.isNotEmpty) {
            _generateDatesForMonth(_selectedDate!.year, _selectedDate!.month);
            _selectedDateIndex = _dates.indexWhere((date) =>
            date.day == _selectedDate!.day &&
                date.month == _selectedDate!.month &&
                date.year == _selectedDate!.year);
            if (_selectedDateIndex == -1 && _dates.isNotEmpty) {
              _selectedDateIndex = 0;
              _selectedDate = _dates[0];
              selectedDate = DateFormat('yyyy-MM-dd').format(_selectedDate!);
            }
            timeSlots = generateTimeSlots(startTime, endTime, _selectedDate!);
          }
          if (totalamount != 0 && totalamount != null) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            "${cartState.cartList?.data?.diagnosticCentre?.name}",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins"),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/location.png",
                          height: 20,
                          width: 20,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Text(
                                "${cartState.cartList?.data?.diagnosticCentre?.location}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color(0xff949494),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    ListView.separated(physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(height: 12),
                      shrinkWrap: true,
                      itemCount:
                      cartState.cartList?.data?.cartTests?.length ?? 0,
                      itemBuilder: (context, index) {
                        final cartLists =
                        cartState.cartList?.data?.cartTests![index];
                        String selectedPatient = '1 Patient';
                        return Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffABABAB), width: 0.5),
                              color: Color(0xffFAF9F6),
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${cartLists?.testName ?? ''}',
                                    style: TextStyle(
                                      color: Color(0xff222222),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                  IconButton.outlined(
                                      visualDensity: VisualDensity.compact,
                                      onPressed: () {
                                        context
                                            .read<CartCubit>()
                                            .removeFromCart(
                                            cartLists?.testId ?? "",);
                                        context.pop();
                                      },
                                      style: IconButton.styleFrom(
                                        side: BorderSide.none,
                                      ),
                                      icon: Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '₹ ${cartLists?.price ?? 0}',
                                        style: TextStyle(
                                          color: Color(0xff222222),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Container(height: 25,
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                            color: Color(0xffD9F2EF),
                                            borderRadius: BorderRadius.circular(8)),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton<String>(
                                                borderRadius: BorderRadius.circular(8),
                                                value: selectedPatient,
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color(0xff00A991),
                                                  size: 18,
                                                ),
                                                style: TextStyle(
                                                  color: Color(0xff333333),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Poppins',
                                                ),
                                                onChanged: (String? newValue) {
                                                  if (newValue != null) {
                                                    setState(() {
                                                      selectedPatient = newValue;
                                                      print(
                                                          'Selected patient: $selectedPatient');
                                                    });
                                                  }
                                                },
                                                items: patientOptions
                                                    .map<DropdownMenuItem<String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                            color: Color(0xff333333),
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w400,
                                                            fontFamily: 'Poppins',
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  ClipRRect(borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      width: w * 0.2,
                                      height: w * 0.2,
                                      cartLists?.testImage??'',
                                      fit: BoxFit.cover
                                      ,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          "Select the Date",
                          style: TextStyle(
                              color: Color(0xff1A1A1A),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              fontSize: 14),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          style: ButtonStyle(
                            visualDensity: VisualDensity.compact,
                            overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered)) {
                                  return Colors.teal.withOpacity(0.1);
                                }
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.teal.withOpacity(0.2);
                                }
                                return null;
                              },
                            ),
                            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                return primaryColor;
                              },
                            ),
                          ),
                          child: Text(
                            "Calendar",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        controller: _scrollController1,
                        scrollDirection: Axis.horizontal,
                        itemCount: _dates.length,
                        itemBuilder: (context, index) {
                          final date = _dates[index];
                          final isSelected = index == _selectedDateIndex;
                          return GestureDetector(
                            onTap: () {
                              _onDateSelected(index);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 60,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isSelected ? primaryColor : Color(0xffD3D3D3),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat('dd').format(date),
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Color(0xff1A1A1A),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    DateFormat('EEE').format(date),
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Color(0xff1A1A1A),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (validateSelectedDate != "") ...[
                      Container(
                        alignment: Alignment.topLeft,
                        child: ShakeWidget(
                          key: Key(validateSelectedDate),
                          duration: const Duration(milliseconds: 700),
                          child: Text(
                            "$validateSelectedDate",
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(height: 10),
                    ],
                    Row(
                      children: [
                        Text(
                          "Select the Time",
                          style: TextStyle(
                              color: Color(0xff1A1A1A),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        itemCount: timeSlots.length,
                        itemBuilder: (context, index) {
                          final time = timeSlots[index];
                          final isSelected = selectedIndex == index;
                          final isCurrentHour =
                              time == DateFormat('HH:mm').format(DateTime.now());
                          return GestureDetector(
                            onTap: () {
                              onSelectTime(index);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              width: 60,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? primaryColor
                                    : (isCurrentHour
                                    ? primaryColor
                                    : Color(0xffD3D3D3)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : (isCurrentHour
                                        ? Colors.white
                                        : Color(0xff4B4B4B)),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (validateSelectedTime != "") ...[
                      Container(
                        alignment: Alignment.topLeft,
                        child: ShakeWidget(
                          key: Key(validateSelectedTime),
                          duration: const Duration(milliseconds: 700),
                          child: Text(
                            "$validateSelectedTime",
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(height: 50),
                    ],
                    SizedBox(height: 15),
                    Text(
                      "Bill Summary",
                      style: TextStyle(
                        color: Color(0xff1A1A1A),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Color(0xffA9A9A9), width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "No. of Tests",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "${cartState.cartList?.data?.cartTests?.length}",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Total MRP",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "₹${cartState.cartList?.data?.totalAmount}",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Divider(
                            color: Color(0xff808080),
                            height: 1,
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                "Amount to be paid",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "₹${cartState.cartList?.data?.totalAmount}",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text("No Data Available"));
          }
        }
        return Center(child: Text("No Data Available"));
      }),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          if (cartState is CartLoaded) {
            if (cartState.cartList?.data?.totalAmount != null &&
                cartState.cartList!.data!.totalAmount != 0) {
              return Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(color: Colors.white),
                child: ElevatedButton(
                  onPressed: () {
                    submitData();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Save & Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: 18,
                    ),
                  ),
                ),
              );
            }
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _shimmerList() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerText(120, 12, context),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerRectangle(20, context),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: shimmerText(120, 12, context)),
                ],
              ),
            ],
          ),
          SizedBox(height: 23),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 6,
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                    height: 16,
                  ),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              shimmerText(160, 12, context),
                              shimmerRectangle(20, context),
                            ],
                          ),
                          const SizedBox(height: 4),
                          shimmerText(60, 12, context)
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          shimmerText(120, 12, context),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    shimmerText(80, 12, context),
                    Spacer(),
                    shimmerText(60, 12, context),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    shimmerText(60, 12, context),
                    Spacer(),
                    shimmerText(60, 12, context),
                  ],
                ),
                SizedBox(height: 16),
                Divider(
                  color: Color(0xff808080),
                  height: 1,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    shimmerText(100, 12, context),
                    Spacer(),
                    shimmerText(60, 12, context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}