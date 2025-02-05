import 'package:flutter/material.dart';
import 'package:revxpharma/Components/CustomAppButton.dart';
import 'package:revxpharma/Vendor/Screens/VendorTest.dart';

class ApprovalPending extends StatefulWidget {
  const ApprovalPending({super.key});

  @override
  State<ApprovalPending> createState() => _ApprovalPendingState();
}

class _ApprovalPendingState extends State<ApprovalPending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Colors.black,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/pending.png',
            fit: BoxFit.contain,
            width: 250,
            height: 250,
          )),
          SizedBox(
            height: 10,
          ),
          Text(
            'Approval Pending',
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),  SizedBox(
            height: 10,
          ),
          Text(
            'Wait for the admin’s approval for \n accepting the creation of new test',
            style: TextStyle(
              color: Color(0xff000000),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ],
      ),bottomNavigationBar: Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
        child: CustomAppButton(text: 'Remind me', onPlusTap: (){
            }),
      ),
    );
  }
}
