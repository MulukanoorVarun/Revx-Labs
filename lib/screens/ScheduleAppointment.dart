import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../Components/ShakeWidget.dart';
import 'Appointment.dart';

class ScheduleAnAppointment extends StatefulWidget {
  const ScheduleAnAppointment({super.key});

  @override
  State<ScheduleAnAppointment> createState() => _ScheduleAnAppointmentState();
}

class _ScheduleAnAppointmentState extends State<ScheduleAnAppointment> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _bloodGroup = TextEditingController();

  String _validateuserName = "";
  String _validatephoneNumber = "";
  String _validategender = "";
  String _validatedob = "";
  String _validateage = "";
  String _validatebloodGroop = "";

  // List of dates for the current week
  final List<DateTime> _dates = List.generate(7, (index) {
    return DateTime.now().add(Duration(days: index));
  });

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
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dob.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  void initState() {
    _userName.addListener(() {
      setState(() {
        _validateuserName = "";
      });
    });

    _gender.addListener(() {
      setState(() {
        _validategender = "";
      });
    });
    _dob.addListener(() {
      setState(() {
        _validatedob = "";
      });
    });
    _age.addListener(() {
      setState(() {
        _validateage = "";
      });
    });
    _bloodGroup.addListener(() {
      setState(() {
        _validatebloodGroop = "";
      });
    });

    super.initState();
  }

  void _validFields() {}

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Schedule an appointment",
          style: TextStyle(
            color: Color(0xff27BDBE),
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
          const EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Patient details",
                    style: TextStyle(
                        color: Color(0xff808080),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        fontSize: 16),
                  ),
                  Spacer(),
                  Text(
                    "Add more",
                    style: TextStyle(
                        color: Color(0xff1A1A1A),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              _buildTextField(
                icon: Icons.person,
                controller: _userName,
                validation: _validateuserName,
                hintText: 'User name',
                keyboardType: TextInputType.text,
              ),
              _buildTextField(
                icon: Icons.phone_android_outlined,
                controller: _phoneNumber,
                validation: _validatephoneNumber,
                hintText: 'Phone number',
                keyboardType: TextInputType.phone,
                pattern: r'[0-9]',
              ),
              _buildTextField(
                icon: Icons.male,
                controller: _gender,
                validation: _validategender,
                hintText: 'Gender',
                keyboardType: TextInputType.text,
              ),
              _buildDateField('Date of birth', _dob, context),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      icon: Icons.cake,
                      controller: _age,
                      validation: _validateage,
                      hintText: 'Age',
                      keyboardType: TextInputType.number,
                      pattern: r'[0-9]',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      icon: Icons.bloodtype_outlined,
                      controller: _bloodGroup,
                      validation: _validatebloodGroop,
                      hintText: 'Blood Group',
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
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
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child:
                    Text(
                      "Calendar",
                      style: TextStyle(
                          color: Color(0xff27BDBE),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _dates.length,
                  itemBuilder: (context, index) {
                    final date = _dates[index];
                    final isSelected = index == 0; // Example: second date selected
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xff27BDBE) : Color(0xffD3D3D3),
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
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
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

                  Spacer(),
                  InkWell(
                    onTap: () {
                    },
                    child:
                    Text(
                      "Set Time",
                      style: TextStyle(
                          color: Color(0xff27BDBE),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,

                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: generateHourlyTimeSlots().length,
                  itemBuilder: (context, index) {
                    final time = generateHourlyTimeSlots()[index];
                    final isCurrentHour = time == DateFormat('HH:00').format(DateTime.now());
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isCurrentHour ? Color(0xff27BDBE) : Color(0xffD3D3D3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          time,
                          style: TextStyle(
                            color: isCurrentHour ? Colors.white : Color(0xff4B4B4B),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              InkWell(onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Apointments()));
              },
                child: Container(
                  margin: EdgeInsets.only(top: 40,bottom: 20),
                  width: w,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF00C4D3),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
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
        ),
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required TextEditingController controller,
    required validation,
    required String hintText,
    required TextInputType keyboardType,
    String? pattern,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 4),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2), // Changes position of shadow
            ),
          ],
        ),

        child: Material(
          elevation: 0,

          borderRadius: BorderRadius.circular(30),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            keyboardType: keyboardType,
            inputFormatters: pattern != null
                ? [FilteringTextInputFormatter.allow(RegExp(pattern))]
                : [],
            decoration: InputDecoration(
                prefixIcon: Icon(icon, color: Color(0xffAFAFAF)),
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: Color(0xffAFAFAF),
                ),
                // filled: true,
                // fillColor: Color(0xffffffff),
                border: InputBorder.none
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(50),
              //   borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(15.0),
              //   borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
              // ),
            ),
          ),
        ),
      ),
      if (validation.isNotEmpty) ...[
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
          width: MediaQuery.of(context).size.width * 0.6,
          child: ShakeWidget(
            key: Key("value"),
            duration: Duration(milliseconds: 700),
            child: Text(
              validation,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ] else ...[
        SizedBox(height: 20),
      ]
    ]);
  }

  Widget _buildDateField(
      String hintText, TextEditingController controller, BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: _buildTextField(
          icon: Icons.calendar_today,
          controller: controller,
          validation: _validatedob,
          hintText: hintText,
          keyboardType: TextInputType.datetime,
        ),
      ),
    );
  }
}