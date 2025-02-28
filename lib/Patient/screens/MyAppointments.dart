import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Patient/logic/cubit/appointment/appointment_cubit.dart';

class Myappointments extends StatefulWidget {
  const Myappointments({super.key});

  @override
  State<Myappointments> createState() => _MyappointmentsState();
}

class _MyappointmentsState extends State<Myappointments> {
  @override
  void initState() {
    context.read<AppointmentCubit>().fetchAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "My Appointments", actions: []),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<AppointmentCubit, AppointmentState>(
                  builder: (context, state) {
                    if (state is AppointmentLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is AppointmentListLoaded) {
                      final appointments = state.appointmentsList.appointments;

                      if (appointments == null || appointments.isEmpty) {
                        return Center(child: Text("No Appointments Available"));
                      }

                      return CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                final appointment = appointments[index];
                                return Container(
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffA9A9A9), width: 0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "OrderID : ${appointment.appointmentNumber}",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${appointment.appointmentDate}",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        height: 20,
                                        thickness: 0.5,
                                        color: Color(0xffA9A9A9),
                                      ),
                                      Text(
                                        appointment.diagnosticCentreName ?? "Unknown Diagnostic Centre",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff27BDBE)
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Order Amount",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "₹${appointment.totalAmount}",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                              childCount: appointments.length,
                            ),
                          ),
                        ],
                      );
                    }
                    return Center(child: Text("No Data"));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
