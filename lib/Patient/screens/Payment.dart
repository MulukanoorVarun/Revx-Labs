import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'PaymentSuccess.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int _selectedPaymentOption = 0; // Variable to store selected payment option

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Center(
          child: Text(
            "Payment",
            style: TextStyle(
              color: Color(0xff27BDBE),
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert),
          )

        ],

      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 80, top: 20), // Added padding at the bottom for button
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment option",
                  style: TextStyle(
                      color: Color(0xff808080),
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      fontSize: 18),
                ),
                SizedBox(height: 25),
                // Credit card option
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff3A7DFF), width: 1),
                      borderRadius: BorderRadius.circular(45)),
                  child: Row(
                    children: [
                      Text(
                        "Credit card",
                        style: TextStyle(
                            color: Color(0xff1A1A1A),
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Radio(
                        activeColor: Color(0xff27BDBE),
                        value: 1,
                        groupValue: _selectedPaymentOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentOption = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                // Debit card option
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff3A7DFF), width: 1),
                      borderRadius: BorderRadius.circular(45)),
                  child: Row(
                    children: [
                      Text(
                        "Debit card",
                        style: TextStyle(
                            color: Color(0xff1A1A1A),
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Radio(
                        activeColor: Color(0xff27BDBE),
                        value: 2,
                        groupValue: _selectedPaymentOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentOption = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                // Cash on delivery option
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff3A7DFF), width: 1),
                      borderRadius: BorderRadius.circular(45)),
                  child: Row(
                    children: [
                      Text(
                        "Cash on delivery",
                        style: TextStyle(
                            color: Color(0xff1A1A1A),
                            fontSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Radio(
                        activeColor: Color(0xff27BDBE),
                        value: 3,
                        groupValue: _selectedPaymentOption,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentOption = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Positioned button at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(16), // Add some margin to avoid overlap with edges
              width: w,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFF00C4D3),
                borderRadius: BorderRadius.circular(50),
              ),
              child: InkWell(
                onTap: () {
                  // Handle Confirm & Pay action
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => paymentoptionscreen()));
                },
                child: Center(
                  child: Text(
                    'Confirm & Pay',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}