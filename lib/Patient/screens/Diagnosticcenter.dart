import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/diagnostic_centers/diagnostic_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/diagnostic_centers/diagnostic_state.dart';
import 'DiagnosticInformation.dart';

class Diagnosticcenter extends StatefulWidget {
  String lat_lng;
  Diagnosticcenter({super.key, required this.lat_lng});

  @override
  State<Diagnosticcenter> createState() => _Diagnosticcenter();
}

class _Diagnosticcenter extends State<Diagnosticcenter> {
  @override
  void initState() {
    context
        .read<DiagnosticCentersCubit>()
        .fetchDiagnosticCenters(widget.lat_lng);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(title: "Diagnostic Centers", actions: []),
      body: BlocBuilder<DiagnosticCentersCubit, DiagnosticCentersState>(
        builder: (context, state) {
          if (state is DiagnosticCentersLoading) {
            return _shimmerList();
          } else if (state is DiagnosticCentersLoaded) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount:
                          state.diagnosticCenters.data?.length, // 5 products
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1, // 1 card per row
                        childAspectRatio:
                            2.35, // Adjust this to control the card's aspect ratio
                        crossAxisSpacing:
                            10, // Horizontal spacing between cards
                        mainAxisSpacing: 10, // Vertical spacing between cards
                      ),
                      itemBuilder: (context, index) {
                        final item = state.diagnosticCenters.data?[index];
                        // Each card in the grid
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DiagnosticInformation(
                                  diognosticId: item?.id ?? '',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey, width: 1), // Gray border
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 0), // Padding for the image
                                  child: Container(
                                    width: 100, // Adjust width as needed
                                    height: 100, // Square image
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xff24AEB1),
                                          width: 1), // Gray border
                                      borderRadius: BorderRadius.circular(
                                          8), // Rounded corners for the image
                                    ),
                                    child: Image.network(item?.image ?? ''),
                                  ),
                                ),
                                // Product details section
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: screenheight * 0.01,
                                      ),
                                      SizedBox(
                                        width: screenwidth*0.5,
                                        child: Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          "${item?.name ?? ''}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: screenheight * 0.01,
                                      ), // Space between product name and price
                                      SizedBox(
                                        width: screenwidth*0.5,
                                        child: Text(
                                          "${item?.location ?? "Unknown location"}",
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      SizedBox(
                                          height:
                                          10), //
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.red,
                                            size: 18, // Adjusted icon size for better UI balance
                                          ),
                                          const SizedBox(width: 4), // Spacing between icon and text
                                          Text(
                                            item?.distance ?? '0 km', // Default to 0 km if distance is null
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              10), // Space between price and buttons

                                      // Row with "View" button and "Add Test" button
                                      // Row(
                                      //   mainAxisAlignment: MainAxisAlignment
                                      //       .start, // Align content to the start
                                      //   children: [
                                      //     // Small image icon
                                      //     Stack(
                                      //       children: [
                                      //         Image.asset(
                                      //           'assets/offerbg.jpeg', // Replace with the actual asset path of your small image
                                      //           width:
                                      //               60, // Set the desired width for the small image
                                      //           height:
                                      //               24, // Set the desired height for the small image
                                      //         ),
                                      //         Positioned(
                                      //             left: 10,
                                      //             right: 3,
                                      //             top: 3,
                                      //             child: Text(
                                      //               "10% Off",
                                      //               style: TextStyle(
                                      //                 fontFamily: "Poppins",
                                      //                 fontWeight:
                                      //                     FontWeight.normal,
                                      //                 fontSize: 12,
                                      //                 color: Colors.white,
                                      //               ),
                                      //             )),
                                      //       ],
                                      //     ),
                                      //     SizedBox(
                                      //       width: 5,
                                      //     ),
                                      //     Text(
                                      //       '',
                                      //       style: TextStyle(
                                      //         fontSize: 13,
                                      //         fontWeight: FontWeight.w400,
                                      //         fontFamily: "Poppins",
                                      //         color: Color(0xff3A3A3A),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DiagnosticCentersError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text("No Data"));
        },
      ),
    );
  }

  Widget _shimmerList() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Expanded(
        child: GridView.builder(
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Container(
                  width: w,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff949494), width: 1),
                    // Gray border
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmerContainer(100, 100, context),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          shimmerText(160, 12, context),
                          SizedBox(
                            height: 16,
                          ),
                          shimmerText(160, 16, context),
                          SizedBox(
                            height: 10,
                          ),
                          shimmerText(160, 12, context),
                        ],
                      )
                    ],
                  ));
            }),
      ),
    );
  }
}
