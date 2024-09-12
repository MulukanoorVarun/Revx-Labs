import 'package:flutter/material.dart';
import 'package:revxpharma/screens/Pregnancy.dart';

class alltests extends StatefulWidget {
  const alltests({super.key});

  @override
  State<alltests> createState() => _alltestsState();
}

class _alltestsState extends State<alltests> {
  bool isLabTestSelected = true;
  final List<Map<String, dynamic>> _productList = [
    {
      'name': 'Free Beta HCG',
      'price': '\₹ 1700.00/- ',
      'No of tests': 'No of tests :1'
    },
    {
      'name': 'Total Beta - HCG',
      'price': '\₹ 1700.00/- ',
      'No of tests': 'No of tests :2'
    },
    {
      'name': 'Maternal Serum Screening - Double Marker',
      'price': '\₹ 1700.00/- ',
      'No of tests': 'No of tests :3'
    },
    {
      'name': 'Maternal Serum Screening - Triple Marker',
      'price': '\₹ 1700.00/- ',
      'No of tests': 'No of tests :4'
    },
    {
      'name': 'Maternal Serum Screening - Quadruple Marker',
      'price': '\₹ 1700.00/- ',
      'No of tests': 'No of tests :5'
    },
  ];

  final List<Map<String, dynamic>> _productList1 = [
    {
      'name': 'Anaemia',
      'price': '(26 Tests Available)',
    },
    {
      'name': 'Diabetes',
      'price': '(26 Tests Available)',
    },
    {
      'name': 'Heart',
      'price': '(26 Tests Available)',
    },
    {
      'name': 'Liver',
      'price': '(26 Tests Available)',
    },
    {
      'name': 'Lungs',
      'price': '(26 Tests Available)',
    },
    {
      'name': 'Fertility',
      'price': '(26 Tests Available)',
    },
    {
      'name': 'Kidney',
      'price': '(26 Tests Available)',
    },
    {
      'name': 'Allergy',
      'price': '(26 Tests Available)',
    },
    {
      'name': 'Vitamins',
      'price': '(26 Tests Available)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xff24AEB1)),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "All Tests",
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
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Image(
              image: AssetImage("assets/filter.png"),
              width: 16,
              height: 18,
            ),
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff24AEB1)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search field with rounded corners and search icon
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, // Background color of the search box
                  borderRadius: BorderRadius.circular(30),
                  border:
                      Border.all(color: Color(0xffDADADA)) // Rounded corners
                  ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for lab tests (CBP, X-Ray..)",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      color: Color(0xffb6b6b6)),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  prefixIcon: Icon(Icons.search, color: Color(0xff949494)),
                ),
              ),
            ),
            SizedBox(
                height: 30), // Space between the search field and product grid

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xff27BDBE), width: 1),
              ),
              child: Row(
                children: [
                  // "Lab Tests" Container
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLabTestSelected = true; // Select "Lab Tests"
                      });
                    },
                    child: Container(
                      width: w * 0.45,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isLabTestSelected ? const Color(0xff27BDBE) : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          "Labs Tests",
                          style: TextStyle(
                            color: isLabTestSelected ? Colors.white : const Color(0xff27BDBE),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLabTestSelected = false; // Select "Condition based"
                      });
                    },
                    child: Container(
                      width: w * 0.4555,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical:10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: !isLabTestSelected ? const Color(0xff27BDBE) : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          "Condition based",
                          style: TextStyle(
                            color: !isLabTestSelected ? Colors.white : const Color(0xff27BDBE),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if(isLabTestSelected)...[
              Expanded(
                child: GridView.builder(
                  itemCount: _productList.length, // 5 products
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, // 2 cards per row
                    childAspectRatio: 2, // Adjust this to control the card's aspect ratio
                    crossAxisSpacing: 10, // Horizontal spacing between cards
                    mainAxisSpacing: 10, // Vertical spacing between cards
                  ),
                  itemBuilder: (context, index) {
                    // Each card in the grid
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xff949494), width: 1), // Gray border
                        borderRadius:
                        BorderRadius.circular(10), // Rounded corners
                      ),
                      child: Padding(padding: const EdgeInsets.only(left: 15.0,right: 10,top: 15,bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product name
                            Text(
                              _productList[index]['name'],
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                                height:
                                8), // Space between product name and price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "MRP ${_productList[index]['price']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                  ),
                                ),
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
                            SizedBox(
                                height: 16), // Space between price and buttons

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // View Button
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 35, vertical: 7),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                        border:
                                        Border.all(color: Color(0xff27BDBE))),
                                    child: Text(
                                      'View Detail',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Poppins",
                                          color: Color(0xff27BDBE)),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 7,
                                        horizontal:
                                        20), // Adjust padding as needed
                                    decoration: BoxDecoration(
                                      color: Color(0xff24AEB1), // Button color
                                      borderRadius: BorderRadius.circular(
                                          30), // Rounded corners
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Add Test',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                            width:
                                            8), // Space between text and icon
                                        Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                                height:8),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xffD40000)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4),
                                  Container(
                                    width: 250,
                                    child: Text(
                                      'Diagnostics : Sri Satya Diagnostics lab - 1.0 km away',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                      ),
                                    ),
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
            ]else...[
              Expanded(
                child: GridView.builder(
                  itemCount: _productList1.length, // Number of products
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // 1 card per row
                      childAspectRatio: 4,// Adjusted aspect ratio for reduced card height
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5// Horizontal spacing between cards// Vertical spacing between cards
                  ),
                  itemBuilder: (context, index) {
                    // Each card in the grid
                    return GestureDetector(
                      onTap: () {
                        // Handle card click, navigate or perform an action
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Product name and price
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _productList1[index]['name'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 6), // Space between product name and price
                                  Text(
                                    _productList1[index]['price'],
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                        color: Color(0xff808080)),

                                  ),
                                ],
                              ),
                              // Dummy image instead of noOfTests
                              Icon(Icons.arrow_forward_ios_outlined, size: 20,)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
