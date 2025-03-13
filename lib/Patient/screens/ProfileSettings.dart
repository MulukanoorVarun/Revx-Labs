import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revxpharma/Components/CustomAppButton.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/ShakeWidget.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_state.dart';
import 'package:revxpharma/Utils/color.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();


  FocusNode focusfullname = FocusNode();
  FocusNode focusemail = FocusNode();
  FocusNode focusphone = FocusNode();

  final Color cursorColor = Colors.blue;
  final Color backgroundCursorColor = primaryColor;

  File? _image;
  XFile? _pickedFile;

  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Set the selected image file
        print("Image: ${_image?.path}"); // Print the image path for debugging
      });
    } else {
      print("No image selected.");
    }
  }

  @override
  void initState() {
    context.read<ProfileCubit>().getProfileDetails();
    super.initState();
  }

  String _validateEmail = '';
  String _validateFullname = '';
  String _validatePhone = '';

  void validateFeilds(){
    _validateEmail =
    !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(email.text)
        ? 'Please enter a valid email'
        : '';
    _validateFullname=fullname.text.isEmpty?'Please enter a full name':'' ;
    _validatePhone=phone.text.isEmpty?'Please enter a mobile Number':'' ;
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile", actions: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileStateLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                ));
              } else if (state is ProfileStateLoaded) {
                String profile_image =
                    state.profileDetailModel.data?.image ?? '';
                String fullName = state.profileDetailModel.data?.fullName ?? '';
                String emailValue = state.profileDetailModel.data?.email ?? '';
                String phoneValue = state.profileDetailModel.data?.mobile ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey.withOpacity(0.5),
                                backgroundImage: _image != null
                                    ? FileImage(_image!)
                                        as ImageProvider<Object>
                                    : (profile_image.isNotEmpty)
                                        ? NetworkImage(profile_image)
                                            as ImageProvider<Object>
                                        : AssetImage('assets/person.png')
                                            as ImageProvider<Object>,
                                child: (_image == null && profile_image.isEmpty)
                                    ? Text(
                                        fullName.isNotEmpty
                                            ? fullName[0].toUpperCase()
                                            : '',
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      )
                                    : null,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: InkWell(
                                  onTap: _pickImage,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: primaryColor,
                                      size: 15, // Size of the camera icon
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Full Name",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: Color(0xff868686)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Material(
                        elevation: 0, // Set elevation to 0 when using BoxShadow
                        borderRadius: BorderRadius.circular(30.0),
                        child: TextField(
                          onTap: () {
                            setState(() {
                              _validateFullname = '';
                            });
                          },
                          controller: fullname..text,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.person, color: Color(0xff808080)),
                            hintText: 'enter full name',
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            border:
                                InputBorder.none, // Removes the default border
                          ),
                        ),
                      ),
                    ),
                    if (_validateFullname.isNotEmpty) ...[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                        width: MediaQuery.of(context).size.width,
                        child: ShakeWidget(
                          key: Key("value"),
                          duration: Duration(milliseconds: 700),
                          child: Text(
                            _validateFullname,
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
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: Color(0xff868686)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Material(
                        elevation: 0, // Set elevation to 0 when using BoxShadow
                        borderRadius: BorderRadius.circular(30.0),
                        child: TextField(
                          onTap: () {
                            setState(() {
                              _validateEmail = '';
                            });
                          },
                          controller: email,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail_outline,
                                color: Color(0xff808080)),
                            hintText: 'email',
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            border:
                                InputBorder.none, // Removes the default border
                          ),
                        ),
                      ),
                    ),
                    if (_validateEmail.isNotEmpty) ...[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                        width: MediaQuery.of(context).size.width,
                        child: ShakeWidget(
                          key: Key("value"),
                          duration: Duration(milliseconds: 700),
                          child: Text(
                            _validateEmail,
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
                    Text(
                      "Phone Number",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w300,
                          color: Color(0xff868686)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 0.5,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Material(
                        elevation: 0, // Set elevation to 0 when using BoxShadow
                        borderRadius: BorderRadius.circular(30.0),
                        child: TextField(
                          onTap: () {
                            setState(() {
                              _validatePhone = '';
                            });
                          },
                          controller: phone..text,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.phone, color: Color(0xff808080)),
                            hintText: "enter mobile number",
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            border:
                                InputBorder.none, // Removes the default border
                          ),
                        ),
                      ),
                    ),
                    if (_validatePhone.isNotEmpty) ...[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
                        width: MediaQuery.of(context).size.width,
                        child: ShakeWidget(
                          key: Key("value"),
                          duration: Duration(milliseconds: 700),
                          child: Text(
                            _validatePhone,
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
                  ],
                );
              } else if (state is ProfileStateError) {
                return Center(child: Text(state.message));
              }
              return Center(child: Text("No Data"));
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: CustomAppButton(text: 'Change settings', onPlusTap: () {

          validateFeilds();


        }),
      ),
    );
  }

  @override
  void dispose() {
    fullname.dispose();
    email.dispose();
    phone.dispose();
    focusfullname.dispose();
    focusemail.dispose();
    focusphone.dispose();

    super.dispose();
  }
}
