import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:revxpharma/Components/CustomSnackBar.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Patient/logic/cubit/appointment/appointment_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/patient/patient_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/patient/patient_state.dart';
import 'package:revxpharma/Patient/screens/AddPatientScreen.dart';
import 'package:revxpharma/Patient/screens/widgets/DetailRow.dart';
import '../../Components/ShakeWidget.dart';
import '../../Components/debugPrint.dart';
import 'Appointment.dart';
import 'MyAppointments.dart';

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
  int _selectedIndex = 0; // Track the selected index
  // List of dates for the current week
  final List<DateTime> _dates = List.generate(7, (index) {
    return DateTime.now().add(Duration(days: index));
  });

  String selectedDate = "";
  String selectedTime = "";
  void _onDateSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Format and store selected date as 'yyyy-MM-dd' (String)
    selectedDate = DateFormat('yyyy-MM-dd').format(_dates[index]);

    // Pass DateTime (_dates[index]) instead of String (selectedDate)
    timeSlots = generateTimeSlots(widget.starttime, widget.endtime, _dates[index]);

    print("Selected Date: $selectedDate");
  }


  List<String> generateHourlyTimeSlots() {
    List<String> timeSlots = [];
    for (int hour = 0; hour < 24; hour++) {
      String formattedTime = "${hour.toString().padLeft(2, '0')}:00";
      timeSlots.add(formattedTime);
    }
    return timeSlots;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        timeSlots = generateTimeSlots(widget.starttime, widget.endtime, pickedDate); // Pass DateTime
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<PatientCubit>().getDefaultPatientDetails();
    print(
        "VendorId: ${widget.vendorID}, starttime: ${widget.starttime}, endtime: ${widget.endtime}");
    DateTime selectedDate = DateTime.now();
    timeSlots =
        generateTimeSlots(widget.starttime, widget.endtime, selectedDate);
  }

  List<String> timeSlots = [];
  int selectedIndex = -1; // Stores the selected index
  final ScrollController _scrollController = ScrollController();

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

    // Convert selected time to HH:mm:ss format
    String SelectedTime = "${timeSlots[index]}:00";
    selectedTime = "${timeSlots[index]}:00";
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
      validateSelectedDate =
          selectedDate == "" ? "Please Select Appointment Date" : "";
      validateSelectedTime =
          selectedTime == "" ? "Please Select Appointment Time" : "";
    });
    if (validateSelectedDate.isEmpty && validateSelectedTime.isEmpty) {
      Map<String, dynamic> Data = {
        'patient': selectedPatientId,
        'diagnostic_centre': widget.vendorID,
        'appointment_date': selectedDate,
        'start_time': selectedTime,
        'total_amount': widget.totalamount,
        'payment_mode': "cash_on_test",
      };
      context.read<AppointmentCubit>().bookAppointment(Data);
      LogHelper.printLog('Appointment data : ', Data);
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: "Schedule an appointment", actions: []),
      body: BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentLoaded) {
            if (state.appointments.settings?.success == 1) {
              CustomSnackBar.show(context, "Appointment Booked Successfully!");
              context.read<CartCubit>().getCartList();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Myappointments()),
              );
            } else {
              CustomSnackBar.show(context, "${state.appointments.settings?.message}");
            }
          }
        },
        builder: (context, state) {
          return  SingleChildScrollView(
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
                              return Color(0xff27BDBE); // Default text color
                            },
                          ),
                        ),
                        child: Text(
                          "Change",
                          style: TextStyle(
                            color: Color(0xff27BDBE),
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
                      //       color: Color(0xff27BDBE),
                      //     )
                      //     )
                    ],
                  ),
                  BlocBuilder<PatientCubit, PatientState>(
                      builder: (context, state) {
                        if (state is PatientDetailsLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff27BDBE),
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
                              return Color(0xff27BDBE); // Default text color
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
                      scrollDirection: Axis.horizontal,
                      itemCount: _dates.length,
                      itemBuilder: (context, index) {
                        final date = _dates[index];
                        final isSelected = index == _selectedIndex; // Track selection
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              validateSelectedDate = "";
                            });
                            _onDateSelected(index); // Handle date selection
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 60,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(0xff27BDBE)
                                  : Color(0xffD3D3D3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('dd').format(date),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Color(0xff1A1A1A),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  DateFormat('EEE').format(date),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Color(0xff1A1A1A),
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
                      //         return Color(0xff27BDBE); // Default text color
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
                            setState(() {
                              validateSelectedTime = "";
                            });
                            onSelectTime(index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 60,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(
                                  0xff27BDBE) // Highlight selected time slot
                                  : (isCurrentHour
                                  ? Color(0xff27BDBE)
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
                  InkWell(
                    onTap: state is AppointmentLoading
                        ? null
                        : () {
                      submitData();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 40, bottom: 20),
                      width: w,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF00C4D3),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child:state is AppointmentLoading?
                      CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 1,
                      )
                        :Text(
                          'Book Appointment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
        },
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
                    color: Color(0xff27BDBE),
                  ),
                );
              } else if (state is PatientsListLoaded) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
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
                      ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        itemCount:
                            state.patientsListModel.patientslist?.length ?? 0,
                        itemBuilder: (context, index) {
                          final patient =
                              state.patientsListModel.patientslist?[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white, // Default background
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selectedPatientId == patient?.id
                                      ? Colors.teal
                                      : Colors.transparent, // Highlight border
                                  width: 2,
                                ),
                              ),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    selectedPatientId = patient?.id;
                                    context
                                        .read<PatientCubit>()
                                        .getPatientDetails(selectedPatientId);
                                    Navigator.pop(context);
                                  });
                                },
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                title: Text(
                                  patient?.patientName ?? 'Unknown',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                subtitle: Text(
                                  '${patient?.dob ?? ''} / ${patient?.gender ?? ''} / ${patient?.bloodGroup ?? ''}',
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
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddPatientScreen(
                                              type: "edit",
                                              pateint_id: patient?.id ?? "",
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.edit,
                                          size: 20, color: Colors.blue),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        context
                                            .read<PatientCubit>()
                                            .deletePatient(patient?.id ?? '');
                                      },
                                      icon: Icon(Icons.delete,
                                          size: 20, color: Colors.red),
                                    ),
                                  ],
                                ),
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
