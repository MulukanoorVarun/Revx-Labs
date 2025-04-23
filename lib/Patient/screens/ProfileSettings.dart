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

  void validateFeilds() {
    setState(() {
      _validateEmail =
      !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
          .hasMatch(email.text)
          ? 'Please enter a valid email'
          : '';
      _validateFullname = fullname.text.isEmpty ? 'Please enter a full name' : '';
      _validatePhone = phone.text.isEmpty ? 'Please enter a mobile Number' : '';
    });
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
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if(state is ProfileStateSuccess){

                } else if (state is ProfileStateLoaded) {
                  fullname.text = state.profileDetailModel.data?.fullName ?? '';
                  email.text = state.profileDetailModel.data?.email ?? '';
                  phone.text = state.profileDetailModel.data?.mobile ?? '';
                }
              },
              builder: (context, state) {
                if (state is ProfileStateLoading) {
                  return Center(
                    child: CircularProgressIndicator(color: primaryColor),
                  );
                } else if (state is ProfileStateLoaded) {
                  String profile_image =
                      state.profileDetailModel.data?.image ?? '';
                  String full_name =
                      state.profileDetailModel.data?.fullName ?? '';
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
                                  child:
                                      (_image == null && profile_image.isEmpty)
                                          ? Text(
                                              full_name.isNotEmpty
                                                  ? full_name[0].toUpperCase()
                                                  : '',
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: Colors.white),
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
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                      /// Full Name
                      _buildLabel("Full Name"),
                      _buildInputField(
                        controller: fullname,
                        icon: Icons.person,
                        hint: 'Enter full name',
                        onTap: () => setState(() => _validateFullname = ''),
                      ),
                      _buildError(_validateFullname),

                      /// Email
                      _buildLabel("Email"),
                      _buildInputField(
                        controller: email,
                        icon: Icons.mail_outline,
                        hint: 'Enter your Email',
                        onTap: () => setState(() => _validateEmail = ''),
                      ),
                      _buildError(_validateEmail),
                      _buildLabel("Phone Number"),
                      _buildInputField(
                        controller: phone,
                        icon: Icons.phone,
                        hint: 'Enter Mobile Number',
                        keyboardType: TextInputType.phone,
                        onTap: () => setState(() => _validatePhone = ''),
                      ),
                      _buildError(_validatePhone),
                    ],
                  );
                }

                return Center(child: Text("No Data"));
              },
            )),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: CustomAppButton(
            text: 'Change settings',
            onPlusTap: () {
              validateFeilds();
            }),
      ),
    );
  }

  Widget _buildLabel(String text) => Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w300,
          color: Color(0xff868686),
        ),
      );

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    required VoidCallback onTap,
  }) =>
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
          elevation: 0,
          borderRadius: BorderRadius.circular(30.0),
          child: TextField(
            onTap: onTap,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Color(0xff808080)),
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              border: InputBorder.none,
            ),
          ),
        ),
      );

  Widget _buildError(String errorText) => errorText.isNotEmpty
      ? Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(left: 8, bottom: 10, top: 5),
          child: ShakeWidget(
            key: Key("value"),
            duration: Duration(milliseconds: 700),
            child: Text(
              errorText,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        )
      : SizedBox(height: 15);

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
