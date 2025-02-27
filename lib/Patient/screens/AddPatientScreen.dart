import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:revxpharma/Components/CustomSnackBar.dart';
import 'package:revxpharma/Patient/logic/cubit/patient/patient_cubit.dart';

import '../../Components/ShakeWidget.dart';
import '../logic/cubit/patient/patient_state.dart';

class AddPatientScreen extends StatefulWidget {
  final String type;
  final String pateint_id;

  const AddPatientScreen({Key? key, required this.type,required this.pateint_id}) : super(key: key);

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _bloodgroupController = TextEditingController();

  Map<String, String> validationErrors = {};
  String? selectedGender;
   List<String> genderOptions = ["Male", "Female", "Others"];

   Map<String, String> gendersortOptionToValue = {
    "Male": "male",
    "Female": "female",
    "Others": "others",
  };

  @override
  void initState() {
    fetchPatient_details();
    super.initState();
  }


 fetchPatient_details() {
  context.read<PatientCubit>().getPatientDetails(widget.pateint_id);
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

  String? _validateField(String value, String fieldName) {
    if (value.trim().isEmpty) {
      return "$fieldName is required";
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

  void _submitForm() {
    setState(() {
      _validateAndSetError("name", _nameController.text,
          (value) => _validateField(value, "Name"));
      _validateAndSetError(
          "mobileNumber", _mobileController.text, _validatePhone);
      _validateAndSetError(
          "age", _ageController.text, (value) => _validateField(value, "Age"));
      _validateAndSetError("bloodgroup", _bloodgroupController.text,
          (value) => _validateField(value, "Blood Group"));
      _validateAndSetError("gender", selectedGender ?? "",
          (value) => _validateField(value, "Gender"));
      _validateAndSetError("dob", _dobController.text ?? "",
              (value) => _validateField(value, "DOB"));
    });
    if (validationErrors.isEmpty) {
      onAddPatient(widget.type);
    }
  }

  void onAddPatient(type) {
    Map<String, dynamic> patientData = {
      'patient_name': _nameController.text,
      'mobile': _mobileController.text,
      'gender': selectedGender,
      'dob':  _dobController.text,
      'age': _ageController.text,
      'blood_group': _bloodgroupController.text,
    };
    if(type=="add"){
      context.read<PatientCubit>().addPatient(patientData);
    }else{
     context.read<PatientCubit>().editPatient(patientData,widget.pateint_id);
    }
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
        _dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Color(0xff27BDBE),
            ),
            Text(
              '${widget.type[0].toUpperCase()}${widget.type.substring(1)} Patient',
              style: TextStyle(
                color: Color(0xff27BDBE),
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        elevation: 4,
      ),
      body:BlocConsumer<PatientCubit, PatientState>(
          listener: (context, state) {
            if (state is PatientLoaded) {
              if(state.successModel.settings?.success==1){
                CustomSnackBar.show(context, "Patient Added Successfully!");
                Navigator.pop(context);
              }
              else{
                CustomSnackBar.show(context,state.successModel.settings?.message??"");
              }
            }else if(state is PatientsDetailsLoaded){
              _nameController.text= state.getPatientDetailsmodel.getPatientDetails?.patientName??'';
              _mobileController.text= state.getPatientDetailsmodel.getPatientDetails?.mobile??'';
              _dobController.text= state.getPatientDetailsmodel.getPatientDetails?.dob??'';
              _bloodgroupController.text= state.getPatientDetailsmodel.getPatientDetails?.bloodGroup??'';
              String gender = state.getPatientDetailsmodel.getPatientDetails?.gender ?? 'male';
              gendersortOptionToValue = {
                "Male": "male",
                "Female": "female",
                "Others": "others",
                gender: gendersortOptionToValue[gender] ?? 'others',
              };

              _ageController.text = state.getPatientDetailsmodel.getPatientDetails?.age.toString()??"";
            }
            else if (state is PatientErrorState) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    buildFormLabel("Full Name"),
                    _buildTextField(
                      fieldKey: "name",
                      controller: _nameController,
                      hintText: 'Name',
                      keyboardType: TextInputType.text,
                      validator: (value) => _validateField(value, "Name"),
                    ),
                    buildFormLabel("Mobile number"),
                    _buildTextField(
                      fieldKey: "mobileNumber",
                      controller: _mobileController,
                      hintText: 'Mobile Number',
                      keyboardType: TextInputType.phone,
                      validator: _validatePhone,
                    ),
                    buildFormLabel("DOB"),
                    _buildTextField(
                      fieldKey: "dob",
                      controller: _dobController,
                      hintText: 'Select DOB',
                      keyboardType: TextInputType.none,
                      validator: (value) => _validateField(value, "dob"),
                      isDatePicker: true,
                    ),
                    buildFormLabel("Gender"),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        items: genderOptions.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
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
                        hint: const Text(
                          "Select Gender", // Hint text shown when value is null
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey, // Make hint text grey
                          ),
                        ),
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Color(0xffCDE2FB)),
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
                    Visibility(
                      visible: validationErrors
                          .containsKey("gender"), // Only show if an error exists
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: ShakeWidget(
                          key: Key("gender"),
                          duration: const Duration(milliseconds: 700),
                          child: Text(
                            validationErrors["gender"] ?? "",
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
                    buildFormLabel("Age"),
                    _buildTextField(
                      fieldKey: "age",
                      controller: _ageController,
                      hintText: 'Age',
                      keyboardType: TextInputType.phone,
                      validator: (value) => _validateField(value, "age"),
                    ),
                    buildFormLabel("Blood Group"),
                    _buildTextField(
                      fieldKey: "bloodgroup",
                      controller: _bloodgroupController,
                      hintText: 'Blood Group',
                      keyboardType: TextInputType.text,
                      validator: (value) => _validateField(value, "Blood Group"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff27BDBE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12), // Rounded edges
                          ),
                          elevation: 3, // Slight shadow effect
                        ),
                        child: (state is PatientSavingLoadingState) ?
                        Center(child: CircularProgressIndicator(strokeWidth: 1,color: Colors.white,),):
                        Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // White text for better contrast
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          }),
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
    required String? Function(String) validator,
    bool isDatePicker = false, // ✅ Added flag to identify date picker field
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          keyboardType: keyboardType,
          onTap: isDatePicker
              ? () => _selectDate(context) // Open date picker if DOB
              : null,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
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
          onChanged: (value) => _validateAndSetError(fieldKey, value, validator),
        ),
        Visibility(
          visible: validationErrors.containsKey(fieldKey),
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
