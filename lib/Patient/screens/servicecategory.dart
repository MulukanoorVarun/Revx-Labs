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
      body:
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        if (state is CategoryLoading) {
          return _shimmer(context);
        } else if (state is CategoryLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                      EdgeInsets.all(10), // Consistent padding around the grid
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of columns
                      childAspectRatio: _getResponsiveAspectRatio(context),
                      crossAxisSpacing: 10, // Spacing between columns
                      mainAxisSpacing: 10, // Spacing between rows
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final item =
                            state.categories.category?[index]; // Current item
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
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
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                width: 100,
                                height: 100,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Color(0xffE9E9E9), width: 1),
                                ),
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: CachedNetworkImage(
                                            imageUrl: item!.image!,
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
                                          )
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              item?.categoryName ?? 'Unknown',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                      childCount:
                          state.categories.category?.length ?? 0, // Total items
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
