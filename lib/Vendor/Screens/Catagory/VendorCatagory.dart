import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revxpharma/Utils/color.dart';
import 'package:revxpharma/Vendor/Screens/Catagory/CreateCatagory.dart';
import 'package:speech_to_text/speech_to_text.dart%20' as stt;

import '../../../Components/CustomAppButton.dart';
import '../../../Components/CutomAppBar.dart';

class VendorCatagory extends StatefulWidget {
  const VendorCatagory({super.key});

  @override
  State<VendorCatagory> createState() => _VendorCatagoryState();
}

class _VendorCatagoryState extends State<VendorCatagory> {
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;

  TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  Future<void> _initializeSpeechToText() async {
    bool available = await _speechToText.initialize();
    if (available) {
      print("Speech-to-Text initialized successfully.");
      setState(() {
        _isListening = false; // Can start listening now
      });
    } else {
      print("Speech-to-Text initialization failed!");
    }
  }

  Future<bool> _requestMicrophonePermission() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      print("Microphone permission granted.");
      return true; // Permission granted
    } else {
      print("Microphone permission not granted.");
      return false; // Permission denied
    }
  }

  // Start listening for speech
  void _startListening() async {
    // First, check if the microphone permission is granted
    bool hasPermission = await _requestMicrophonePermission();
    if (!hasPermission) {
      print("Cannot start listening: Microphone permission denied.");
      return; // Do not proceed if permission is not granted
    }

    if (!_isListening) {
      print("Speech-to-Text is available.");

      // Check if SpeechToText is initialized before calling listen
      if (_speechToText.isAvailable) {
        print("Starting to listen...");
        _speechToText.listen(onResult: (result) {
          setState(() {
            // Update the TextField's text with recognized speech
            _searchController.text = result.recognizedWords;
            searchQuery = _searchController.text.toLowerCase();
          });
          // Print the recognized words from speech
          print("Speech-to-Text >> ${result.recognizedWords}");
        });

        setState(() {
          _isListening = true; // Now it is listening
        });
      } else {
        print("Speech-to-Text is not available, please check if initialized.");
      }
    } else {
      print("Already listening.");
    }
  }

  // Stop listening for speech
  void _stopListening() {
    if (_isListening) {
      _speechToText.stop();
      setState(() {
        _isListening = false; // Listening stopped
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Category',
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton.filledTonal(
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
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  height: 38,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (c) {
                            setState(() {
                              if (c.length > 2) {
                                searchQuery = c.toLowerCase();
                              } else {
                                searchQuery = "";
                              }
                            });
                          },
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: 'Search Categories',
                            icon: Icon(
                              Icons.search,
                              color: Color(0xff808080),
                            ),
                            hintStyle: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Color(0xff808080),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontFamily: "Inter",
                            ),
                          ),
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: "Poppins",
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlignVertical: TextAlignVertical.center,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isListening ? Icons.stop : Icons.mic,
                          color: primaryColor,
                          size: 18,
                        ),
                        onPressed: () {
                          if (_isListening) {
                            _stopListening();
                          } else {
                            _startListening();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          border:
                              Border.all(color: Color(0xffD6D6D6), width: 0.5)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: w * 0.7,
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              'Complete Blood Count (CBC),',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '₹ 6700.00/- ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xff1A1A1A),
                                ),
                              ),
                              Text(
                                ' No of tests : 05',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: BorderSide(
                                                color: primaryColor,
                                                width: 1))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xffFFFFFF)),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'View Detail',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                    ),
                                  )),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: BorderSide(
                                                color: primaryColor,
                                                width: 1))),
                                    backgroundColor: MaterialStateProperty.all(
                                        primaryColor),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Text(
                                        'Add Test',
                                        style: TextStyle(
                                          color: Color(0xffFFFFFF),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Icon(Icons.add_circle_outline_sharp,color: Color(0xffFFFFFF),size: 20,)
                                    ],
                                  ),),


                              // IconButton.filledTonal(
                              //     visualDensity: VisualDensity.compact,
                              //     onPressed: () {},
                              //     style: ButtonStyle(
                              //         padding: MaterialStateProperty.all(
                              //             EdgeInsets.zero),
                              //         shape: MaterialStateProperty.all(
                              //             CircleBorder()),
                              //         backgroundColor:
                              //             MaterialStateProperty.all(
                              //                 Color(0xffE5FCFC))),
                              //     icon: Icon(
                              //       Icons.edit,
                              //       color: Colors.black,
                              //       size: 18,
                              //     )),
                              // IconButton.filledTonal(
                              //     visualDensity: VisualDensity.compact,
                              //     onPressed: () {},
                              //     style: ButtonStyle(
                              //         padding: MaterialStateProperty.all(
                              //             EdgeInsets.zero),
                              //         shape: MaterialStateProperty.all(
                              //             CircleBorder()),
                              //         backgroundColor:
                              //             MaterialStateProperty.all(
                              //                 (Colors.red).withOpacity(0.2))),
                              //     icon: Icon(
                              //       Icons.delete_outline_rounded,
                              //       color: Colors.black,
                              //       size: 18,
                              //     )),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
