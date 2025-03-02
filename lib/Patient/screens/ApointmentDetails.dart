import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Patient/logic/cubit/appointment_details/appointment_details_state.dart';

import '../logic/cubit/appointment_details/appointment_details_cubit.dart';

class ApointmentDetails extends StatefulWidget {
  String id;
   ApointmentDetails({super.key,required this.id});

  @override
  State<ApointmentDetails> createState() => _ApointmentDetailsState();
}

class _ApointmentDetailsState extends State<ApointmentDetails> {
  @override
  void initState() {
    context.read<AppointmentDetailsCubit>().fetchAppointmentDetails(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(title: "Appointment Details", actions: []),
      body: BlocBuilder<AppointmentDetailsCubit, AppointmentDetailsState>(builder: (context, state) {
        if (state is AppointmentDetailsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AppointmentDetailsLoaded) {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "OrderID : ${state.appointmentDetails?.appointment_data?.appointmentNumber??''}",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${state.appointmentDetails?.appointment_data?.appointmentDate??''}",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          "${state.appointmentDetails?.appointment_data?.diagnosticCentre?.name??''}",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff27BDBE)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/location.png",
                        height: 20,
                        width: 20,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: w * 0.8, // 90% of screen width
                            child: Text(
                              "${state.appointmentDetails?.appointment_data?.diagnosticCentre?.location??''}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Color(0xff949494),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 10,top: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffA9A9A9), width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.appointmentDetails?.appointment_data?.appointmentTests?.length??0,
                          separatorBuilder: (context, index) => const Divider(
                            color: Colors.grey,
                            thickness: 0.5,
                            height: 16,
                          ),
                          itemBuilder: (context, index) {
                            final test = state.appointmentDetails?.appointment_data?.appointmentTests?[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text("${test?.testName??""}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Color(0xff000000),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins",
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "₹${test?.price??0}",
                                    style: const TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Bill Summary",
                    style: TextStyle(
                      color: Color(0xff1A1A1A),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins",
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
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
                          children: [
                            Text(
                              "Order Amount",
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins",
                                fontSize: 14,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              child: Text(
                               '₹ ${ state.appointmentDetails?.appointment_data?.totalAmount??''}',
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),


                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        }
        return Center(child: Text("No Data Available"));
      }),
    );
  }
}
