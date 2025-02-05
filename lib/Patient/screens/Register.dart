import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../Components/ShakeWidget.dart';
import 'Dashboard.dart';
import 'LogInScreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _bloodGroup = TextEditingController();

  String _validateuserName="";
  String _validatephoneNumber="";
  String _validategender="";
  String _validatedob="";
  String _validateage="";
  String _validatebloodGroop="";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dob.text = DateFormat('yyyy/MM/dd').format(pickedDate);
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
        _validatebloodGroop= "";
      });
    });



    super.initState();
  }

  void _validFeilds(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage('assets/blueLogo.png'), // Add your image here
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
              InkWell(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
              },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF00C4D3),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Text(
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
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(String hintText, TextEditingController controller, BuildContext context) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          SizedBox(height: 15),

      ],]
    );

  }
}
