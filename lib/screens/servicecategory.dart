import 'package:flutter/material.dart';

import 'Pregnancy.dart';

class ServiceCategory extends StatefulWidget {
  const ServiceCategory({super.key});

  @override
  State<ServiceCategory> createState() => _ServiceCategoryState();
}

class _ServiceCategoryState extends State<ServiceCategory> {
  final List<Map<String, String>> _imageList = [
    {'imagePath': 'assets/pregnency.png', 'name': 'Pregnancy'},
    {'imagePath': 'assets/mriscan.png', 'name': 'MRI Scan'},
    {'imagePath': 'assets/bloodtext.png', 'name': 'CBC'},
    {'imagePath': 'assets/ellergy.png', 'name': 'Allergy'},
    {'imagePath': 'assets/bone.png', 'name': 'Bone'},
    {'imagePath': 'assets/health.png', 'name': 'Health'},
    {'imagePath': 'assets/COVID.png', 'name': 'Covid'},
    {'imagePath': 'assets/immunity.png', 'name': 'Immunity'},
    {'imagePath': 'assets/infertility.png', 'name': 'Infertility'},
    {'imagePath': 'assets/womanhealth.png', 'name': 'Women Health'},
    {'imagePath': 'assets/fullbodyCheckup.png', 'name': 'Full Body check up'},
    {'imagePath': 'assets/thyroid.png', 'name': 'Thyroid'},
    {'imagePath': 'assets/lungs.png', 'name': 'Lungs'},
    {'imagePath': 'assets/heart.png', 'name': 'Heart'},
    {'imagePath': 'assets/kidney.png', 'name': 'Kidney'},
  ];

  void _navigateToDetailScreen(BuildContext context, String name) {
    Widget detailScreen;

    switch (name) {
      case 'Pregnancy':
        detailScreen = Pregnancy(title: "Pregnancy");
        break;
      case 'MRI Scan':
        detailScreen = Pregnancy(title: "MRI Scan",);
        break;
      case 'CBC':
        detailScreen = Pregnancy(title: "CBC",);
        break;
      case 'Allergy':
        detailScreen = Pregnancy(title: "Allergy",);
        break;
      case 'Bone':
        detailScreen = Pregnancy(title: "Bone",);
        break;
      case 'Health':
        detailScreen = Pregnancy(title: "Health",);
        break;
      case 'Covid':
        detailScreen = Pregnancy(title: "Covid",);
        break;
      case 'Immunity':
        detailScreen = Pregnancy(title: "Immunity",);
        break;
      case 'Infertility':
        detailScreen = Pregnancy(title: "Infertility",);
        break;
      case 'Women Health':
        detailScreen = Pregnancy(title: "Women Health",);
        break;
      case 'Full Body check up':
        detailScreen = Pregnancy(title: "Full Body check up",);
        break;
      case 'Thyroid':
        detailScreen = Pregnancy(title: "Thyroid",);
        break;
      case 'Lungs':
        detailScreen = Pregnancy(title: "Lungs",);
        break;
      case 'Heart':
        detailScreen = Pregnancy(title: "Heart",);
        break;
      case 'Kidney':
        detailScreen = Pregnancy(title: "Kidney",);
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
        centerTitle: true,  // Centering the title
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff24AEB1)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child:GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,  // Number of columns
            childAspectRatio: 0.8,  // Aspect ratio for items
          ),
          itemCount: _imageList.length,  // Total number of items
          itemBuilder: (context, index) {
            final item = _imageList[index];  // Get the map for the current index
            return Column(
              children: [
                InkResponse(
                  onTap:(){
                    _navigateToDetailScreen(context, item['name']!);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffE9E9E9), width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),  // Padding inside the container
                      child: Image.asset(
                        item['imagePath']!,  // Load the image using imagePath
                        fit: BoxFit.contain,  // Ensures the image does not stretch
                        height: 45,  // Height of the image
                        width: 50,  // Width of the image
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),  // Space between image and text
                Text(
                  item['name']!,
                  maxLines: 1,
                  textAlign: TextAlign.center,// Display the name from the map
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
        )
      ),
    );
  }
}
