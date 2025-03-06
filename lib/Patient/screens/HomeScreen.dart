import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_touch_ripple/components/touch_ripple_context.dart';
import 'package:flutter_touch_ripple/widgets/touch_ripple.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/Location/location_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/Location/location_state.dart';
import 'package:revxpharma/Patient/screens/Profile.dart';
import 'package:revxpharma/Patient/screens/SearchScreen.dart';
import 'package:revxpharma/Patient/screens/servicecategory.dart';
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
    context.read<HomeCubit>().fetchHomeData(lat_lang);
    super.initState();
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
                      InkResponse(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(
                              0xff27BDBE), // Set background color for initials
                          child:
                              // state.prfileDetails.data?.image != null &&
                              //     state.prfileDetails.data!.image!.isNotEmpty
                              //     ? ClipRRect(
                              //   borderRadius: BorderRadius.circular(50), // Ensures it's circular
                              //   child: Image.network(
                              //     state.prfileDetails.data!.image!,
                              //     fit: BoxFit.cover,
                              //     width: double.infinity,
                              //     height: double.infinity,
                              //   ),
                              // )
                              //     :
                              Text(
                            state.prfileDetails.data?.fullName?.isNotEmpty ==
                                    true
                                ? state.prfileDetails.data!.fullName![0]
                                    .toUpperCase()
                                : "?",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                InkResponse(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Searchscreen(lat_lang: lat_lang)));
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => alltests(
                                    lat_lang: "",
                                    catId: id ?? "",
                                    catName: '',
                                    diagnosticID: id ?? "",
                                  ),
                                ));
                          } else if (type == "diagnostic") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => alltests(
                                    lat_lang: "",
                                    catId: '',
                                    catName: '',
                                    diagnosticID: id ?? "",
                                  ),
                                ));
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
                              ? Color(0xff27BDBE)
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff27BDBE),
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
                          color: Color(0xff27BDBE),
                          fontFamily: "Poppins"),
                    ),
                    InkResponse(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Diagnosticcenter(lat_lng: lat_lang),
                          ),
                        );
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff27BDBE),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DiagnosticInformation(
                                  diognosticId: dignosticCenter?.id ?? '',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: w * 0.435,
                            height: w * 0.4,
                            padding: EdgeInsets.only(left: 15, right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color(0xff27BDBE), width: 1),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => alltests(
                          lat_lang: lat_lang ?? '',
                          catId: '',
                          catName: '',
                          diagnosticID: "",
                        ), // Adjust the index as needed
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xff27BDBE), width: 1),
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
                              color: Color(0xff27BDBE)),
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

  Widget _buildCategoryItem(String image, String label, String catId) {
    return Column(
      children: [
        TouchRipple(
          rippleBorderRadius: BorderRadius.circular(8),
          previewDuration: Duration(milliseconds: 1000),
          onTap: () {
            // Delay navigation to allow ripple effect to show
            Future.delayed(const Duration(milliseconds: 200), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => alltests(
                    lat_lang: lat_lang,
                    catId: catId,
                    catName: label,
                    diagnosticID: "",
                  ),
                ),
              );
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
