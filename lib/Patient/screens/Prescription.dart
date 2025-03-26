import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revxpharma/Components/CustomAppButton.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Utils/color.dart';

class Prescription extends StatefulWidget {
  const Prescription({super.key});
  @override
  State<Prescription> createState() => _PrescriptionState();

}

class _PrescriptionState extends State<Prescription> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();


  Future<void> _pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }


  // Function to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(
        title: 'Upload Prescription',
        actions: [
          if (_selectedImage != null)
            IconButton(
              icon: Icon(Icons.clear, color: Colors.red),
              onPressed: () => setState(() => _selectedImage = null),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Preview Container (Template for prescription image)
              Container(
                width: w,
                height: 200, // Fixed height for image preview
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/Medical prescription.png', // Placeholder for prescription template
                      fit: BoxFit.cover,
                      width: w,
                      height: 200,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 24),

              // Prescription Requirements
              Text(
                'A Valid Prescription Should Contain',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRequirementItem(
                    icon: 'assets/CalendarDots.png',
                    label: 'Date of\nPrescription',
                    color: Color(0xffE5FFAD),
                  ),
                  _buildRequirementItem(
                    icon: 'assets/Stethoscope.png',
                    label: 'Doctor\nDetails',
                    color: Color(0xffFFD9AD),
                  ),
                  _buildRequirementItem(
                    icon: 'assets/UserList.png',
                    label: 'Patient\nDetails',
                    color: Color(0xffE0D8FF),
                  ),
                  _buildRequirementItem(
                    icon: 'assets/Pill.png',
                    label: 'Dosage\nDetails',
                    color: Color(0xffBFFCBE),
                  ),
                ],
              ),

              SizedBox(height: 24),

              Row(
                children: [
                  Image.asset(
                    'assets/file_upload.png',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Upload Your Prescription',
                    style: TextStyle(
                      color: Color(0xff1A1A1A),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.camera_alt_rounded,
                    label: 'Camera',
                    color: primaryColor,
                    textColor: Colors.white,
                    onTap: _pickImageFromCamera,
                  ),
                  _buildActionButton(
                    icon: Icons.photo,
                    label: 'Gallery',
                    color: Colors.white,
                    textColor: primaryColor,
                    borderColor: primaryColor,
                    onTap: _pickImageFromGallery,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _selectedImage != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomAppButton(
          text: 'Submit Prescription',
          onPlusTap: () {
            // Add your submission logic here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Prescription submitted successfully')),
            );
          },
        ),
      )
          : null,
    );
  }

  // Helper widget for requirement items
  Widget _buildRequirementItem({
    required String icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              icon,
              scale: 3,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff1A1A1A),
            fontSize: 12,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }


  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: borderColor != null ? Border.all(color: borderColor, width: 1) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: textColor),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
