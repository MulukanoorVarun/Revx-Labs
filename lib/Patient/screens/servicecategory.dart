import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/category/category_cubit.dart';
import 'package:revxpharma/Patient/screens/alltests.dart';
import 'package:revxpharma/Utils/color.dart';

import '../../Utils/constants.dart';

class ServiceCategory extends StatefulWidget {
  final String latlngs;
  final String query;
  const ServiceCategory(
      {super.key, required this.latlngs, required this.query});
  @override
  State<ServiceCategory> createState() => _ServiceCategoryState();
}

// Function to calculate responsive aspect ratio
double _getResponsiveAspectRatio(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  const crossAxisCount = 3; // Same as in gridDelegate
  final itemWidth = screenWidth / crossAxisCount;
  // Increased height multiplier to accommodate multi-line text
  final itemHeight = itemWidth * 1.42; // Adjusted from 1.2 to 1.5
  return itemWidth / itemHeight;
}

class _ServiceCategoryState extends State<ServiceCategory> {
  @override
  void initState() {
    context.read<CategoryCubit>().fetchCategories(widget.query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.query != "" ? true : false,
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
      body: BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        if (state is CategoryLoading) {
          return _shimmer(context);
        } else if (state is CategoryLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(10),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: _getResponsiveAspectRatio(context),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final item = state.categories.category?[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                context.push(
                                  Uri(
                                    path: '/all_tests',
                                    queryParameters: {
                                      'lat_lang': '${widget.latlngs}',
                                      'catId': item.id ?? "",
                                      'catName': item.categoryName ?? "",
                                      'diagnosticID': '',
                                    },
                                  ).toString(),
                                );
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 100,
                                height: 100,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Color(0xffE9E9E9), width: 1),
                                  color: Colors.white, // Added for better contrast
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child:
                                    CachedNetworkImage(
                                      imageUrl: item!.image??"",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: spinkits.getSpinningLinespinkit(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            color: Colors.grey[200],
                                            child: Icon(
                                              Icons.broken_image,
                                              color: Colors.grey[400],
                                              size: 40,
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8), // Increased spacing
                            Flexible(
                              // Added Flexible to allow text to wrap
                              child: Text(
                                item.categoryName ?? 'Unknown',
                                maxLines: 2, // Allow up to 2 lines
                                overflow: TextOverflow.ellipsis, // Handle overflow gracefully
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12, // Slightly reduced for balance
                                  color: Colors.black87,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  height: 1.3, // Improved line height for readability
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      childCount: state.categories.category?.length ?? 0,
                    ),
                  ),
                ),
              ],
            ),
          );
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
                      screenWidth * 0.25, screenWidth * 0.25, context),
                  const SizedBox(height: 5),
                  shimmerText(
                      screenWidth * 0.2, // 20% of screen width
                      12,
                      context),
                ],
              );
            },
          ),
        ],
      ),
    ),
  );
}
