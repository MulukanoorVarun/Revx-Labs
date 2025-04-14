import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/category/category_cubit.dart';
import 'package:revxpharma/Patient/screens/alltests.dart';
import 'package:revxpharma/Utils/color.dart';

class ServiceCategory extends StatefulWidget {
  final String latlngs;
  const ServiceCategory({super.key,required this.latlngs});
  @override
  State<ServiceCategory> createState() => _ServiceCategoryState();
}

// Function to calculate responsive aspect ratio
double _getResponsiveAspectRatio(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  // Calculate the width of each grid item (screen width divided by number of columns)
  const crossAxisCount = 3; // Same as in gridDelegate
  final itemWidth = screenWidth / crossAxisCount;
  // Define a desired height relative to the item width or screen height
  final itemHeight = itemWidth * 1.2; // Example: height is 1.2 times the width
  // Return the aspect ratio (width / height)
  return itemWidth / itemHeight;
}

class _ServiceCategoryState extends State<ServiceCategory> {
  @override
  void initState() {
    context.read<CategoryCubit>().fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Service Category",
          style: TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      body:
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        if (state is CategoryLoading) {
          return _shimmer(context);
        } else if (state is CategoryLoaded) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  childAspectRatio: _getResponsiveAspectRatio(context), // Dynamic aspect ratio
                  crossAxisSpacing: 10, // Optional: spacing between columns
                  mainAxisSpacing: 10, // Optional: spacing between rows
                ),
                itemCount: state.categories.category?.length, // Total number of items
                itemBuilder: (context, index) {
                  final item = state.categories.category?[index]; // Get the map for the current index
                  return Column(
                    children: [
                      InkResponse(
                        onTap: () {
                          context.push(
                            Uri(
                              path: '/all_tests',
                              queryParameters: {
                                'lat_lang': '${widget.latlngs}',
                                'catId': item?.id ?? "",
                                'catName': item?.categoryName ?? "",
                                'diagnosticID': '',
                              },
                            ).toString(),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffE9E9E9), width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child:  Center(
                            child: CircleAvatar(
                              radius: 38, // Make it slightly smaller than the container
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(item?.image??""),
                              onBackgroundImageError: (_, __) => debugPrint('Image load error'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item?.categoryName ?? '',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ));
        } else if (state is CategoryError) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text("No Data"));
      }),
    );
  }
}

Widget _shimmer(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GridView for shimmer placeholders
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: _getResponsiveAspectRatio(context),
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 15,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  shimmerContainer(
                     screenWidth * 0.25,
                    screenWidth * 0.25,
                    context
                  ),
                  const SizedBox(height: 5),
                  shimmerText(
                   screenWidth * 0.2, // 20% of screen width
                    12,
                    context
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}


