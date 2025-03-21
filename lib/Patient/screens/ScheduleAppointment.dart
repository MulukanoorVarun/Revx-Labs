import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:revxpharma/Components/CustomSnackBar.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Patient/logic/cubit/appointment/appointment_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/patient/patient_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/patient/patient_state.dart';
import 'package:revxpharma/Patient/screens/AddPatientScreen.dart';
import 'package:revxpharma/Patient/screens/widgets/DetailRow.dart';
import 'package:revxpharma/Utils/color.dart';
import '../../Components/ShakeWidget.dart';
import '../../Components/debugPrint.dart';
import 'Appointment.dart';
import 'MyAppointments.dart';
import 'Payment.dart';

class ScheduleAnAppointment extends StatefulWidget {
  final String vendorID;
  final String starttime;
  final String endtime;
  final String totalamount;

  const ScheduleAnAppointment({
    Key? key,
    required this.vendorID,
    required this.starttime,
    required this.endtime,
    required this.totalamount,
  }) : super(key: key);

  @override
  State<ScheduleAnAppointment> createState() => _ScheduleAnAppointmentState();
}

class _ScheduleAnAppointmentState extends State<ScheduleAnAppointment> {
  bool? groupValue;
  int _selectedDateIndex = -1;
  final DateTime now = DateTime.now();
  List<DateTime> _dates = [];


  DateTime? _selectedDate;
  String selectedDate = "";
  String selectedTime = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = now; // Set firstDate as today

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null && _selectedDate!.isAfter(firstDate)
          ? _selectedDate
          : firstDate,
      firstDate: firstDate,
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        selectedDate= DateFormat('yyyy-MM-dd').format(pickedDate);
        _selectedDateIndex = _dates.indexWhere((date) =>
        date.year == pickedDate.year &&
            date.month == pickedDate.month &&
            date.day == pickedDate.day
        );
        timeSlots = generateTimeSlots(widget.starttime, widget.endtime, pickedDate);
        validateSelectedDate = "";
        if (_selectedDateIndex != -1) {
          _scrollController1.animateTo(
            _selectedDateIndex! * 70.0, // Adjusting scroll position
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
    // Format and store selected date as 'yyyy-MM-dd' (String)
    selectedDate = DateFormat('yyyy-MM-dd').format(_dates[index]);
      validateSelectedDate="";
    _scrollController1.animateTo(
      index * 70.0, // Smooth scroll to the selected date
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    // Pass DateTime (_dates[index]) instead of String (selectedDate)
    timeSlots = generateTimeSlots(widget.starttime, widget.endtime, _dates[index]);

    print("Selected Date: $selectedDate");
    });
  }

  List<String> generateHourlyTimeSlots() {
    List<String> timeSlots = [];
    for (int hour = 0; hour < 24; hour++) {
      String formattedTime = "${hour.toString().padLeft(2, '0')}:00";
      timeSlots.add(formattedTime);
    }
    return timeSlots;
  }

  @override
  void initState() {
    super.initState();
    context.read<PatientCubit>().getDefaultPatientDetails();
    print(
        "VendorId: ${widget.vendorID}, starttime: ${widget.starttime}, endtime: ${widget.endtime}");
    DateTime selectedDate = DateTime.now();
    DateTime now = DateTime.now();
    int lastDay = DateTime(now.year, now.month + 1, 0).day;
    _dates = List.generate(
      lastDay - now.day + 1,
          (index) => DateTime(now.year, now.month, now.day + index),
    );
    timeSlots =
        generateTimeSlots(widget.starttime, widget.endtime, selectedDate);
  }

  List<String> timeSlots = [];
  int selectedIndex = -1; // Stores the selected index
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController1 = ScrollController();

  String? selectedPatientId;
  String? totalamount;

