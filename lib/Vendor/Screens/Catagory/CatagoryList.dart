import 'package:flutter/material.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Vendor/Screens/Catagory/CreateCatagory.dart';
import 'package:revxpharma/Vendor/Screens/Catagory/VendorCatagory.dart';

class CatagoryList extends StatefulWidget {
  const CatagoryList({super.key});

  @override
  State<CatagoryList> createState() => _CatagoryListState();
}

class _CatagoryListState extends State<CatagoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Category', actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              IconButton.filledTonal(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewCategory()));
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      shape: MaterialStateProperty.all(CircleBorder()),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffE5FCFC))),
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 18,
                  )),
              SizedBox(
                width: 10,
              ),
              IconButton.filledTonal(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewCategory()));
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      shape: MaterialStateProperty.all(CircleBorder()),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffE5FCFC))),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 18,
                  )),
              SizedBox(
                width: 10,
              ),
              IconButton.filledTonal(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CreateNewCategory()));
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      shape: MaterialStateProperty.all(CircleBorder()),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xffE5FCFC))),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.black,
                    size: 18,
                  )),
            ],
          ),
        ),
      ]),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: Color(0xffD9D9D9),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Image.asset(
                          'assets/lungs.png',
                          fit: BoxFit.contain,
                          height: 34,
                          width: 34,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Text(
                      'Endocrinology',
                      style: TextStyle(
                        color: Color(0xff1A1A1A),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorCatagory()));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xff808080),size: 18,
                        )),

                  ],
                ),
                SizedBox(height: 10,),
                Divider(height: 1,  color: Color(0xffD6D6D6),),
                SizedBox(height: 10,),

              ],
            );
          },
        ),
      ),
    );
  }
}
