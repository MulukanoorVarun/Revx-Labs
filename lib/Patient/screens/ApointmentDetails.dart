import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/InfoRow.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/appointment_details/appointment_details_state.dart';
import 'package:revxpharma/Utils/color.dart';
import '../logic/cubit/appointment_details/appointment_details_cubit.dart';

class AppointmentDetails extends StatefulWidget {
  final String id;

  const AppointmentDetails({super.key, required this.id});

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  void initState() {
    super.initState();
    context.read<AppointmentDetailsCubit>().fetchAppointmentDetails(widget.id);
  }

  Future<void> _downloadInvoice(String url) async {
    try {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
        return;
      }

      Directory dir = Directory('/storage/emulated/0/Download/');
      if (!await dir.exists()) {
        dir = await getExternalStorageDirectory() ?? Directory.systemTemp;
      }

      final fileName = 'Invoice_${DateTime.now().millisecondsSinceEpoch}.pdf';

      await FileDownloader.downloadFile(
        url: url.trim(),
        name: fileName,
        downloadDestination: DownloadDestinations.publicDownloads,
        notificationType: NotificationType.all,
        onProgress: (fileName, progress) {
          print('Downloading $fileName: $progress%');
        },
        onDownloadCompleted: (path) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invoice downloaded to $path')),
          );
        },
        onDownloadError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Download failed: $error')),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading invoice: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Appointment Details",
        actions: [],
      ),
      body: BlocBuilder<AppointmentDetailsCubit, AppointmentDetailsState>(
        builder: (context, state) {
          if (state is AppointmentDetailsLoading) {
            return _buildShimmer();
          } else if (state is AppointmentDetailsLoaded) {
            final appointment = state.appointmentDetails?.appointmentData;
            if (appointment == null) {
              return const Center(child: Text("No appointment data available"));
            }
            return _buildAppointmentDetails(appointment);
          }
          return const Center(
              child: Text("Failed to load appointment details"));
        },
      ),
    );
  }

  Widget _buildAppointmentDetails(dynamic appointment) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order ID: ${appointment.appointmentNumber ?? 'N/A'}",
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                appointment.appointmentDate ?? 'N/A',
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Diagnostic Centre Info
          Text(
            appointment.diagnosticCentre?.name ?? 'Unknown Centre',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.location_on, size: 20, color: Colors.redAccent),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  appointment.diagnosticCentre?.location ?? 'No location',
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    color: Color(0xFF757575),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Tests Section
          const Text(
            "Tests Booked",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: appointment.appointmentTests?.length ?? 0,
              separatorBuilder: (context, index) => const Divider(
                height: 24,
                color: Color(0xFFE0E0E0),
                thickness: 1,
              ),
              itemBuilder: (context, index) {
                final test = appointment.appointmentTests[index];
                final testDetails = test.testDetails?.testDetailsModel;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            testDetails?.image ?? '',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 60),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                testDetails?.testName ?? 'Unknown Test',
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '₹${test.totalPrice ?? 0}',
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Chip(
                                label: Text(
                                  "Patients: ${test.noOfPersons ?? 1}",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    color: primaryColor,
                                  ),
                                ),
                                backgroundColor: primaryColor.withOpacity(0.1),
                                side: BorderSide(color: primaryColor),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (testDetails?.fastingRequired == true) ...[
                          Row(
                            children: [
                              Image.asset(
                                'assets/ForkKnife.png',
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Fasting Required',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF555555),
                                ),
                              ),
                            ],
                          ),
                        ],
                        Row(
                          children: [
                            Image.asset(
                              'assets/file.png',
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Reports in ${testDetails?.reportsDeliveredIn ?? 0} min',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF555555),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Patient Details Section
          const Text(
            "Patient Details",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                InfoRow(
                  label: 'Patient',
                  value: appointment.patientDetails?.patientName ?? 'N/A',
                ),
                const SizedBox(height: 12),
                InfoRow(
                  label: 'Mobile',
                  value: appointment.patientDetails?.mobile ?? 'N/A',
                ),
                const SizedBox(height: 12),
                InfoRow(
                  label: 'DOB',
                  value: appointment.patientDetails?.dob ?? 'N/A',
                ),
                const SizedBox(height: 12),
                InfoRow(
                  label: 'Gender',
                  value: appointment.patientDetails?.gender ?? 'N/A',
                ),
                const SizedBox(height: 12),
                InfoRow(
                  label: 'Blood Group',
                  value: appointment.patientDetails?.bloodGroup ?? 'N/A',
                ),
                const SizedBox(height: 12),
                InfoRow(
                  label: 'Age',
                  value: appointment.patientDetails?.age?.toString() ?? 'N/A',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            "Bill Summary",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total Amount",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '₹${appointment.totalAmount ?? '0.00'}',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          if (appointment.appointmentReports?.isNotEmpty ?? false)
            ElevatedButton.icon(
              onPressed: () => _downloadInvoice(
                  appointment.appointmentReports![0].reportUrl ?? ""),
              icon: const Icon(Icons.download_rounded, color: Colors.white),
              label: const Text(
                "Download Reports",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 50),
                elevation: 2,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildShimmer() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shimmerText(120, 16, context),
          const SizedBox(height: 20),
          shimmerText(200, 20, context),
          const SizedBox(height: 8),
          shimmerText(250, 14, context),
          const SizedBox(height: 24),
          shimmerText(100, 18, context),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: List.generate(
                2,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          shimmerRectangle(60, context),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              shimmerText(150, 16, context),
                              const SizedBox(height: 4),
                              shimmerText(80, 18, context),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      shimmerText(200, 12, context),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          shimmerText(100, 18, context),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      shimmerText(100, 14, context),
                      shimmerText(80, 14, context),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          shimmerText(100, 18, context),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                shimmerText(80, 16, context),
                shimmerText(60, 18, context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
