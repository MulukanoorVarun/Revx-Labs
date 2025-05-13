import 'package:bounce/bounce.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_context.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Components/CustomAppButton.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/Location/location_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/Location/location_state.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_state.dart';
import 'package:revxpharma/Patient/screens/Appointment.dart';
import 'package:revxpharma/Patient/screens/Profile.dart';
import 'package:revxpharma/Patient/screens/SearchScreen.dart';
import 'package:revxpharma/Patient/screens/servicecategory.dart';
import 'package:revxpharma/Patient/screens/widgets/ScanCard.dart';
import 'package:revxpharma/Utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/constants.dart';
import '../logic/cubit/home/home_cubit.dart';
import 'DiagnosticInformation.dart';
import 'Diagnosticcenter.dart';
import 'Pregnancy.dart';
import 'alltests.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class ScanOption {
  final String name;
  final String imagePath;
  final String query;
  final String? categoryId;

  ScanOption({
    required this.name,
    required this.imagePath,
    required this.query,
    this.categoryId,
  });
}

class _HomescreenState extends State<Homescreen> {
  int currentIndex = 0;
  String lat_lang = '';

  @override
  void initState() {
    print('latlng:${lat_lang}');
    // context.read<HomeCubit>().fetchHomeData(lat_lang);
    context.read<CartCubit>().getCartList();
    super.initState();
  }

