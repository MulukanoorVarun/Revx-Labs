import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Utils/color.dart';

class Pregnancy extends StatefulWidget {
  final String title;

  // Constructor with a required named parameter
  const Pregnancy({super.key, required this.title});

  @override
  State<Pregnancy> createState() => _PregnancyState();
}

class _PregnancyState extends State<Pregnancy> {
  final List<Map<String, dynamic>> _productList = [
    {'name': 'Free Beta HCG', 'price': '\₹ 1700.00/- ', 'No of tests' : 'No of tests :1'},
    {'name': 'Total Beta - HCG', 'price': '\₹ 1700.00/- ', 'No of tests' : 'No of tests :2'},
    {'name': 'Maternal Serum Screening - Double Marker', 'price': '\₹ 1700.00/- ', 'No of tests' : 'No of tests :3'},
    {'name': 'Maternal Serum Screening - Triple Marker', 'price': '\₹ 1700.00/- ', 'No of tests' : 'No of tests :4'},
    {'name': 'Maternal Serum Screening - Quadruple Marker', 'price': '\₹ 1700.00/- ', 'No of tests' : 'No of tests :5'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: primaryColor),
              onPressed: () {
               context.pop();
              },
            ),
          ),
          title: Row(
            children: [
              Text(
                "${widget.title}",
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: primaryColor),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: Color(0xff949494),
                  size: 25,
                ),
                SizedBox(width: 4),
                Container(
                  width:280,
                  child: Text(
                    'Sri Satya Diagnostics lab - 1.0 km away',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xff949494),
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: _productList.length, // 5 products
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // 2 cards per row
                  childAspectRatio: 2.4 ,  // Adjust this to control the card's aspect ratio
                  crossAxisSpacing: 10, // Horizontal spacing between cards
                  mainAxisSpacing: 10, // Vertical spacing between cards
                ),
                itemBuilder: (context, index) {
                  // Each card in the grid
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color:Color(0xff949494), width: 1), // Gray border
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
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
                          SizedBox(height: 8), // Space between product name and price
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
                          SizedBox(height: 16), // Space between price and buttons

                          // Row with "View" button and "Add Test" button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // View Button
                              InkWell(
                                onTap:(){

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 35,vertical: 7),
                                  decoration: BoxDecoration(

                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(color: primaryColor)
                                  ),
                                  child: Text('View Detail',style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Poppins",
                                      color: primaryColor),),
                                ),
                              ),
                              GestureDetector(
                                onTap:(){

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20), // Adjust padding as needed
                                  decoration: BoxDecoration(
                                    color: primaryColor, // Button color
                                    borderRadius: BorderRadius.circular(30), // Rounded corners
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
                                      SizedBox(width: 8), // Space between text and icon
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
