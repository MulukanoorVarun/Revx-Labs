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

class _HomescreenState extends State<Homescreen> {
  int currentIndex = 0;
  String lat_lang = '';

  @override
  void initState() {
    // Future.delayed(Duration.zero, () {
    // _checkAndShowPopup();
    // });
    context.read<HomeCubit>().fetchHomeData(lat_lang);
    context.read<CartCubit>().getCartList();
    super.initState();
  }

  Future<void> _checkAndShowPopup() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool? isFirstTime = prefs.getBool('isFirstTime') ?? true;
    //
    // if (isFirstTime == null || isFirstTime) {
    _showPopup(context);
    // prefs.setBool('isFirstTime', false);
    // }
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Dialog(
                insetPadding:
                    EdgeInsets.symmetric(horizontal: 24, vertical: 200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Bounce(
                            scaleFactor: 1.3,
                            onTap: () {},
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Color(0xff2D3894)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/ct-scan.png',
                                    fit: BoxFit.contain,
                                    height: 48,
                                    width: 48,
                                  ),
                                  Text(
                                    'Scan',
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 11),
                          Bounce(
                            scaleFactor: 1.3,
                            onTap: () {
                              context.pop();
                              context.push('/all_tests');
                            },
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Color(0xff2D3894)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/blood-test 1.png',
                                    fit: BoxFit.contain,
                                    height: 48,
                                    width: 48,
                                  ),
                                  Text(
                                    'Test’s',
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 11),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Bounce(
                            scaleFactor: 1.3,
                            onTap: () {},
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Color(0xff2D3894)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/x-rays 1.png',
                                    fit: BoxFit.contain,
                                    height: 48,
                                    width: 48,
                                  ),
                                  Text(
                                    'X-Ray’s',
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 11),
                          Bounce(
                            scaleFactor: 1.3,
                            onTap: () {},
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: Color(0xff2D3894)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/healthcare 1.png',
                                    fit: BoxFit.contain,
                                    height: 48,
                                    width: 48,
                                  ),
                                  Text(
                                    'Package’s',
                                    style: TextStyle(
                                      color: Color(0xff000000),
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 160,
              left: MediaQuery.of(context).size.width * 0.42,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.cancel,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomeLoading) {
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
                            smallSize: 12,
                            largeSize: 16,
                            child: Bounce(
                              scaleFactor: 1.2,
                              onTap: () {
                                context.push('/appointments');
                              },
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: primaryColor,
                                size: 28,
                              ),
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
                    context.push('/search_screen');
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(top: 8, bottom: 10),
                    decoration: BoxDecoration(
                        color: Color(0xffF9F9F9),
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Color(0xffE9E9E9), width: 1)),
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
                    for (int i = 1; i <= (state.banners.data?.length ?? 0); i++)
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Bounce(
                      scaleFactor: 1.1,
                      onTap: () {},
                      child: Container(
                        width: screenWidth * 0.435,
                        height: screenWidth * 0.4,
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Color(0xff2D3894), width: 1),
                          // Adjusted size to fit the circle
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Image.asset(
                              'assets/ct-scan.png',
                              fit: BoxFit.contain,
                              height: screenWidth * 0.24,
                              width: screenWidth * 0.24,
                            ),
                            Text(
                              'Book My Scan',
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Bounce(
                      scaleFactor: 1.1,
                      onTap: () {},
                      child: Container(
                        width: screenWidth * 0.435,
                        height: screenWidth * 0.4,
                        padding: EdgeInsets.only(left: 15, right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                            Border.all(color: Color(0xff2D3894), width: 1)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            Image.asset(
                              'assets/x-rays 1.png',
                              fit: BoxFit.contain,
                              height: screenWidth * 0.24,
                              width: screenWidth * 0.24,
                            ),
                            Text(
                              'X-Ray’s',
                              style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Bounce(
                    //   scaleFactor: 1.1,
                    //   onTap: () {
                    //     context.push('/all_tests');
                    //   },
                    //   child: Container(
                    //     width: screenWidth * 0.435,
                    //     height: screenWidth * 0.4,
                    //     padding: EdgeInsets.only(left: 15, right: 15),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         border:
                    //             Border.all(color: Color(0xff2D3894), width: 1)),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       spacing: 10,
                    //       children: [
                    //         Image.asset(
                    //           'assets/blood-test 1.png',
                    //           fit: BoxFit.contain,
                    //           height: screenWidth * 0.24,
                    //           width: screenWidth * 0.24,
                    //         ),
                    //         Text(
                    //           'Test’s',
                    //           style: TextStyle(
                    //               color: Color(0xff000000),
                    //               fontSize: 14,
                    //               fontFamily: 'Poppins',
                    //               fontWeight: FontWeight.w600),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                // SizedBox(
                //   height: 11,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Bounce(
                //       scaleFactor: 1.1,
                //       onTap: () {},
                //       child: Container(
                //         width: screenWidth * 0.435,
                //         height: screenWidth * 0.4,
                //         padding: EdgeInsets.only(left: 15, right: 15),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             border:
                //                 Border.all(color: Color(0xff2D3894), width: 1)),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           spacing: 10,
                //           children: [
                //             Image.asset(
                //               'assets/x-rays 1.png',
                //               fit: BoxFit.contain,
                //               height: screenWidth * 0.24,
                //               width: screenWidth * 0.24,
                //             ),
                //             Text(
                //               'X-Ray’s',
                //               style: TextStyle(
                //                   color: Color(0xff000000),
                //                   fontSize: 14,
                //                   fontFamily: 'Poppins',
                //                   fontWeight: FontWeight.w600),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 11,
                //     ),
                //     Bounce(
                //       scaleFactor: 1.1,
                //       onTap: () {},
                //       child: Container(
                //         width: screenWidth * 0.435,
                //         height: screenWidth * 0.4,
                //         padding: EdgeInsets.only(left: 15, right: 15),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10),
                //             border:
                //                 Border.all(color: Color(0xff2D3894), width: 1)),
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           spacing: 10,
                //           children: [
                //             Image.asset(
                //               'assets/healthcare 1.png',
                //               fit: BoxFit.contain,
                //               height: screenWidth * 0.24,
                //               width: screenWidth * 0.24,
                //             ),
                //             Text(
                //               'Package’s',
                //               style: TextStyle(
                //                   color: Color(0xff000000),
                //                   fontSize: 14,
                //                   fontFamily: 'Poppins',
                //                   fontWeight: FontWeight.w600),
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Color(0xffEAEBF4), width: 1)),
                      child: Row(
                        spacing: 8,
                        children: [
                          Icon(
                            Icons.call,
                            size: 16,
                          ),
                          Text(
                            'Call',
                            style: TextStyle(
                                color: Color(0xff1D1D1D),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Bounce(
                      scaleFactor: 0.8,
                      onTap: () {
                        _bottomsheet(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                Border.all(color: Color(0xffEAEBF4), width: 1)),
                        child: Row(
                          spacing: 8,
                          children: [
                            Icon(
                              Icons.file_present_sharp,
                              size: 16,
                            ),
                            Text(
                              'Upload Prescription',
                              style: TextStyle(
                                  color: Color(0xff1D1D1D),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Color(0xffEAEBF4), width: 1)),
                      child: Row(
                        spacing: 8,
                        children: [
                          Image.asset(
                            'assets/whatsp.png',
                            scale: 5,
                          ),
                          Text(
                            'What’s up call',
                            style: TextStyle(
                                color: Color(0xff1D1D1D),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
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
                  itemCount: state.categories.category?.length,
                  // Number of category items
                  itemBuilder: (context, index) {
                    final category = state.categories.category?[index];
                    return _buildCategoryItem(category?.image ?? '',
                        category?.categoryName ?? '', category?.id ?? '');
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Diagnostic Centres',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: primaryColor,
                          fontFamily: "Poppins"),
                    ),
                    InkResponse(
                      onTap: () {
                        print("Latlng::${lat_lang}");
                        context.push('/diognostic_center');
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: primaryColor,
                            fontFamily: "Poppins"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: state.diagnosticCenters.data?.length,
                  itemBuilder: (context, index) {
                    final dignosticCenter =
                        state.diagnosticCenters.data?[index];
                    var w = MediaQuery.of(context).size.width;
                    return Column(
                      children: [
                        InkResponse(
                          onTap: () {
                            context.push(
                                '/diognostic_information?diognosticId=${dignosticCenter?.id ?? ''}');
                          },
                          child: Container(
                            width: w * 0.435,
                            height: w * 0.4,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: primaryColor, width: 1),
                              // Adjusted size to fit the circle
                            ),
                            child: Image.network(
                              dignosticCenter?.image ?? '',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  },
                ),
                SizedBox(height: 8),

                InkWell(
                  onTap: () {
                    context.push('/all_tests');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
    });
  }

  Future _bottomsheet(BuildContext context) {
    final h = MediaQuery.of(context).size.width;
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: h * 0.8,
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 3,
                  decoration: BoxDecoration(
                      color: CupertinoColors.inactiveGray,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              Image.asset(
                'assets/file_upload.png',
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Text(
                'Upload Your Prescription',
                style: TextStyle(
                    color: Color(0xff1A1A1A),
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400),
              ),

              Row(
                spacing: 10,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: primaryColor,
                    ),
                    child: Row(
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          size: 16,
                          color: Color(0xffffffff),
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: primaryColor, width: 1)),
                    child: Row(
                      spacing: 10,
                      children: [
                        Icon(
                          Icons.photo,
                          size: 16,
                          color: Color(0xff202020),
                        ),
                        Text(
                          'Gallery',
                          style: TextStyle(
                            color: Color(0xff202020),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: Color(0xffC5B8B8),
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: 'Note: ',
                  style: TextStyle(
                    color: Color(0xff1A1A1A),
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Prescription should Contains',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Poppins',
                        color: Color(0xff1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: Color(0xffEAEBF4),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Stethoscope.png',
                            scale: 3,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            'Doctor\nDetails',
                            style: TextStyle(
                                color: Color(0xff1A1A1A),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xffEAEBF4),
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      spacing: 6,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/CalendarDots.png',
                          scale: 3,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          'Date of\nPresription ',
                          style: TextStyle(
                              color: Color(0xff1A1A1A),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                        color: Color(0xffEAEBF4),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/UserList.png',
                            scale: 3,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            'Patient\nDetails',
                            style: TextStyle(
                                color: Color(0xff1A1A1A),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: Color(0xffEAEBF4),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Column(
                        spacing: 6,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Pill.png',
                            scale: 3,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            'Dosage\nDetails',
                            style: TextStyle(
                                color: Color(0xff1A1A1A),
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
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
              context.push('/all_tests?catId=${catId}&lat_lang=${lat_lang}&catName=${label}');
            });
          },
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xffE9E9E9), width: 1),
            ),
            child: Center(
              child: Image.network(image, width: 45, height: 45),
            ),
          ),
        ),
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