  final List<ScanOption> scans = [
    ScanOption(name: 'MRI Scan', imagePath: 'assets/Scan.png', query: 'mri'),
    ScanOption(
        name: 'CT Scan', imagePath: 'assets/ct scan.jfif', query: 'ct scan'),
    ScanOption(
        name: 'PET Scan', imagePath: 'assets/pet_scan.jpg', query: 'pet scan'),
    ScanOption(
      name: 'Ultrasound Scan',
      imagePath: 'assets/ultrasound.jfif',
      query: 'ultrasound scan',
      categoryId: '6420d355-f757-4f51-800e-3d99b8929047',
    ),
    ScanOption(
      name: 'X Ray',
      imagePath: 'assets/xray.png',
      query: 'xray',
      categoryId: '03edb31f-1b47-4e80-b34d-54a6b539c93f',
    ),
    ScanOption(
      name: 'Color Doppler',
      imagePath: 'assets/colorDopler.png',
      query: 'color doppler',
      categoryId: '533196de-745e-40d8-ab64-30fa5d0cfb58',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, locationState) {
        if (locationState is LocationLoaded) {
          setState(() {
            lat_lang = locationState.latlng;
          });
          context.read<HomeCubit>().fetchHomeData(locationState.latlng);
        }
      },
      child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        final locationState = context.watch<LocationCubit>().state;
        if (state is HomeLoading || locationState is LocationLoading) {
          return _shimmer(context);
        } else if (state is HomeLoaded) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Container(),
              leadingWidth: 0,
              toolbarHeight: screenWidth * 0.37,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: screenWidth * 0.7,
                              child: Text(
                                "Hi, ${StringUtils.capitalizeFirstLetter(state.prfileDetails.data?.fullName)}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 25,
                                ),
                                SizedBox(width: 4),
                                BlocBuilder<LocationCubit, LocationState>(
                                    builder: (context, state) {
                                  if (state is LocationLoading) {
                                    return SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1,
                                        ));
                                  } else if (state is LocationLoaded) {
                                    lat_lang = state.latlng;
                                    return SizedBox(
                                      width: screenWidth * 0.6,
                                      child: Text(
                                        "${state.locationName}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins",
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  } else if (state is LocationError) {
                                    return Center(
                                        child: Text(
                                      state.message,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                        fontSize: 16,
                                      ),
                                    ));
                                  }
                                  return Center(
                                      child: Text(
                                    "No Data",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                    ),
                                  ));
                                }),
                              ],
                            ),
                          ],
                        ),
                        // InkResponse(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => Profile()),
                        //     );
                        //   },
                        //   child: CircleAvatar(
                        //     backgroundColor: Color(
                        //         primaryColor), // Set background color for initials
                        //     child:
                        //         // state.prfileDetails.data?.image != null &&
                        //         //     state.prfileDetails.data!.image!.isNotEmpty
                        //         //     ? ClipRRect(
                        //         //   borderRadius: BorderRadius.circular(50), // Ensures it's circular
                        //         //   child: Image.network(
                        //         //     state.prfileDetails.data!.image!,
                        //         //     fit: BoxFit.cover,
                        //         //     width: double.infinity,
                        //         //     height: double.infinity,
                        //         //   ),
                        //         // )
                        //         //     :
                        //         Text(
                        //       state.prfileDetails.data?.fullName?.isNotEmpty ==
                        //               true
                        //           ? state.prfileDetails.data!.fullName![0]
                        //               .toUpperCase()
                        //           : "?",
                        //       style: TextStyle(
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.bold,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // )
                        BlocBuilder<CartCubit, CartState>(
                          builder: (context, cartState) {
                            int cartCount = 0;
                            if (cartState is CartLoaded) {
                              cartCount = cartState.cartCount;
                            } else if (cartState is CartSuccessState) {
                              cartCount = cartState.cartCount;
                            }
                            return Badge.count(
                              count: cartCount,
                              child: IconButton(
                                visualDensity: VisualDensity.compact,
                                onPressed: () {
                                  // Navigate with animation
                                  context.push('/appointments');
                                },
                                icon: const Icon(Icons.shopping_cart),
                                color: primaryColor,
                                tooltip:
                                    'View Shopping Cart ($cartCount items)',
                                padding: const EdgeInsets.all(0),
                                hoverColor: primaryColor.withOpacity(0.1),
                                splashRadius: 20,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  InkResponse(
                    onTap: () {
                      context.push(Uri(
                          path: '/search_screen',
                          queryParameters: {'lat_lang': lat_lang}).toString());
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(top: 8, bottom: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffF9F9F9),
                          borderRadius: BorderRadius.circular(100),
                          border:
                              Border.all(color: Color(0xffE9E9E9), width: 1)),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Search Diagnostics',
                            style: TextStyle(
                                color: Color(0xff949494),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: screenHeight * 0.2,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      enableInfiniteScroll: true,
                      viewportFraction: 1,
                      enlargeCenterPage: false,
                      autoPlay: true,
                      scrollDirection: Axis.horizontal,
                      pauseAutoPlayOnTouch: true,
                      aspectRatio: 1,
                    ),
                    items: state.banners.data?.map((item) {
                      return InkResponse(
                        onTap: () {
                          Uri uri = Uri.parse(item.url ?? '');
                          List<String> segments = uri.pathSegments;
                          String? id;
                          String? type;
                          if (segments.contains("category")) {
                            id = segments.last;
                            type = "category";
                          } else if (segments.contains("diagnostic")) {
                            id = segments.last;
                            type = "diagnostic";
                          }

                          if (id != null && type != null) {
                            if (type == "category") {
                              context.push('/all_tests');
                            } else if (type == "diagnostic") {
                              context.push('/all_tests');
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: item.image ?? '',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (context, url) => Center(
                                child: spinkits.getSpinningLinespinkit(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 1;
                          i <= (state.banners.data?.length ?? 0);
                          i++)
                        Container(
                          margin: EdgeInsets.all(3),
                          height: screenHeight * 0.008,
                          width: currentIndex == i
                              ? screenWidth * 0.025
                              : screenWidth * 0.014,
                          decoration: BoxDecoration(
                            color: currentIndex == i
                                ? primaryColor
                                : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: scans
                          .asMap()
                          .entries
                          .map(
                            (entry) => Padding(
                              padding: EdgeInsets.only(
                                  right: entry.key < scans.length - 1 ? 11 : 0),
                              child: ScanCard(
                                scan: entry.value,
                                screenWidth: screenWidth,
                                latLang: lat_lang,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Radiology Tests',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: screenWidth * 0.41,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.radiologyTestModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final radiologyTest =
                            state.radiologyTestModel.data?[index];
                        return InkResponse(
                          onTap: () {
                            Future.delayed(Duration(milliseconds: 200), () {
                              context.push(
                                  '/test_details?location=${radiologyTest?.diagnosticCentre} - ${radiologyTest?.distance}&id=${radiologyTest?.id ?? ""}');
                            });
                          },
                          child: Container(
                            width: screenWidth * 0.8,
                            margin: EdgeInsets.only(
                                right: 12), // Add spacing between items
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff949494), width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.25,
                                      height: screenWidth * 0.28,
                                      decoration: BoxDecoration(),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: radiologyTest
                                                    ?.testDetails?.image ??
                                                "",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: spinkits
                                                  .getSpinningLinespinkit(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              color: Colors.grey[200],
                                              child: Icon(
                                                Icons.broken_image,
                                                color: Colors.grey[400],
                                                size: 40,
                                              ),
                                            ),
                                          )),
                                    ),
                                    Container(
                                      width: screenWidth * 0.47,
                                      child: Column(
                                        spacing: 2,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            radiologyTest
                                                    ?.testDetails?.testName ??
                                                '',
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '₹ ${radiologyTest?.testDetails?.price ?? 0}/-',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'No of tests : ${radiologyTest?.testDetails?.noOfTests ?? 0}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                // const Divider(
                                //   height: 12,
                                //   color: Color(0xffE6E6E6),
                                //   thickness: 1,
                                // ),
                                // Row(
                                //   children: [
                                //     if (labTests?.testDetails
                                //             ?.fastingRequired ==
                                //         true) ...[
                                //       Image.asset(
                                //           'assets/ForkKnife.png',
                                //           scale: 2.5),
                                //       const SizedBox(width: 8),
                                //       const Text(
                                //         'Fast Required',
                                //         style: TextStyle(
                                //           color:
                                //               Color(0xff555555),
                                //           fontFamily: 'Poppins',
                                //           fontSize: 12,
                                //           fontWeight:
                                //               FontWeight.w400,
                                //         ),
                                //       ),
                                //     ],
                                //     Spacer(),
                                //     Image.asset('assets/file.png',
                                //         scale: 2.5),
                                //     SizedBox(width: 8),
                                //     Text(
                                //       'Reports in ${labTests?.testDetails?.reportsDeliveredIn ?? 0} min',
                                //       style: const TextStyle(
                                //         color: Color(0xff555555),
                                //         fontFamily: 'Poppins',
                                //         fontSize: 12,
                                //         fontWeight:
                                //             FontWeight.w400,
                                //       ),
                                //     ),
                                //   ],
                                // ),

                                // SizedBox(height: 5),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment
                                //           .spaceBetween,
                                //   children: [
                                //     ElevatedButton(
                                //       onPressed: () {
                                //         // Navigator.push(
                                //         //     context,
                                //         //     MaterialPageRoute(
                                //         //         builder: (context) =>
                                //         //             TestDetails()));
                                //
                                //         // showSubTestsDialog(context,
                                //         //     labTests.subTests ?? []);
                                //       },
                                //       style: ElevatedButton
                                //           .styleFrom(
                                //         backgroundColor:
                                //             Colors.white,
                                //         side: BorderSide(
                                //             color: primaryColor),
                                //         shape:
                                //             RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius
                                //                   .circular(30),
                                //         ),
                                //         elevation: 0,
                                //         visualDensity:
                                //             VisualDensity.compact,
                                //       ),
                                //       child: Text(
                                //         'View Detail',
                                //         style: TextStyle(
                                //             color: primaryColor,
                                //             fontFamily:
                                //                 "Poppins"),
                                //       ),
                                //     ),
                                //     BlocBuilder<CartCubit,
                                //         CartState>(
                                //       builder:
                                //           (context, cartState) {
                                //         bool isLoading = cartState
                                //                 is CartLoadingState &&
                                //             cartState.testId ==
                                //                 labTests.id;
                                //         return ElevatedButton(
                                //           onPressed: isLoading
                                //               ? null
                                //               : () {
                                //                   if (labTests
                                //                           .existInCart ??
                                //                       false) {
                                //                     context
                                //                         .read<
                                //                             CartCubit>()
                                //                         .removeFromCart(
                                //                             labTests.id ??
                                //                                 "",
                                //                             context);
                                //                   } else {
                                //                     context
                                //                         .read<
                                //                             CartCubit>()
                                //                         .addToCart({
                                //                       "test":
                                //                           "${labTests.id}"
                                //                     }, context);
                                //                   }
                                //                 },
                                //           style: ElevatedButton
                                //               .styleFrom(
                                //                   visualDensity:
                                //                       VisualDensity
                                //                           .compact,
                                //                   backgroundColor:
                                //                       labTests.existInCart ??
                                //                               false
                                //                           ? primaryColor
                                //                           : primaryColor,
                                //                   shape:
                                //                       RoundedRectangleBorder(
                                //                     borderRadius:
                                //                         BorderRadius
                                //                             .circular(
                                //                                 30),
                                //                   ),
                                //                   elevation: 0),
                                //           child: isLoading
                                //               ? const SizedBox(
                                //                   width: 20,
                                //                   height: 20,
                                //                   child:
                                //                       CircularProgressIndicator(
                                //                     color: Colors
                                //                         .white,
                                //                     strokeWidth:
                                //                         2,
                                //                   ),
                                //                 )
                                //               : Row(
                                //                   children: [
                                //                     Text(
                                //                       labTests.existInCart ??
                                //                               false
                                //                           ? 'Remove'
                                //                           : 'Add Test',
                                //                       style: TextStyle(
                                //                           color: Colors
                                //                               .white,
                                //                           fontFamily:
                                //                               "Poppins"),
                                //                     ),
                                //                     SizedBox(
                                //                       width: 10,
                                //                     ),
                                //                     labTests.existInCart ??
                                //                             false
                                //                         ? Icon(
                                //                             Icons
                                //                                 .cancel_outlined,
                                //                             color:
                                //                                 Colors.white,
                                //                           )
                                //                         : Icon(
                                //                             Icons
                                //                                 .add_circle_outline,
                                //                             color:
                                //                                 Colors.white,
                                //                           )
                                //                   ],
                                //                 ),
                                //         );
                                //       },
                                //     ),
                                //   ],
                                // ),
                                if (radiologyTest?.distance != null) ...[
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xffD40000).withOpacity(0.6)),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Colors.white, size: 15),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            '${radiologyTest?.diagnosticCentre} - ${radiologyTest?.distance} away',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Container(
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  //       decoration: BoxDecoration(
                  //           color: Color(0xffEAEBF4),
                  //           borderRadius: BorderRadius.circular(8),
                  //           border:
                  //               Border.all(color: Color(0xffEAEBF4), width: 1)),
                  //       child: Row(
                  //         spacing: 8,
                  //         children: [
                  //           Icon(
                  //             Icons.call,
                  //             size: 16,
                  //           ),
                  //           Text(
                  //             'Call',
                  //             style: TextStyle(
                  //                 color: Color(0xff1D1D1D),
                  //                 fontWeight: FontWeight.w600,
                  //                 fontFamily: 'Poppins',
                  //                 fontSize: 10),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //     Bounce(
                  //       scaleFactor: 0.8,
                  //       onTap: () {
                  //         context.push('/prescription');
                  //       },
                  //       child: Container(
                  //         padding:
                  //             EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  //         decoration: BoxDecoration(
                  //             color: Color(0xffEAEBF4),
                  //             borderRadius: BorderRadius.circular(8),
                  //             border:
                  //                 Border.all(color: Color(0xffEAEBF4), width: 1)),
                  //         child: Row(
                  //           spacing: 8,
                  //           children: [
                  //             Icon(
                  //               Icons.file_present_sharp,
                  //               size: 16,
                  //             ),
                  //             Text(
                  //               'Upload Prescription',
                  //               style: TextStyle(
                  //                   color: Color(0xff1D1D1D),
                  //                   fontWeight: FontWeight.w600,
                  //                   fontFamily: 'Poppins',
                  //                   fontSize: 10),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       padding:
                  //           EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  //       decoration: BoxDecoration(
                  //           color: Color(0xffEAEBF4),
                  //           borderRadius: BorderRadius.circular(8),
                  //           border:
                  //               Border.all(color: Color(0xffEAEBF4), width: 1)),
                  //       child: Row(
                  //         spacing: 8,
                  //         children: [
                  //           Image.asset(
                  //             'assets/whatsp.png',
                  //             scale: 5,
                  //           ),
                  //           Text(
                  //             'What’s up call',
                  //             style: TextStyle(
                  //                 color: Color(0xff1D1D1D),
                  //                 fontWeight: FontWeight.w600,
                  //                 fontFamily: 'Poppins',
                  //                 fontSize: 10),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(height: 8),
                  // Ensure the grid fits within the scrollable area
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 12,
                    // Number of category items
                    itemBuilder: (context, index) {
                      final category = state.categories.category?[index];
                      return _buildCategoryItem(category?.image ?? '',
                          category?.categoryName ?? '', category?.id ?? '');
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Regular Tests',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                        fontFamily: "Poppins"),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: screenWidth * 0.41,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.regulartestModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final regularTest = state.regulartestModel.data?[index];
                        return InkResponse(
                          onTap: () {
                            Future.delayed(Duration(milliseconds: 200), () {
                              context.push(
                                  '/test_details?location=${regularTest?.diagnosticCentre} - ${regularTest?.distance}&id=${regularTest?.id ?? ""}');
                            });
                          },
                          child: Container(
                            width: screenWidth * 0.8,
                            margin: EdgeInsets.only(
                                right: 12), // Add spacing between items
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xff949494), width: 0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.25,
                                      height: screenWidth * 0.28,
                                      decoration: BoxDecoration(),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: regularTest
                                                    ?.testDetails?.image ??
                                                "",
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                Center(
                                              child: spinkits
                                                  .getSpinningLinespinkit(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              color: Colors.grey[200],
                                              child: Icon(
                                                Icons.broken_image,
                                                color: Colors.grey[400],
                                                size: 40,
                                              ),
                                            ),
                                          )),
                                    ),
                                    Container(
                                      width: screenWidth * 0.47,
                                      child: Column(
                                        spacing: 2,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            regularTest
                                                    ?.testDetails?.testName ??
                                                '',
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            '₹ ${regularTest?.testDetails?.price ?? 0}/-',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text(
                                            'No of tests : ${regularTest?.testDetails?.noOfTests ?? 0}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                // const Divider(
                                //   height: 12,
                                //   color: Color(0xffE6E6E6),
                                //   thickness: 1,
                                // ),
                                // Row(
                                //   children: [
                                //     if (labTests?.testDetails
                                //             ?.fastingRequired ==
                                //         true) ...[
                                //       Image.asset(
                                //           'assets/ForkKnife.png',
                                //           scale: 2.5),
                                //       const SizedBox(width: 8),
                                //       const Text(
                                //         'Fast Required',
                                //         style: TextStyle(
                                //           color:
                                //               Color(0xff555555),
                                //           fontFamily: 'Poppins',
                                //           fontSize: 12,
                                //           fontWeight:
                                //               FontWeight.w400,
                                //         ),
                                //       ),
                                //     ],
                                //     Spacer(),
                                //     Image.asset('assets/file.png',
                                //         scale: 2.5),
                                //     SizedBox(width: 8),
                                //     Text(
                                //       'Reports in ${labTests?.testDetails?.reportsDeliveredIn ?? 0} min',
                                //       style: const TextStyle(
                                //         color: Color(0xff555555),
                                //         fontFamily: 'Poppins',
                                //         fontSize: 12,
                                //         fontWeight:
                                //             FontWeight.w400,
                                //       ),
                                //     ),
                                //   ],
                                // ),

                                // SizedBox(height: 5),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment
                                //           .spaceBetween,
                                //   children: [
                                //     ElevatedButton(
                                //       onPressed: () {
                                //         // Navigator.push(
                                //         //     context,
                                //         //     MaterialPageRoute(
                                //         //         builder: (context) =>
                                //         //             TestDetails()));
                                //
                                //         // showSubTestsDialog(context,
                                //         //     labTests.subTests ?? []);
                                //       },
                                //       style: ElevatedButton
                                //           .styleFrom(
                                //         backgroundColor:
                                //             Colors.white,
                                //         side: BorderSide(
                                //             color: primaryColor),
                                //         shape:
                                //             RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius
                                //                   .circular(30),
                                //         ),
                                //         elevation: 0,
                                //         visualDensity:
                                //             VisualDensity.compact,
                                //       ),
                                //       child: Text(
                                //         'View Detail',
                                //         style: TextStyle(
                                //             color: primaryColor,
                                //             fontFamily:
                                //                 "Poppins"),
                                //       ),
                                //     ),
                                //     BlocBuilder<CartCubit,
                                //         CartState>(
                                //       builder:
                                //           (context, cartState) {
                                //         bool isLoading = cartState
                                //                 is CartLoadingState &&
                                //             cartState.testId ==
                                //                 labTests.id;
                                //         return ElevatedButton(
                                //           onPressed: isLoading
                                //               ? null
                                //               : () {
                                //                   if (labTests
                                //                           .existInCart ??
                                //                       false) {
                                //                     context
                                //                         .read<
                                //                             CartCubit>()
                                //                         .removeFromCart(
                                //                             labTests.id ??
                                //                                 "",
                                //                             context);
                                //                   } else {
                                //                     context
                                //                         .read<
                                //                             CartCubit>()
                                //                         .addToCart({
                                //                       "test":
                                //                           "${labTests.id}"
                                //                     }, context);
                                //                   }
                                //                 },
                                //           style: ElevatedButton
                                //               .styleFrom(
                                //                   visualDensity:
                                //                       VisualDensity
                                //                           .compact,
                                //                   backgroundColor:
                                //                       labTests.existInCart ??
                                //                               false
                                //                           ? primaryColor
                                //                           : primaryColor,
                                //                   shape:
                                //                       RoundedRectangleBorder(
                                //                     borderRadius:
                                //                         BorderRadius
                                //                             .circular(
                                //                                 30),
                                //                   ),
                                //                   elevation: 0),
                                //           child: isLoading
                                //               ? const SizedBox(
                                //                   width: 20,
                                //                   height: 20,
                                //                   child:
                                //                       CircularProgressIndicator(
                                //                     color: Colors
                                //                         .white,
                                //                     strokeWidth:
                                //                         2,
                                //                   ),
                                //                 )
                                //               : Row(
                                //                   children: [
                                //                     Text(
                                //                       labTests.existInCart ??
                                //                               false
                                //                           ? 'Remove'
                                //                           : 'Add Test',
                                //                       style: TextStyle(
                                //                           color: Colors
                                //                               .white,
                                //                           fontFamily:
                                //                               "Poppins"),
                                //                     ),
                                //                     SizedBox(
                                //                       width: 10,
                                //                     ),
                                //                     labTests.existInCart ??
                                //                             false
                                //                         ? Icon(
                                //                             Icons
                                //                                 .cancel_outlined,
                                //                             color:
                                //                                 Colors.white,
                                //                           )
                                //                         : Icon(
                                //                             Icons
                                //                                 .add_circle_outline,
                                //                             color:
                                //                                 Colors.white,
                                //                           )
                                //                   ],
                                //                 ),
                                //         );
                                //       },
                                //     ),
                                //   ],
                                // ),
                                if (regularTest?.distance != null) ...[
                                  Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xffD40000).withOpacity(0.6)),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            color: Colors.white, size: 15),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            '${regularTest?.diagnosticCentre} - ${regularTest?.distance} away',
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Diagnostic Centres',
                  //       style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w500,
                  //           color: primaryColor,
                  //           fontFamily: "Poppins"),
                  //     ),
                  //     InkResponse(
                  //       onTap: () {
                  //         context.push('/diagnostic_center/$lat_lang');
                  //       },
                  //       child: Text(
                  //         'See All',
                  //         style: TextStyle(
                  //             fontSize: 18,
                  //             fontWeight: FontWeight.w500,
                  //             color: primaryColor,
                  //             fontFamily: "Poppins"),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 8),
                  // GridView.builder(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     childAspectRatio: 1,
                  //     crossAxisSpacing: 5,
                  //   ),
                  //   itemCount: state.diagnosticCenters.data?.length,
                  //   itemBuilder: (context, index) {
                  //     final dignosticCenter =
                  //         state.diagnosticCenters.data?[index];
                  //     var w = MediaQuery.of(context).size.width;
                  //     return Column(
                  //       children: [
                  //         InkResponse(
                  //           onTap: () {
                  //             context.push(
                  //                 '/diognostic_information?diognosticId=${dignosticCenter?.id ?? ''}');
                  //           },
                  //           child: Container(
                  //             width: w * 0.435,
                  //             height: w * 0.4,
                  //             padding: EdgeInsets.only(left: 15, right: 15),
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(10),
                  //               border: Border.all(color: primaryColor, width: 1),
                  //             ),
                  //             child: ClipOval(
                  //               child: Image.network(
                  //                 dignosticCenter?.image ?? '',
                  //                 fit: BoxFit.contain,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         SizedBox(height: 8),
                  //       ],
                  //     );
                  //   },
                  // ),
                  // SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      context.push('/all_tests?lat_lang=$lat_lang');
                    },
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 1),
                        // Adjusted size to fit the circle
                      ),
                      child: Column(
                        children: [
                          Text(
                            "want to compare all labs?",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: primaryColor),
                            child: Row(
                              children: [
                                Text(
                                  "Explore Lab Tests",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Image.asset(
                                  "assets/explore.png",
                                  width: 22,
                                  height: 22,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text("No Data"));
      }),
    );
  }

  Widget _buildCategoryItem(String image, String label, String catId) {
    return Column(
      children: [
        TouchRipple(
            rippleBorderRadius: BorderRadius.circular(8),
            previewDuration: Duration(milliseconds: 1000),
            onTap: () {
              // Delay navigation to allow ripple effect to show
              Future.delayed(const Duration(milliseconds: 200), () {
                context.push(
                    '/all_tests?catId=${catId}&lat_lang=${lat_lang}&catName=${label}');
              });
            },
            child: Container(
              width: 70,
              height: 70,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(8), // Rounded square outer container
                border: Border.all(color: Color(0xffE9E9E9), width: 1),
              ),
              child: Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: spinkits.getSpinningLinespinkit(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey[400],
                          size: 40,
                        ),
                      ),
                    )),
              ),
            )),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontFamily: "Poppins",
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 1, // Ensure text stays in one line
        ),
      ],
    );
  }
}

Widget _shimmer(BuildContext context) {
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      shimmerText(120, 12, context),
                      shimmerCircle(35, context),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      shimmerCircle(25, context),
                      SizedBox(
                        width: 10,
                      ),
                      shimmerText(120, 12, context),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  shimmerContainer(w, 30, context),
                  SizedBox(
                    height: 16,
                  ),
                  shimmerContainer(w, 180, context),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      shimmerCircle(12, context),
                      SizedBox(
                        width: 6,
                      ),
                      shimmerCircle(12, context),
                      SizedBox(
                        width: 6,
                      ),
                      shimmerCircle(12, context),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  shimmerText(160, 16, context),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 5,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          shimmerContainer(72, 72, context),
                          SizedBox(
                            height: 5,
                          ),
                          shimmerText(60, 12, context)
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  shimmerText(160, 16, context),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.9,
                      mainAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          shimmerContainer(150, 140, context),
                          SizedBox(
                            height: 10,
                          ),
                          shimmerText(70, 12, context)
                        ],
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}
