import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:revxpharma/Authentication/LogInWithEmail.dart';
import 'package:revxpharma/Components/CustomSnackBar.dart';
import 'package:revxpharma/Patient/logic/cubit/patient_register/patient_register_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/patient_register/patient_register_state.dart';
import 'package:revxpharma/Utils/color.dart';
import '../../Components/ShakeWidget.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _bloodGroup = TextEditingController();

  String _validateuserName = "";
  String _validatephoneNumber = "";
  String _validateEmail = "";
  String _validatepwd = "";
  String _validategender = "";
  String _validatedob = "";
  String _validateage = "";
  String _validatebloodGroop = "";

  String? selectedGender;
  List<String> genderOptions = ["Male", "Female"];

  String? selectedBloodGroup;
  List<String> bloodGroupOptions = [
    "A+ve",
    "A-ve",
    "B+ve",
    "B-ve",
    "O+ve",
    "O-ve",
    "AB+ve",
    "AB-ve"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dob.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        _age.text = _calculateAge(pickedDate).toString();
      });
    }
  }

  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--; // Adjust age if birthday hasn't occurred yet this year
    }
    return age;
  }

  @override
  void initState() {
    _userName.addListener(() {
      setState(() {
        _validateuserName = "";
      });
    });
    _phoneNumber.addListener(() {
      setState(() {
        _validatephoneNumber = '';
      });
    });
    _password.addListener(() {
      setState(() {
        _validatepwd = '';
      });
    });
    _email.addListener(() {
      setState(() {
        _validateEmail = '';
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

  void _validateFields() {
    setState(() {
      _validateuserName =
      _userName.text.isEmpty ? 'Please enter a fullName' : '';
      _validatephoneNumber =
      _phoneNumber.text.isEmpty ||  _phoneNumber.text.length<10 ? 'Please enter a valid phone number' : '';
      _validateEmail = !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
          .hasMatch(_email.text)
          ? 'Please enter a valid email'
          : '';
      _validatepwd = _password.text.isEmpty
          ? 'Please enter a password'
          : _password.text.length < 8
          ? 'Password must be at least 8 characters long'
          : !RegExp(r'^(?=.*[a-z])').hasMatch(_password.text)
          ? 'Password must contain at least one lowercase letter'
          : !RegExp(r'^(?=.*[A-Z])').hasMatch(_password.text)
          ? 'Password must contain at least one uppercase letter'
          : !RegExp(r'^(?=.*[0-9])').hasMatch(_password.text)
          ? 'Password must contain at least one number'
          : !RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])')
          .hasMatch(_password.text)
          ? 'Password must contain at least one special character'
          : '';
      _validategender = selectedGender==null || selectedGender=="" ? 'Please Select Gender' : "";
      _validatebloodGroop = selectedBloodGroup==null || selectedBloodGroup=="" ? 'Please Select Blood Group' : "";
      _validatedob = _dob.text.isEmpty ? 'Please select a dob' : '';
      _validateage = _age.text.isEmpty ? 'Please enter a age' : '';
      if (_validateuserName.isEmpty &&
          _validatephoneNumber.isEmpty &&
          _validateEmail.isEmpty &&
          _validatepwd.isEmpty &&
          _validategender.isEmpty &&
          _validatedob.isEmpty &&
          _validateage.isEmpty) {
        Map<String,dynamic> data={
          "full_name": _userName.text,
          "email": _email.text,
          "password": _password.text,
          "mobile": _phoneNumber.text,
          "gender": selectedGender,
          "date_of_birth": _dob.text,
          "age": _age.text,
          "blood_group": selectedBloodGroup,
        };
        print("Register Data:${data}");
        context.read<PatientRegisterCubit>().postRegister(data);
      }
    });
  }

  // Function to get gender icon based on the selected option
  IconData _getGenderIcon(String gender) {
    switch (gender) {
      case "Male":
        return Icons.male;
      case "Female":
        return Icons.female;
      case "Others":
        return Icons.transgender;
      default:
        return Icons.person_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  BlocConsumer<PatientRegisterCubit, PatientRegisterState>(listener: (context, state) {
        if (state is PatientRegisterSuccessState) {
          if (state.successModel.settings?.success == 1) {
            CustomSnackBar.show(context, state.message ?? '');
            context.push('/login');
          } else {
            CustomSnackBar.show(context, state.message ?? '');
          }
        } else if (state is PatientRegisterError) {
          CustomSnackBar.show(context, state.message ?? '');
        }
      },
          builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(backgroundColor:whiteColor,
                  radius: 46,
                  backgroundImage:
                  AssetImage('assets/REVX_LOGO.png'),
                ),
                SizedBox(height: 20),
                Text(
                  'Register with RevX',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Please fill the details to create an account',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "poppins",
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 30),
                _buildTextField(
                  icon: Icons.person,
                  controller: _userName,
                  validation: _validateuserName,
                  hintText: 'User name',
                  keyboardType: TextInputType.text,
                ),
                _buildTextField(
                  icon: Icons.phone,
                  controller: _phoneNumber,
                  validation: _validatephoneNumber,
                  hintText: 'Phone number', pattern: r'[0-9]',
                  keyboardType: TextInputType.phone,
                  length: 10
                ),
                _buildTextField(
                  icon: Icons.email_outlined,
                  controller: _email,
                  validation: _validateEmail,
                  hintText: 'Email',
                  keyboardType: TextInputType.text,
                ),
                _buildTextField(
                  icon: Icons.lock_outline,
                  controller: _password,
                  validation: _validatepwd,
                  hintText: 'Password',
                  keyboardType: TextInputType.text,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    items: genderOptions.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Row(
                          children: [
                            Icon(
                              _getGenderIcon(item), // Function to get icon based on gender
                              color: Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 10), // Spacing between icon and text
                            Text(
                              item,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: "Poppins"
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    value: selectedGender, // Initially null
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                        print("Selected Gender: $selectedGender");
                      });
                    },
                    hint: Row(
                      children: [
                        const Icon(
                          Icons.male, // Static male icon in hint
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Select Gender",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xffCDE2FB)),
                        color: Colors.white,
                      ),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_drop_down, size: 25),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.black,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                    ),
                  ),
                ),
                if(_validategender.isNotEmpty)...[
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(bottom: 10),
                    child: ShakeWidget(
                      key: Key("gender"),
                      duration: const Duration(milliseconds: 700),
                      child: Text(
                        _validategender,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ]else...[
                  SizedBox(height: 15,),
                ],
                _buildDateField('Date of birth', _dob, context),
                _buildTextField(
                  icon: Icons.cake,
                  controller: _age,
                  validation: _validateage,
                  hintText: 'Age',
                  keyboardType: TextInputType.number,
                  pattern: r'[0-9]',
                  readonly: true
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    items: bloodGroupOptions.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Row(
                          children: [
                            Icon(
                             Icons.bloodtype_outlined, // Function to get icon based on gender
                              color: Colors.grey,
                              size: 20,
                            ),
                            const SizedBox(width: 10), // Spacing between icon and text
                            Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  fontFamily: "Poppins"
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    value: selectedBloodGroup, // Initially null
                    onChanged: (value) {
                      setState(() {
                        selectedBloodGroup = value;
                        print("Selected Gender: $selectedBloodGroup");
                      });
                    },
                    hint: Row(
                      children: [
                        const Icon(
                          Icons.bloodtype_outlined, // Static male icon in hint
                          color: Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Select Blood Group",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: const Color(0xffCDE2FB)),
                        color: Colors.white,
                      ),
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(Icons.arrow_drop_down, size: 25),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.black,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(6),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                    ),
                  ),
                ),
                if(_validatebloodGroop.isNotEmpty)...[
                  Container(
                    alignment: Alignment.topLeft,
                    child: ShakeWidget(
                      key: Key("bloodgroup"),
                      duration: const Duration(milliseconds: 700),
                      child: Text(
                        _validatebloodGroop,
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ]else...[
                  SizedBox(height: 15,),
                ],
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: state is PatientRegisterLoading ? null : _validateFields,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor:primaryColor,
                      disabledBackgroundColor:  primaryColor, // Same color when disabled
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Rounded corners
                      ), // Padding
                    ),
                    child: state is PatientRegisterLoading
                        ? CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 1,
                    )
                        : Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),),
                    SizedBox(width: 6,),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInWithEmail()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color:primaryColor,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDateField(
      String hintText, TextEditingController controller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          readOnly: true,
          onTap: () => _selectDate(context),
          style:TextStyle(
            fontSize: 15,
            fontFamily: "Poppins",
            color: Colors.black                                              ,
            fontWeight: FontWeight.w400,
          ) ,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.date_range_outlined, color: Color(0xffAFAFAF)),
            hintText: "$hintText",
            hintStyle: TextStyle(
              fontSize: 15,
              fontFamily: "Poppins",
              color: Color(0xffAFAFAF),
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: Color(0xffffffff),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
          ),
        ),
        if(_validatedob!="")...[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(bottom: 10),
            child: ShakeWidget(
              key: Key("dob"),
              duration: const Duration(milliseconds: 700),
              child: Text(
                _validatedob,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ]else...[
          SizedBox(height: 15,),
        ],
      ],
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required TextEditingController controller,
    required validation,
    required String hintText,
    required TextInputType keyboardType,
    String? pattern,
    bool? readonly,
    int? length
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 4),
      TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        keyboardType: keyboardType,
        readOnly: readonly??false,
        inputFormatters: pattern != null
            ? [FilteringTextInputFormatter.allow(RegExp(pattern)),
          LengthLimitingTextInputFormatter(length)
        ]
            : [],
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Color(0xffAFAFAF)),
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
            color: Color(0xffAFAFAF),
          ),
          filled: true,
          fillColor: Color(0xffffffff),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(width: 1, color: Color(0xffCDE2FB)),
          ),
        ),
      ),
      if (validation.isNotEmpty) ...[
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only( bottom: 10, top: 5),
          width: MediaQuery.of(context).size.width,
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
        SizedBox(height: 15),
      ],
    ]);
  }
}
