import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Models/CategoryModel.dart';
import 'package:revxpharma/Models/BannersModel.dart';
import 'package:revxpharma/Models/DiognisticCenterModel.dart';
import 'package:revxpharma/Patient/screens/servicecategory.dart';
import 'package:revxpharma/Services/UserapiServices.dart';
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

  @override
  void initState() {
    context.read<HomeCubit>().fetchHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomeLoading) {
        return _shimmer(context); // 🔄 Show loading
      } else if (state is HomeLoaded) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Container(),
            leadingWidth: 0,
            toolbarHeight: 80,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    "Hi, Sandeep",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 6,
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
                    SizedBox(width: 4), // Space between icon and text
                    Text(
                      'Kondapur,Hyderabad',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                  ],
                ), // Space between text and icon
              ],
            ),
            actions: [
              CircleAvatar(
                foregroundImage: AssetImage(
                  'assets/person.png',
                ), // Replace with actual image path
              ),
              SizedBox(width: 16),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 16),
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Diagnostics',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500, fontFamily: "Poppins"),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1.0,
                    height: screenHeight * 0.25,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    viewportFraction: 0.9,
                    pauseAutoPlayOnTouch: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  items: state.banners.data?.map((item) {
                    return InkWell(
                      onTap: () async {},
                      child: Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.02),
                            child: Image.network(
                              item.image ?? "",
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: state.banners.data!.asMap().entries.map((entry) {
                    bool isActive = currentIndex == entry.key;
                    return Container(
                      width: isActive ? 17.0 : 7.0,
                      height: 7.0,
                      margin: EdgeInsets.symmetric(horizontal: 3.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? Color(0xFF00A3FF) : Color(0xFFC9EAF2),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 8),
                // Categories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff27BDBE),
                          fontFamily: "Poppins"),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                // Ensure the grid fits within the scrollable area
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
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
                    print(
                        'Category ID: ${category?.id}, Category Name: ${category?.categoryName}');

                    return InkWell(
                      onTap: () {
                        _handleCategoryTap(
                            context, category?.categoryName ?? '');
                      },
                      child: _buildCategoryItem(
                          category?.image ?? '',
                          category?.categoryName ??
                              ''), // No need for null check
                    );
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
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
                              builder: (context) => Diagnosticcenter(),
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
                ),
                SizedBox(height: 8),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
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
                    )),
                SizedBox(height: 8),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            alltests(), // Adjust the index as needed
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 22),
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

  void _handleCategoryTap(BuildContext context, String label) {
    Widget detailScreen;

    switch (label) {
      case 'Pregnancy':
        detailScreen = Pregnancy(
          title: "Pregnancy",
        );
        break;
      case 'Lungs':
        detailScreen = Pregnancy(
          title: "Lungs",
        );
        break;
      case 'MRI Scan':
        detailScreen = Pregnancy(
          title: "MRI Scan",
        );
        break;
      case 'Health':
        detailScreen = Pregnancy(
          title: "Health",
        );
        break;
      case 'Heart':
        detailScreen = Pregnancy(
          title: "Heart",
        );
        break;
      case 'Kidney':
        detailScreen = Pregnancy(
          title: "Kidney",
        );
        break;
      case 'Blood Test':
        detailScreen = Pregnancy(
          title: "Blood Test",
        );
        break;
      case 'More':
        detailScreen = ServiceCategory(); // Define this screen
        break;
      default:
        detailScreen = Scaffold(
          appBar: AppBar(title: Text('Unknown')),
          body: Center(child: Text('No details available')),
        );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => detailScreen),
    );
  }

  Widget _buildCategoryItem(String image, String label) {
    return Column(
      children: [
        Container(
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

