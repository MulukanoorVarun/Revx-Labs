import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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

  TextEditingController _password = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _age = TextEditingController();

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

  void validateFeilds() {
    setState(() {
      _validateEmail =
          !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                  .hasMatch(email.text)
              ? 'Please enter a valid email'
              : '';
      _validateFullname =
          fullname.text.isEmpty ? 'Please enter a full name' : '';
      _validatePhone = phone.text.isEmpty ? 'Please enter a mobile Number' : '';
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
      _validategender = selectedGender == null || selectedGender == ""
          ? 'Please Select Gender'
          : "";
      _validatebloodGroop =
          selectedBloodGroup == null || selectedBloodGroup == ""
              ? 'Please Select Blood Group'
              : "";
      _validatedob = _dob.text.isEmpty ? 'Please select a dob' : '';
      _validateage = _age.text.isEmpty ? 'Please enter a age' : '';
    });

    if (_validateEmail.isEmpty &&
        _validateFullname.isEmpty &&
        _validatepwd.isEmpty &&
        _validategender.isEmpty &&
        _validatedob.isEmpty &&
        _validateage.isEmpty &&
        _validatePhone.isEmpty) {
      final Map<String, dynamic> data = {
        'full_name': fullname.text,
        'email': email.text,
        'mobile': phone.text,
        'image': _image?.path,
        "password": _password.text,
        "gender": selectedGender,
        "date_of_birth": _dob.text,
        "age": _age.text,
        "blood_group": selectedBloodGroup,
      };
      print('profile data:${data}');
      context.read<ProfileCubit>().updateProfileDetails(data);
    }
  }

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
      appBar: CustomAppBar(title: "Edit Profile", actions: []),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 20),
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileStateSuccess) {
                } else if (state is ProfileStateLoaded) {
                  fullname.text = state.profileDetailModel.data?.fullName ?? '';
                  email.text = state.profileDetailModel.data?.email ?? '';
                  phone.text = state.profileDetailModel.data?.mobile ?? '';
                  selectedGender = state.profileDetailModel.data?.gender ?? '';
                  _dob.text = state.profileDetailModel.data?.dateOfBirth ?? '';
                  _age.text =
                      state.profileDetailModel.data?.age.toString() ?? "";
                  selectedBloodGroup =
                      state.profileDetailModel.data?.bloodGroup;
                  // _password.text = state.profileDetailModel.data?. ?? '';
                }
              },
              builder: (context, state) {
                if (state is ProfileStateLoaded) {
                  String profile_image =
                      state.profileDetailModel.data?.image ?? '';
                  String full_name =
                      state.profileDetailModel.data?.fullName ?? '';
                  return Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.5),
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
                        _buildTextField(
                          icon: Icons.person,
                          controller: fullname,
                          validation: _validateFullname,
                          hintText: 'User name',
                          keyboardType: TextInputType.text,
                        ),
                        _buildTextField(
                            icon: Icons.phone,
                            controller: phone,
                            validation: _validatePhone,
                            hintText: 'Phone number',
                            pattern: r'[0-9]',
                            keyboardType: TextInputType.phone,
                            length: 10),
                        _buildTextField(
                          icon: Icons.email_outlined,
                          controller: email,
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
                                      _getGenderIcon(
                                          item), // Function to get icon based on gender
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                        width:
                                            10), // Spacing between icon and text
                                    Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "Poppins"),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: const Color(0xffCDE2FB)),
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
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 14),
                            ),
                          ),
                        ),
                        if (_validategender.isNotEmpty) ...[
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
                        ] else ...[
                          SizedBox(
                            height: 15,
                          ),
                        ],
                        _buildDateField('Date of birth', _dob, context),
                        _buildTextField(
                            icon: Icons.cake,
                            controller: _age,
                            validation: _validateage,
                            hintText: 'Age',
                            keyboardType: TextInputType.number,
                            pattern: r'[0-9]',
                            readonly: true),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            items: bloodGroupOptions.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons
                                          .bloodtype_outlined, // Function to get icon based on gender
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    const SizedBox(
                                        width:
                                            10), // Spacing between icon and text
                                    Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "Poppins"),
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
                                  Icons
                                      .bloodtype_outlined, // Static male icon in hint
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border:
                                    Border.all(color: const Color(0xffCDE2FB)),
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
                                thumbVisibility:
                                    MaterialStateProperty.all(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.symmetric(horizontal: 14),
                            ),
                          ),
                        ),
                        if (_validatebloodGroop.isNotEmpty) ...[
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
                        ] else ...[
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ],
                    ),
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
          style: TextStyle(
            fontSize: 15,
            fontFamily: "Poppins",
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.date_range_outlined, color: Color(0xffAFAFAF)),
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
        if (_validatedob != "") ...[
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
        ] else ...[
          SizedBox(
            height: 15,
          ),
        ],
      ],
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
  Widget _buildTextField(
      {required IconData icon,
      required TextEditingController controller,
      required validation,
      required String hintText,
      required TextInputType keyboardType,
      String? pattern,
      bool? readonly,
      int? length}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 4),
      TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        keyboardType: keyboardType,
        readOnly: readonly ?? false,
        inputFormatters: pattern != null
            ? [
                FilteringTextInputFormatter.allow(RegExp(pattern)),
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
          margin: EdgeInsets.only(bottom: 10, top: 5),
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
