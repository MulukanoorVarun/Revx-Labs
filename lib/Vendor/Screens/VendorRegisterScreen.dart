import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:revxpharma/Authentication/LogInWithEmail.dart';
import '../../Components/ShakeWidget.dart';

class VendorRegisterScreen extends StatefulWidget {
  const VendorRegisterScreen({Key? key}) : super(key: key);

  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final TextEditingController labNameController = TextEditingController();
  final TextEditingController labAddressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController testsController = TextEditingController();
  final TextEditingController licenseNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Map<String, String> validationErrors = {};

  @override
  void dispose() {
    labNameController.dispose();
    labAddressController.dispose();
    contactNumberController.dispose();
    emailAddressController.dispose();
    passwordController.dispose();
    categoryController.dispose();
    testsController.dispose();
    licenseNumberController.dispose();
    super.dispose();
  }

  String? _validateField(String value, String fieldName) {
    if (value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  String? _validateEmail(String value) {
    if (value.trim().isEmpty) {
      return "Email is required";
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.trim().isEmpty) {
      return "Password is required";
    }
    final emailRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters long, contain at least one lowercase letter, one uppercase letter, one number, and one special character';
    }
    return null;
  }

  String? _validatePhone(String value) {
    if (value.trim().isEmpty) {
      return "Phone number is required";
    }
    final phoneRegex = RegExp(r'^[0-9]{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return "Enter a valid 10-digit phone number";
    }
    return null;
  }

  String? _validatestartTime(String value) {
    if (value.trim().isEmpty) {
      return "Start Time is required";
    }

    // Regex to check the time format (HH:mm)
    final timeRegex = RegExp(r'^(?:[01]\d|2[0-3]):(?:[0-5]\d)$');
    if (!timeRegex.hasMatch(value)) {
      return "Enter a valid time in HH:mm format";
    }

    return null;
  }

  String? _validateEndTime(String value) {
    if (value.trim().isEmpty) {
      return "End Time is required";
    }

    // Regex to check the time format (HH:mm)
    final timeRegex = RegExp(r'^(?:[01]\d|2[0-3]):(?:[0-5]\d)$');
    if (!timeRegex.hasMatch(value)) {
      return "Enter a valid time in HH:mm format";
    }

    return null;
  }

  void _validateAndSetError(
      String fieldKey, String value, String? Function(String) validator) {
    setState(() {
      final errorMessage = validator(value);
      if (errorMessage != null) {
        validationErrors[fieldKey] = errorMessage;
      } else {
        validationErrors.remove(fieldKey);
      }
    });
  }

  void _submitForm() {
    setState(() {
      _validateAndSetError("labName", labNameController.text,
          (value) => _validateField(value, "Lab Name"));
      _validateAndSetError("labAddress", labAddressController.text,
          (value) => _validateField(value, "Address"));
      _validateAndSetError(
          "contactNumber", contactNumberController.text, _validatePhone);
      _validateAndSetError(
          "email", emailAddressController.text, _validateEmail);
      _validateAndSetError(
          "password", passwordController.text, _validatePassword);
      _validateAndSetError("category", categoryController.text,
          (value) => _validateField(value, "Categories"));
      _validateAndSetError("tests", testsController.text,
          (value) => _validateField(value, "Services"));
      _validateAndSetError("licenseNumber", licenseNumberController.text,
          (value) => _validateField(value, "License Number"));
    });

    if (validationErrors.isEmpty) {
      print("Form is valid, submitting...");
      // Submit form logic here
    } else {
      print("Form has errors");
    }
  }

  MultiSelectController<WeekDays> _dayscontroller =
      MultiSelectController<WeekDays>();
  String _validateWeekdays = '';
  List<String> selectedDays = [];
  @override
  Widget build(BuildContext context) {
    var items = [
      DropdownItem(label: 'Monday', value: WeekDays(name: 'Monday')),
      DropdownItem(label: 'Tuesday', value: WeekDays(name: 'Tuesday')),
      DropdownItem(label: 'Wednesday', value: WeekDays(name: 'Wednesday')),
      DropdownItem(label: 'Thursday', value: WeekDays(name: 'Thursday')),
      DropdownItem(label: 'Friday', value: WeekDays(name: 'Friday')),
      DropdownItem(label: 'Saturday', value: WeekDays(name: 'Saturday')),
      DropdownItem(label: 'Sunday', value: WeekDays(name: 'Sunday')),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Please fill the details to create an account',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Poppins",
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 30),
              buildFormLabel("Enter the diagnostics name"),
              _buildTextField(
                fieldKey: "labName",
                controller: labNameController,
                hintText: 'Name of the diagnostics',
                keyboardType: TextInputType.text,
                validator: (value) => _validateField(value, "Lab Name"),
              ),
              buildFormLabel("Enter the complete address"),
              _buildTextField(
                fieldKey: "labAddress",
                controller: labAddressController,
                hintText: 'Address',
                keyboardType: TextInputType.text,
                validator: (value) => _validateField(value, "Address"),
              ),
              buildFormLabel("Enter the contact number"),
              _buildTextField(
                fieldKey: "contactNumber",
                controller: contactNumberController,
                hintText: 'Contact Number',
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
              ),
              buildFormLabel("Email address"),
              _buildTextField(
                fieldKey: "email",
                controller: emailAddressController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              buildFormLabel("Enter The Password"),
              _buildTextField(
                fieldKey: "Password",
                controller: passwordController,
                hintText: 'Password',
                keyboardType: TextInputType.text,
                validator: _validatePassword,
              ),
              buildFormLabel("Days Opened"),
              MultiDropdown<WeekDays>(
                items: items,
                controller: _dayscontroller,
                enabled: true,
                searchEnabled: true,
                chipDecoration: const ChipDecoration(
                    backgroundColor: Color(0xffE8E4EF),
                    wrap: true,
                    runSpacing: 2,
                    spacing: 10,
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                fieldDecoration: FieldDecoration(
                  hintText: 'Working Days',
                  hintStyle: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0,
                    height: 1.2,
                    color: Color(0xffAFAFAF),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  showClearIcon: false,
                  backgroundColor: Color(0xffffffff),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xffCDE2FB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xffCDE2FB)),
                  ),
                ),
                dropdownDecoration: const DropdownDecoration(
                  marginTop: 2, // Adjust this value as needed
                  maxHeight: 400,
                  header: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Select Working days from the List',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Inter"),
                    ),
                  ),
                ),
                dropdownItemDecoration: DropdownItemDecoration(
                  selectedIcon:
                      const Icon(Icons.check_box, color: Color(0xff8856F4)),
                  disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
                ),
                onSelectionChange: (selectedItems) {
                  setState(() {
                    selectedDays =
                        selectedItems.map((weekDay) => weekDay.name).toList();
                    _validateWeekdays = "";
                  });
                  debugPrint("Selected Days: $selectedDays");
                },
              ),
              if (_validateWeekdays.isNotEmpty) ...[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(bottom: 5),
                  child: ShakeWidget(
                    key: Key("value"),
                    duration: Duration(milliseconds: 700),
                    child: Text(
                      _validateWeekdays,
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
                const SizedBox(
                  height: 15,
                ),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      buildFormLabel("Start Time"),
                      _buildTextField1(
                          fieldKey: 'StartTime',
                          controller: startTimeController,
                          hintText: 'StartTime',
                          keyboardType: TextInputType.text,
                          validator: _validatestartTime),
                    ],
                  ),
                  Column(
                    children: [
                      buildFormLabel("End Time"),
                      _buildTextField1(
                          fieldKey: 'EndTime',
                          controller: endController,
                          hintText: 'EndTime',
                          keyboardType: TextInputType.text,
                          validator: _validateEndTime),
                    ],
                  ),
                ],
              ),
              buildFormLabel("Select the categories"),
              _buildTextField(
                fieldKey: "category",
                controller: categoryController,
                hintText: 'Categories',
                keyboardType: TextInputType.text,
                validator: (value) => _validateField(value, "Categories"),
              ),
              buildFormLabel("Select the Tests"),
              _buildTextField(
                fieldKey: "tests",
                controller: testsController,
                hintText: 'Services',
                keyboardType: TextInputType.text,
                validator: (value) => _validateField(value, "Services"),
              ),
              buildFormLabel("Enter license number of diagnostic lab"),
              _buildTextField(
                fieldKey: "licenseNumber",
                controller: licenseNumberController,
                hintText: 'License Number',
                keyboardType: TextInputType.text,
                validator: (value) => _validateField(value, "License Number"),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: _submitForm, // Directly call the function
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff27BDBE), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  minimumSize:
                      const Size(double.infinity, 48), // Width & height
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poppins",
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: "Poppins",
                    ),
                  ),
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
                        color: Color(0xff27BDBE),
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
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

  Widget buildFormLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String fieldKey,
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    required String? Function(String) validator, // ✅ Allow nullable return type
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          keyboardType: keyboardType,
          style: TextStyle(
              fontFamily: "Poppins", fontWeight: FontWeight.w500, fontSize: 15),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xffAFAFAF),
            ),
            filled: true,
            fillColor: const Color(0xffffffff),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(width: 1, color: Color(0xffCDE2FB)),
            ),
          ),
          onChanged: (value) =>
              _validateAndSetError(fieldKey, value, validator),
        ),
        Visibility(
          visible: validationErrors
              .containsKey(fieldKey), // Only show if an error exists
          child: Container(
            alignment: Alignment.topLeft,
            child: ShakeWidget(
              key: Key(fieldKey),
              duration: const Duration(milliseconds: 700),
              child: Text(
                validationErrors[fieldKey] ?? "",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField1({
    required String fieldKey,
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    required String? Function(String) validator, // ✅ Allow nullable return type
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black,
            keyboardType: keyboardType,
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 15),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Color(0xffAFAFAF),
              ),
              filled: true,
              fillColor: const Color(0xffffffff),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffCDE2FB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide:
                    const BorderSide(width: 1, color: Color(0xffCDE2FB)),
              ),
            ),
            onChanged: (value) =>
                _validateAndSetError(fieldKey, value, validator),
          ),
        ),
        Visibility(
          visible: validationErrors
              .containsKey(fieldKey), // Only show if an error exists
          child: Container(
            alignment: Alignment.topLeft,
            child: ShakeWidget(
              key: Key(fieldKey),
              duration: const Duration(milliseconds: 700),
              child: Text(
                validationErrors[fieldKey] ?? "",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class WeekDays {
  final String name;

  WeekDays({required this.name});
}
