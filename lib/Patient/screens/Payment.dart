import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Utils/color.dart';
import '../../Components/CustomSnackBar.dart';
import '../logic/cubit/appointment/appointment_cubit.dart';
import 'BookedApointmentsuccessfully.dart';


class Payment extends StatefulWidget {
  final Map<String, dynamic> data;
  const Payment({Key? key, required this.data}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String _selectedPaymentOption = "cash_on_test";
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(title: "Payment", actions: []),
      body: BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is AppointmentLoaded) {
            if (state.appointments.settings?.success == 1) {
              context.pushReplacement('/apointment_success?appointmentmsg=${state.appointments.settings?.message ?? ""}');
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => ApointmentSuccess(
              //             appointmentmsg:
              //                 state.appointments.settings?.message ?? "",
              //           )),
              // );
            } else {
              CustomSnackBar.show(
                  context, "${state.appointments.settings?.message}");
            }
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment option",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 15),
                    // Updated Payment Container
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade500, width: 1),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            visualDensity: VisualDensity.compact,
                            activeColor: primaryColor,
                            title: Text("Cash"),
                            value: "cash_on_test",
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
                    Spacer(), // Pushes the button to the bottom
                  ],
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: w,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: state is AppointmentLoading
                          ? null
                          : () {
                              if (_selectedPaymentOption != null) {
                                widget.data['payment_mode'] =
                                    _selectedPaymentOption;
                                debugPrint("Final Data: ${widget.data}");
                                context
                                    .read<AppointmentCubit>()
                                    .bookAppointment(widget.data);
                              } else {
                                debugPrint("Please select a payment option.");
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        disabledBackgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: 0,
                      ),
                      child: state is AppointmentLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'Confirm & Pay',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
