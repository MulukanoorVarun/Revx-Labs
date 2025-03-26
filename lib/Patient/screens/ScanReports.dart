import 'package:flutter/material.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';

import '../../Components/InfoRow.dart';

class ScanReports extends StatefulWidget {
  const ScanReports({super.key});
  @override
  State<ScanReports> createState() => _ReportsState();
}

class _ReportsState extends State<ScanReports> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: 'Your Reports', actions: []),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffEEEEEE), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Ensure children stretch to match height
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color(0xffF1F1F1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: w * 0.2,
                    child: Image.asset(
                      'assets/report.png',
                      fit: BoxFit.cover, // Ensures the image fills the container
                    ),
                  ),
                  SizedBox(width: 12), // Replace spacing with SizedBox for Row
                  Container(
                    width: w * 0.58,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // Minimize extra space
                      children: [
                        Text(
                          'Shiva Karthik Diagnostic',
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          style: const TextStyle(
                            color: Color(0xff333333),
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 5), // Spacing for better layout
                        const InfoRow(label: 'Patient', value: 'Shivad'),
                        const InfoRow(label: 'Test Name', value: 'MRI'),
                        const InfoRow(label: 'Test Date', value: '09/03/24'),
                        const InfoRow(label: 'Status', value: 'Completed'),
                      ],
                    ),
                  ),

                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 12),
        ),
      ),
    );
  }
}
