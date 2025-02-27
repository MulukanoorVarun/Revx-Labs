import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_state.dart';

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
  final Color backgroundCursorColor =     Color(0xff27BDBE);

  File? _image;
  XFile? _pickedFile;

  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Use ImageSource.camera for camera
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

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset:
      true, // Ensure body content is scrollable when keyboard appears
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
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
      body: SingleChildScrollView(
        // Wrap the entire body in SingleChildScrollView
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileStateLoading) {
                return Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff27BDBE),
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
                                child: (_image == null &&
                                    profile_image.isEmpty)
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
                                      color: Color(0xff27BDBE),
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
                    _buildTextField(
                        label: "Full Name",
                        controller: fullname..text = fullName,
                        focusNode: focusfullname,
                        cursorColor: cursorColor,
                        backgroundCursorColor: backgroundCursorColor,
                        regex: r'^[a-zA-Z\s]+$',
                        hint: "enter full name"),
                    _buildTextField(
                        label: "Email",
                        controller: email..text = emailValue,
                        focusNode: focusemail,
                        cursorColor: cursorColor,
                        backgroundCursorColor: backgroundCursorColor,
                        regex:
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        keyboardType: TextInputType.emailAddress,
                        hint: "enter email "),
                    _buildTextField(
                        label: "Phone Number",
                        controller: phone..text = phoneValue,
                        focusNode: focusphone,
                        cursorColor: cursorColor,
                        backgroundCursorColor: backgroundCursorColor,
                        regex: r'^\d{10}$',
                        keyboardType: TextInputType.phone,
                        hint: "enter mobile number"),
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
        TextField(readOnly: true,
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
