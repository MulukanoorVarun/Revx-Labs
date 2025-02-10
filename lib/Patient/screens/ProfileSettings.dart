import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Authentication/ChangePassword.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  FocusNode focusfullname = FocusNode();
  FocusNode focusemail = FocusNode();
  FocusNode focusphone = FocusNode();
  FocusNode focuspassword = FocusNode();

  final Color cursorColor = Colors.blue;
  final Color backgroundCursorColor = Colors.grey[200]!;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: (){
          Navigator.pop(context);
        },
            child: Icon(Icons.arrow_back_ios_new)),
        title: Center(
          child: Text(
            "Profile Settings",
            style: TextStyle(
                color: Color(0xff27BDBE),
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          Icon(
            Icons.more_vert,
            size: 24,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 16, right: 16, bottom: 20),
              child: ListView(
                children: [
                  _buildTextField(
                      label: "Full Name",
                      controller: fullname,
                      focusNode: focusfullname,
                      cursorColor: cursorColor,
                      backgroundCursorColor: backgroundCursorColor,
                      regex: r'^[a-zA-Z\s]+$',
                      hint: "enter full name"),
                  _buildTextField(
                      label: "Email",
                      controller: email,
                      focusNode: focusemail,
                      cursorColor: cursorColor,
                      backgroundCursorColor: backgroundCursorColor,
                      regex:
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      keyboardType: TextInputType.emailAddress,
                      hint: "enter email "),
                  _buildTextField(
                      label: "Phone Number",
                      controller: phone,
                      focusNode: focusphone,
                      cursorColor: cursorColor,
                      backgroundCursorColor: backgroundCursorColor,
                      regex: r'^\d{10}$',
                      keyboardType: TextInputType.phone,
                      hint: "enter mobile number"),
                  _buildTextField(
                    label: "Password",
                    controller: password,
                    focusNode: focuspassword,
                    cursorColor: cursorColor,
                    backgroundCursorColor: backgroundCursorColor,
                    regex: r'.*',
                    hint: "enter your password",
                    obscureText: true,
                    suffixIcon: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));

                      },
                      child: Text(
                        'Change',
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            width: w,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xFF00C4D3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'CHANGE SETTINGS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required Color cursorColor,
    required Color backgroundCursorColor,
    required String regex,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xff868686)),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          focusNode: focusNode,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xff010F07),
          ),
          cursorColor: cursorColor,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hint,
            hintStyle: TextStyle(color: Color(0xff868686)),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffF3F2F2), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: cursorColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffF3F2F2), width: 1),
            ),
          ),
          keyboardType: keyboardType,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(regex)),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    fullname.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    focusfullname.dispose();
    focusemail.dispose();
    focusphone.dispose();
    focuspassword.dispose();
    super.dispose();
  }
}