  List<String> generateTimeSlots(
      String startTime, String endTime, DateTime selectedDate) {
    List<String> timeSlots = [];
    DateFormat format = DateFormat("HH:mm:ss");

    DateTime start = format.parse(startTime);
    DateTime end = format.parse(endTime);

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
    });
    String SelectedTime = "${timeSlots[index]}:00";
    selectedTime = "${timeSlots[index]}:00";
    validateSelectedTime = "";
    print("Selected Time: $selectedTime");
    // Scroll to the selected index smoothly
    _scrollController.animateTo(
      index * 70.0, // Adjust the scroll position
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  String validateSelectedDate = "";
  String validateSelectedTime = "";

  void submitData() {
    setState(() {
      validateSelectedDate = selectedDate.isEmpty || selectedDate==null ? "Please Select Appointment Date" : "";
      validateSelectedTime = selectedTime.isEmpty || selectedTime==null ? "Please Select Appointment Time" : "";
    });
    if (validateSelectedDate.isEmpty && validateSelectedTime.isEmpty) {
      Map<String, dynamic> data = {
        'patient': selectedPatientId,
        'diagnostic_centre': widget.vendorID,
        'appointment_date': selectedDate,
        'start_time': selectedTime,
        'total_amount': widget.totalamount
      };
      try {
        context.pushReplacement('/payment', extra: data);

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
      appBar: CustomAppBar(title: "Schedule an appointment", actions: []),
      body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Patient details",
                        style: TextStyle(
                            color: Color(0xff1A1A1A),
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            fontSize: 15),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          context.read<PatientCubit>().getPatients();
                          _showBottomSheet(context);
                        },
                        style: ButtonStyle(
                          visualDensity: VisualDensity.compact,
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) {
                                return Colors.teal
                                    .withOpacity(0.1); // Light teal on hover
                              }
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.teal
                                    .withOpacity(0.2); // Darker effect on tap
                              }
                              return null;
                            },
                          ),
                          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return primaryColor; // Default text color
                            },
                          ),
                        ),
                        child: Text(
                          "Change",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                      ),
                      // IconButton(
                      //     visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => AddPatientScreen(
                      //                     type: "add",pateint_id: '',
                      //                   )));
                      //     },
                      //     icon: Icon(
                      //       Icons.add_circle_outline,
                      //       size: 36,
                      //       color: primaryColor,
                      //     )
                      //     )
                    ],
                  ),
                  BlocBuilder<PatientCubit, PatientState>(
                      builder: (context, state) {
                        if (state is PatientDetailsLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          );
                        } else if (state is PatientsDetailsLoaded) {
                          selectedPatientId =
                              state.getPatientDetailsmodel.getPatientDetails?.id;
                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0), // Inner padding
                              child: Column(
                                spacing: 15,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DetailRow(
                                      label: "Patient Name",
                                      value:
                                      "${state.getPatientDetailsmodel.getPatientDetails?.patientName}"),
                                  DetailRow(
                                      label: "Mobile Number",
                                      value:
                                      "+91 ${state.getPatientDetailsmodel.getPatientDetails?.mobile}"),
                                  DetailRow(
                                      label: "Gender",
                                      value:
                                      "${state.getPatientDetailsmodel.getPatientDetails?.gender}"),
                                  DetailRow(
                                      label: "DOB",
                                      value:
                                      "${state.getPatientDetailsmodel.getPatientDetails?.dob}"),
                                  DetailRow(
                                      label: "Age",
                                      value:
                                      "${state.getPatientDetailsmodel.getPatientDetails?.age} years"),
                                  DetailRow(
                                      label: "Blood Group",
                                      value:
                                      "${state.getPatientDetailsmodel.getPatientDetails?.bloodGroup}"),
                                ],
                              ),
                            ),
                          );
                        }
                        return Center(child: Text("No Data"));
                      }),
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
                                return Colors.teal
                                    .withOpacity(0.1); // Light teal on hover
                              }
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.teal
                                    .withOpacity(0.2); // Darker effect on tap
                              }
                              return null;
                            },
                          ),
                          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return primaryColor; // Default text color
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
                          "${validateSelectedDate}",
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
                    SizedBox(
                      height: 10,
                    ),
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
                      // Spacer(),
                      // TextButton(
                      //   onPressed: () {
                      //     _selectDate(context);
                      //   },
                      //   style: ButtonStyle(
                      //     visualDensity: VisualDensity.compact,
                      //     overlayColor: MaterialStateProperty.resolveWith<Color?>(
                      //       (Set<MaterialState> states) {
                      //         if (states.contains(MaterialState.hovered)) {
                      //           return Colors.teal
                      //               .withOpacity(0.1); // Light teal on hover
                      //         }
                      //         if (states.contains(MaterialState.pressed)) {
                      //           return Colors.teal
                      //               .withOpacity(0.2); // Darker effect on tap
                      //         }
                      //         return null;
                      //       },
                      //     ),
                      //     foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      //       (Set<MaterialState> states) {
                      //         return primaryColor; // Default text color
                      //       },
                      //     ),
                      //   ),
                      //   child: Text(
                      //     "Set Time",
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w500,
                      //       fontFamily: "Poppins",
                      //       fontSize: 14,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                                  ?
                                  primaryColor
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
                          "${validateSelectedTime}",
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
                    SizedBox(
                      height: 50,
                    ),
                  ],
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: submitData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      minimumSize: Size(w, 50), // Full-width button with height 50
                      elevation: 0, // Remove shadow if needed
                    ),
                    child:  Text(
                      'Book Appointment',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
      );
  }

  Future _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          // You still need setState here to rebuild StatefulBuilder
          return BlocBuilder<PatientCubit, PatientState>(
            builder: (context, state) {
              if (state is PatientListLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              } else if (state is PatientsListLoaded) {
                return Container(
                  padding: EdgeInsets.all(16),
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 5,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff808080),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Patients List",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              color: primaryColor,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddPatientScreen(
                                    type: "add",
                                    pateint_id:                        "",
                                  ),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                              side: BorderSide(color: primaryColor, width: 1), // Border color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Border radius
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Add",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: primaryColor,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(Icons.add_circle_outline, color: primaryColor),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        itemCount: state.patientsListModel.patientslist?.length ?? 0,
                        itemBuilder: (context, index) {
                          final patient = state.patientsListModel.patientslist?[index];
                          return Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: selectedPatientId == patient?.id ? Colors.teal : Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  selectedPatientId = patient?.id;
                                  context.read<PatientCubit>().getPatientDetails(selectedPatientId);
                                  Navigator.pop(context);
                                });
                              },
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              title: Text(
                                "${patient?.patientName ?? 'Unknown'}",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              subtitle: Text(
                                '${patient?.age ?? ''} Years / ${patient?.gender ?? ''} / ${patient?.bloodGroup ?? ''}',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton.filled(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddPatientScreen(
                                            type: "edit",
                                            pateint_id: patient?.id ?? "",
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(Icons.edit, size: 20, color: Colors.white),
                                    style: IconButton.styleFrom(
                                      visualDensity: VisualDensity.compact,
                                      backgroundColor: primaryColor,
                                      padding: EdgeInsets.all(5),
                                    ),
                                  ),
                                  SizedBox(width: 8), // Spacing between buttons
                                  IconButton.filled(
                                    onPressed: () {
                                      context.read<PatientCubit>().deletePatient(patient?.id ?? '');
                                    },
                                    icon: Icon(Icons.delete, size: 20, color: Colors.white),
                                    style: IconButton.styleFrom(
                                      visualDensity: VisualDensity.compact,
                                      backgroundColor: primaryColor,
                                      padding: EdgeInsets.all(5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              } else if (state is PatientErrorState) {
                return Center(child: Text(state.errorMessage));
              }
              return Center(child: Text("No Data"));
            },
          );
        });
      },
    );
  }
}
