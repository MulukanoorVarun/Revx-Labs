import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Models/CategoryModel.dart';
import 'package:revxpharma/Patient/logic/cubit/category/category_cubit.dart';
import 'package:revxpharma/Services/UserapiServices.dart';

import 'Pregnancy.dart';

class ServiceCategory extends StatefulWidget {
  const ServiceCategory({super.key});

  @override
  State<ServiceCategory> createState() => _ServiceCategoryState();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff24AEB1)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Service Category",
          style: TextStyle(
            color: Color(0xff24AEB1),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
          ),
        ),
        centerTitle: true, // Centering the title
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff24AEB1)),
      ),
      body:
          BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        if (state is CategoryLoading) {
          return _shimmer(context); // 🔄 Show
        } else if (state is CategoryLoaded) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  childAspectRatio: 0.8, // Aspect ratio for items
                ),
                itemCount:
                    state.categories.category?.length, // Total number of items
                itemBuilder: (context, index) {
                  final item = state.categories
                      .category?[index]; // Get the map for the current index
                  return Column(
                    children: [
                      InkResponse(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Pregnancy(
                                      title: item?.categoryName ?? '')));
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xffE9E9E9), width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            // Padding inside the container
                            child: Image.network(
                              item?.image ??
                                  '', // Load the image using imagePath
                              fit: BoxFit.contain,
                              // Ensures the image does not stretch
                              height: 45,
                              // Height of the image
                              width: 50, // Width of the image
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5), // Space between image and text
                      Text(
                        item?.categoryName ?? '',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        // Display the name from the map
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
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}
