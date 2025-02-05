import 'package:flutter/material.dart';

class alltests1 extends StatefulWidget {
  const alltests1({super.key});

  @override
  State<alltests1> createState() => _alltests1();
}

class _alltests1 extends State<alltests1> {
  bool isLabTestSelected = false;
  // Dummy list of product names and prices
  final List<Map<String, dynamic>> _productList = [
    {
      'name': 'Free Beta HCG',
      'price': '\₹ 1700.00/- ',
      'No of tests': 'No of tests :1'
    },
    {
      'name': 'Free Beta HCG',
      'price': '\₹ 1700.00/- ',
      'No of tests': 'No of tests :2'
    },
    {
      'name': 'Free Beta HCG',
      'price': '\₹ 1700.00/- ',
      'No of tests': 'No of tests :3'
    },
    {
      'name': 'Free Beta HCG',
      'price': '\₹ 1700.00/- ',
      'No of tests': 'No of tests :4'
    },
    {
      'name': 'Free Beta HCG',
      'price': '\₹ 1700.00/- ',
      'No of tests': 'No of tests :5'
    },
  ];

  @override
  Widget build(BuildContext context) {
    var w =MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "All Tests1",
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
          IconButton(
            icon: Icon(Icons.filter_9_plus, color: Color(0xff24AEB1)),
            onPressed: () => Navigator.pop(context),
          ),
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
                color: Colors.grey[200], // Background color of the search box
                borderRadius: BorderRadius.circular(30), // Rounded corners
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for lab tests (CBP, X-Ray..)",
                  hintStyle: TextStyle(color: Color(0xffD9D9D9)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(15),
                  prefixIcon: Icon(Icons.search, color: Color(0xff24AEB1)),
                ),
              ),
            ),
            SizedBox(
                height: 20), // Space between the search field and product grid
            Container(
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xff27BDBE), width: 1),
              ),
              child: Row(
                children: [
                  // "Lab Tests" Container
                  GestureDetector(
                    onTap: () {
                      // Toggle the selection of "Lab Tests"
                      setState(() {
                        isLabTestSelected = true; // Select "Lab Tests"
                      });
                    },
                    child: Container(
                      width: w * 0.46,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Add padding
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: isLabTestSelected ? Color(0xff27BDBE) : Colors.transparent,


                      ),
                      child: Center(
                        child: Text(
                          "Labs Tests",
                          style: TextStyle(
                            color: isLabTestSelected ? Colors.white : Color(0xff27BDBE),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ),
                  ),



                  // "Condition based" Container
                  GestureDetector(
                    onTap: () {
                      // Toggle the selection of "Condition based"
                      setState(() {
                        isLabTestSelected = false; // Select "Condition based"
                      });
                    },
                    child: Container(
                      width: w * 0.45,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Add padding
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: !isLabTestSelected ? Color(0xff27BDBE) : Colors.transparent,

                      ),
                      child: Center(
                        child: Text(
                          "Condition based",
                          style: TextStyle(
                            color: !isLabTestSelected ? Colors.white : Color(0xff27BDBE),
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
            SizedBox(height: 20,),
            Expanded(
              child: GridView.builder(
                itemCount: _productList.length, // 5 products
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // 2 cards per row
                  childAspectRatio:
                      1.7, // Adjust this to control the card's aspect ratio
                  crossAxisSpacing: 10, // Horizontal spacing between cards
                  mainAxisSpacing: 10, // Vertical spacing between cards
                ),
                itemBuilder: (context, index) {
                  // Each card in the grid
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey, width: 1), // Gray border
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product name
                          Text(
                            _productList[index]['name'],
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
                                _productList[index]['price'],
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
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: 16), // Space between price and buttons

                          // Row with "View" button and "Add Test" button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // View Button
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 35, vertical: 10),
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
                              // ElevatedButton(
                              //   style: ElevatedButton.styleFrom(
                              //     backgroundColor: Color(0xffffffff), // Button color
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(20), // Rounded corners
                              //     ),
                              //   ),
                              //   onPressed: () {
                              //     // View action
                              //   },
                              //   child: Text('View Detail'),
                              // ),

                              // Add Test Button with "+" icon
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color(0xff24AEB1), // Button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20), // Rounded corners
                                  ),
                                ),
                                onPressed: () {
                                  // Add Test action
                                },
                                icon: Icon(Icons.add, color: Colors.white),
                                iconAlignment: IconAlignment.end, // "+" icon
                                label: Text(
                                  'Add Test',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 30,
                            margin: EdgeInsets.only(top: 12) ,
                              padding:EdgeInsets.only(left: 10) ,

                              decoration: BoxDecoration(color: Color(0xff8E8787)),child: Center(child: Text("Diagnostics  :  Sri Satya Diagnostics lab  -  1.0 km away",style: TextStyle(color: Color(0xffFFFFFF),fontSize: 10,fontFamily: "Poppins",fontWeight: FontWeight.w600),)),)

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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff24AEB1),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {
          // Handle tab change if necessary
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
