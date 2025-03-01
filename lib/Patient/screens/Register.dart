import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:revxpharma/Authentication/LogInWithEmail.dart';
import 'package:revxpharma/Components/CustomSnackBar.dart';
import 'package:revxpharma/Patient/logic/cubit/patient_register/patient_register_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/patient_register/patient_register_state.dart';
import 'package:revxpharma/Services/UserapiServices.dart';

import '../../Components/ShakeWidget.dart';
import 'Dashboard.dart';
import '../../Authentication/LogInWithMobile.dart';

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
  bool _loading = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        _dob.text = DateFormat('yyyy-MM-dd').format(pickedDate);
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
      _loading = true;
      _validateuserName =
      _userName.text.isEmpty ? 'Please enter a fullName' : '';
      _validatephoneNumber =
      _phoneNumber.text.isEmpty ? 'Please enter a phone number' : '';
      _validateEmail =
      !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
          .hasMatch(_email.text)
          ? 'Please enter a valid email'
          : '';
      _validatepwd = _password.text.isEmpty
          ? 'Please enter a password'
          : _password.text.length < 8
          ? 'Password must be at least 8 characters long':"";
      _validategender = _gender.text.isEmpty ? 'Please enter a gender' : '';
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
          "gender": _gender.text,
          "date_of_birth": _dob.text,
          "age": _age.text,
          "blood_group": _bloodGroup.text,
        };
        context.read<PatientRegisterCubit>().postRegister(data);
      } else {
        _loading = false;
      }
    });
  }

  void PatientRegisterApi() async {
    Response response = await UserApi.registerPatient(
        _userName.text,
        _phoneNumber.text,
        _email.text,
        _password.text,
        _gender.text,
        _dob.text,
        _age.text,
        _bloodGroup.text);
    try {
      setState(() {
        if (response.data['settings']['success'] == 1) {
          _loading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LogInWithEmail()));
        } else {
          _loading = false;
          CustomSnackBar.show(context, (response.data['settings']['message']));
        }
      });
    } catch (e) {
      print('failure');
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
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LogInWithEmail()));
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
                CircleAvatar(
                  radius: 40,
                  backgroundImage:
                  AssetImage('assets/blueLogo.png'), // Add your image here
                ),
                SizedBox(height: 20),
                Text(
                  'Register with RevX',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Please fill the details to create an account',
                  style: TextStyle(
                    fontSize: 14,
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
                  hintText: 'Phone number',
                  keyboardType: TextInputType.phone,
                  pattern: r'[0-9]',
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
                        icon: Icons.bloodtype,
                        controller: _bloodGroup,
                        validation: _validatebloodGroop,
                        hintText: 'Blood Group',
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: state is PatientRegisterLoading ? null : _validateFields,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xff27BDBE),
                      foregroundColor:const Color(0xff27BDBE),
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
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?'),
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
                          color:Color(0xFF27BDBE),
                          fontWeight: FontWeight.bold,
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
          decoration: InputDecoration(
            hintText: "$hintText",
            hintStyle: TextStyle(
              fontSize: 15,
              letterSpacing: 0,
              height: 1.2,
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
        SizedBox(height: 15),
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
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 4),
      TextFormField(
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
          margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
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
