import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';

class ApointmentDetails extends StatefulWidget {
  const ApointmentDetails({super.key});

  @override
  State<ApointmentDetails> createState() => _ApointmentDetailsState();
}

class _ApointmentDetailsState extends State<ApointmentDetails> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(title: "Appointment Details", actions: []),
      // body: BlocBuilder<CartCubit, CartState>(builder: (context, cartState) {
      //   if (cartState is CartLoadingState) {
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   } else if (cartState is CartLoaded) {
      //     return SingleChildScrollView(
      //       child: Padding(
      //         padding:
      //             EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 10),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Expanded(
      //                   child: Text(
      //                     maxLines: 2,
      //                     textAlign: TextAlign.start,
      //                     "${cartState.cartList?.data?.diagnosticCentre?.name}",
      //                     style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.w600,
      //                         fontFamily: "Poppins"),
      //                   ),
      //                 )
      //               ],
      //             ),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Image.asset(
      //                   "assets/location.png",
      //                   height: 20,
      //                   width: 20,
      //                   color: Colors.red,
      //                 ),
      //                 SizedBox(width: 10),
      //                 Column(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Container(
      //                       width: w * 0.8, // 90% of screen width
      //                       child: Text(
      //                         "${cartState.cartList?.data?.diagnosticCentre?.location}",
      //                         maxLines: 2,
      //                         overflow: TextOverflow.ellipsis,
      //                         style: TextStyle(
      //                           color: Color(0xff949494),
      //                           fontSize: 14,
      //                           fontWeight: FontWeight.w400,
      //                           fontFamily: "Poppins",
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ],
      //             ),
      //             SizedBox(height: 23),
      //             Container(
      //               padding: const EdgeInsets.all(10),
      //               width: w,
      //               decoration: BoxDecoration(
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Colors.black.withOpacity(0.25),
      //                     spreadRadius: 1,
      //                     blurRadius: 2,
      //                     offset: const Offset(0, 1),
      //                   ),
      //                 ],
      //                 color: Colors.white,
      //               ),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   ListView.separated(
      //                     shrinkWrap: true,
      //                     physics: const NeverScrollableScrollPhysics(),
      //                     itemCount:
      //                         cartState.cartList?.data?.cartTests?.length ?? 0,
      //                     separatorBuilder: (context, index) => const Divider(
      //                       color: Colors.grey,
      //                       thickness: 0.5,
      //                       height: 16,
      //                     ),
      //                     itemBuilder: (context, index) {
      //                       final test =
      //                           cartState.cartList?.data?.cartTests?[index];
      //                       return Padding(
      //                         padding:
      //                             const EdgeInsets.symmetric(vertical: 4.0),
      //                         child: Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Row(
      //                               children: [
      //                                 Expanded(
      //                                   child: Text(
      //                                     "${test?.testName ?? ""}",
      //                                     maxLines: 2,
      //                                     overflow: TextOverflow.ellipsis,
      //                                     style: const TextStyle(
      //                                       color: Color(0xff000000),
      //                                       fontWeight: FontWeight.w400,
      //                                       fontFamily: "Poppins",
      //                                       fontSize: 14,
      //                                     ),
      //                                   ),
      //                                 ),
      //                               ],
      //                             ),
      //                             const SizedBox(height: 4),
      //                             Text(
      //                               "₹${test?.testPrice ?? ""}",
      //                               style: const TextStyle(
      //                                 color: Color(0xff000000),
      //                                 fontWeight: FontWeight.w400,
      //                                 fontFamily: "Poppins",
      //                                 fontSize: 14,
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       );
      //                     },
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     );
      //   }
      //   return Center(child: Text("No Data Available"));
      // }),
    );
  }
}
