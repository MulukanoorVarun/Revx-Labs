import 'package:flutter/material.dart';
import 'DiagnosticInformation.dart';

class Diagnosticcenter extends StatefulWidget {
  const Diagnosticcenter({super.key});

  @override
  State<Diagnosticcenter> createState() => _Diagnosticcenter();
}

class _Diagnosticcenter extends State<Diagnosticcenter> {
  // Dummy list of product names and prices
  final List<Map<String, dynamic>> _productList = [
    {
      'name': 'Likitha’s Diagnostics',
      'price': 'Kondapur ',
      'No of tests': '1.0 km away',
      'image': "assets/likitha.png",
      'details': 'On Radiology tests'
    },
    {
      'name': 'Konark Diagnostic centre',
      'price': 'Kondapur',
      'No of tests': '1.4 km away',
      'image': "assets/konark.png",
      'details': 'On Pathology tests'
    },
    {
      'name': 'Digital Diagnostic center',
      'price': 'Madhapur',
      'No of tests': '1.8 km away',
      'image': "assets/digital.png",
      'details': 'On all tests'
    },
    {
      'name': 'Galaxy Plus Laboratory',
      'price': 'Raidurg',
      'No of tests': '3.0 km away',
      'image': "assets/img.png",
      'details': 'On all tests'
    },
    {
      'name': 'Uday Laboratories',
      'price': 'Raidurg',
      'No of tests': '4.0 km away',
      'image': "assets/img.png",
      'details': 'On Radiology tests'
    },
  ];

  @override
  Widget build(BuildContext context) {
    var screenwidth= MediaQuery.of(context).size.width;
    var screenheight= MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff24AEB1)),
          onPressed: () => Navigator.pop(context)
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Diagnostic Centres",
              style: TextStyle(
                color: Color(0xff24AEB1),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
              ),
            ),
          ],
        ),
        actions: [
            Image.asset(
              'assets/filter.png', // Replace with the actual asset path of your small image
              width:
              45, // Set the desired width for the small image
              height:
              22, // Set the desired height for the small image
            ),

        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff24AEB1)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: _productList.length, // 5 products
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // 1 card per row
                  childAspectRatio: 2.35, // Adjust this to control the card's aspect ratio
                  crossAxisSpacing: 10, // Horizontal spacing between cards
                  mainAxisSpacing: 10, // Vertical spacing between cards
                ),
                itemBuilder: (context, index) {
                  // Each card in the grid
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DiagnosticInformation(), // Adjust the index as needed
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey, width: 1), // Gray border
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 0), // Padding for the image
                            child: Container(
                              width: 100, // Adjust width as needed
                              height: 100, // Square image
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                 color: Color(0xff24AEB1),
                                    width: 1), // Gray border
                                borderRadius: BorderRadius.circular(
                                    8), // Rounded corners for the image
                              ),
                              child: Image(image: AssetImage(_productList[index]['image'])),
                            ),
                          ),
                          // Product details section
                          Padding(
                            padding: const EdgeInsets.only(left: 10,top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: screenheight*0.01,),
                                Text(
                                  _productList[index]['name'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: screenheight*0.01,), // Space between product name and price
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _productList[index]['price'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on,color: Colors.red,),
                                        Text(
                                          _productList[index]['No of tests'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height:
                                        10), // Space between price and buttons

                                // Row with "View" button and "Add Test" button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start, // Align content to the start
                                  children: [
                                    // Small image icon
                                    Stack(
                                      children: [
                                        Image.asset(
                                          'assets/offerbg.jpeg', // Replace with the actual asset path of your small image
                                          width: 60, // Set the desired width for the small image
                                          height:
                                              24, // Set the desired height for the small image
                                        ),
                                        Positioned(
                                          left: 10,right: 3,top: 3,
                                            child: Text("10% Off",style: TextStyle( fontFamily: "Poppins",
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.white,),)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      _productList[index]['details'],
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Poppins",
                                        color: Color(0xff3A3A3A),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
