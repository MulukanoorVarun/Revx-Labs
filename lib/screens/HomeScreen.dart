import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revxpharma/screens/servicecategory.dart';
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

  final List<String> imgList = [
    'assets/image.png',
    'assets/image.png',
    'assets/image.png',
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                height: screenHeight * 0.25, // Adjusted height for carousel
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
              items: imgList.map((item) {
                return InkWell(
                  onTap: () async {},
                  child: Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        child: Image.asset(
                          item,
                          fit: BoxFit
                              .contain, // Adjust fit for better image display
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
              children: imgList.asMap().entries.map((entry) {
                bool isActive = currentIndex == entry.key;
                return Container(
                  width:
                      isActive ? 17.0 : 7.0, // Width changes based on activity
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
            _buildCategoryGrid(),

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
                    onTap: (){
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
            _buildDiognosticCenter(),
            SizedBox(height: 8),

            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => alltests(), // Adjust the index as needed
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
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
  }

  Widget _buildCategoryGrid() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 8, // Number of category items
      itemBuilder: (context, index) {
        final categories = [
          {"image": "assets/pregnency.png", "label": "Pregnancy"},
          {"image": "assets/lungs.png", "label": "Lungs"},
          {"image": "assets/mriscan.png", "label": "MRI Scan"},
          {"image": "assets/health.png", "label": "Health"},
          {"image": "assets/heart.png", "label": "Heart"},
          {"image": "assets/kidney.png", "label": "Kidney"},
          {"image": "assets/bloodtext.png", "label": "Blood Test"},
          {"image": "assets/more.png", "label": "More"},
        ];

        final category = categories[index];
        return InkWell(
          onTap: () {
            _handleCategoryTap(context, category['label']!);
          },
          child: _buildCategoryItem(category["image"]!, category["label"]!),
        );
      },
    );
  }

  void _handleCategoryTap(BuildContext context, String label) {
    Widget detailScreen;

    switch (label) {
      case 'Pregnancy':
        detailScreen = Pregnancy(title: "Pregnancy",);
        break;
      case 'Lungs':
        detailScreen = Pregnancy(title: "Lungs",);
        break;
      case 'MRI Scan':
        detailScreen =  Pregnancy(title: "MRI Scan",);
        break;
      case 'Health':
        detailScreen =  Pregnancy(title: "Health",);
        break;
      case 'Heart':
        detailScreen =  Pregnancy(title: "Heart",);
        break;
      case 'Kidney':
        detailScreen =  Pregnancy(title: "Kidney",);
        break;
      case 'Blood Test':
        detailScreen =  Pregnancy(title: "Blood Test",);
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
            child: Image.asset(image, width: 45, height: 45),
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

  Widget _buildDiognosticCenter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 5,
        children: [
          _buildDiognosticcenter("assets/konark.png"),
          _buildDiognosticcenter("assets/likitha.png"),
          _buildDiognosticcenter("assets/digital.png"),
          _buildDiognosticcenter("assets/img.png"),
        ],
      ),
    );
  }

  Widget _buildDiognosticcenter(
    String image,
  ) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        InkResponse(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiagnosticInformation(),
              ),
            );
          },
          child: Container(
            width: w * 0.435,
            height: w * 0.4,
            padding: EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xff27BDBE), width: 1),
              // Adjusted size to fit the circle
            ),
            child: Image.asset(image),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
