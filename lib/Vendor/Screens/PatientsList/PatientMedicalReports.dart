import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../Components/CustomAppButton.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class MedicalReports extends StatefulWidget {
  const MedicalReports({super.key});

  @override
  State<MedicalReports> createState() => _MedicalReportsState();
}

class _MedicalReportsState extends State<MedicalReports> {
  List<Map<String, dynamic>> uploadedFiles = []; // To store file names and progress

  Future<void> requestPermissions() async {
    var status = await Permission.storage.request();

    if (status.isGranted) {
      pickFiles();
    } else if (status.isDenied) {
      // Handle permission denied case
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true, // Allow multiple files
      );

      if (result != null) {
        // Loop through each picked file and add it to the list
        for (var file in result.files) {
          setState(() {
            uploadedFiles.add({
              'fileName': file.name,
              'filePath': file.path,
              'progress': 0.0,
              'fileType': file.extension,  // Get file extension to determine type
            });
          });
          uploadFile(file); // Simulate file upload and progress
        }
      } else {
        // User canceled the picker
        print('No files selected');
      }
    } catch (e) {
      print('Error picking files: $e');
    }
  }

  // Simulate file upload and update progress (for demo purposes)
  Future<void> uploadFile(PlatformFile file) async {
    for (int i = 0; i < uploadedFiles.length; i++) {
      if (uploadedFiles[i]['fileName'] == file.name) {
        // Simulate file upload progress
        for (double progress = 0.0; progress <= 100.0; progress += 10.0) {
          await Future.delayed(Duration(milliseconds: 500));
          setState(() {
            uploadedFiles[i]['progress'] = progress;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dotted Border Container for uploading
            Container(
              height: 160,
              child: DottedBorder(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                borderType: BorderType.RRect,
                radius: Radius.circular(10),
                dashPattern: [4, 2],
                color: Color(0xff27BDBE),
                strokeWidth: 0.5,
                child: Column(
                  children: [
                    Text(
                      "Upload the patient medical reports in PDF, Jpg, png format",
                      style: TextStyle(
                        color: Color(0xff808080),
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 30),
                    // Upload button that calls the permission check and file picker
                    CustomAppButton(
                      text: 'Upload',
                      onPlusTap: () async {
                        await requestPermissions();
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Display "Uploaded files" label outside the dotted border container
            Text(
              'Uploaded files',
              style: TextStyle(
                color: Color(0xff151515),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: uploadedFiles.length,
                itemBuilder: (context, index) {
                  print('uploadedFiles.length>>${uploadedFiles.length}');
                  var file = uploadedFiles[index];
                  print('file>>>>${file}');
                  String fileType = file['fileType'] ?? '';
                  String fileIcon = fileType == 'pdf'
                      ? 'assets/bxs_file-pdf.png' // For PDF files
                      : fileType == 'jpg' || fileType == 'jpeg' || fileType == 'png'
                      ? 'assets/bxs_file-image.png' // For image files
                      : 'assets/bxs_file-other.png'; // Default icon

                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Image.asset(
                          fileIcon, // Dynamic file icon based on type
                          fit: BoxFit.contain,
                          height: 28,
                          width: 28,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              file['fileName'],
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(height: 4),
                            LinearProgressIndicator(
                              value: file['progress'] / 100, // Normalize to [0, 1]
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xff27BDBE)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
