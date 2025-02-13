import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  void _navigateToDetailScreen(BuildContext context, String name) {
    Widget detailScreen;

    switch (name) {
      case 'Pregnancy':
        detailScreen = Pregnancy(title: "Pregnancy");
        break;
      case 'MRI Scan':
        detailScreen = Pregnancy(
          title: "MRI Scan",
        );
        break;
      case 'CBC':
        detailScreen = Pregnancy(
          title: "CBC",
        );
        break;
      case 'Allergy':
        detailScreen = Pregnancy(
          title: "Allergy",
        );
        break;
      case 'Bone':
        detailScreen = Pregnancy(
          title: "Bone",
        );
        break;
      case 'Health':
        detailScreen = Pregnancy(
          title: "Health",
        );
        break;
      case 'Covid':
        detailScreen = Pregnancy(
          title: "Covid",
        );
        break;
      case 'Immunity':
        detailScreen = Pregnancy(
          title: "Immunity",
        );
        break;
      case 'Infertility':
        detailScreen = Pregnancy(
          title: "Infertility",
        );
        break;
      case 'Women Health':
        detailScreen = Pregnancy(
          title: "Women Health",
        );
        break;
      case 'Full Body check up':
        detailScreen = Pregnancy(
          title: "Full Body check up",
        );
        break;
      case 'Thyroid':
        detailScreen = Pregnancy(
          title: "Thyroid",
        );
        break;
      case 'Lungs':
        detailScreen = Pregnancy(
          title: "Lungs",
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

      default:
        detailScreen = Scaffold(
          appBar: AppBar(title: Text('Details')),
          body: Center(child: Text('No details available')),
        );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => detailScreen),
    );
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
      body: BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
        if (state is CategoryLoading) {
          return Center(child: CircularProgressIndicator()); // 🔄 Show
        } else if (state is CategoryLoaded) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  childAspectRatio: 0.8, // Aspect ratio for items
                ),
                itemCount: state.categories.category?.length, // Total number of items
                itemBuilder: (context, index) {
                  final item = state.categories.category?[index]; // Get the map for the current index
                  return Column(
                    children: [
                      InkResponse(
                        onTap: () {
                          _navigateToDetailScreen(
                              context, item?.categoryName ?? "");
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
        }else if (state is CategoryError) {
          return Center(child: Text(state.message));
        }
        return Center(child: Text("No Data"));
      }),
    );
  }
}
