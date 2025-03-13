import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revxpharma/Components/CustomAppButton.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Utils/color.dart';
import 'package:revxpharma/Vendor/Screens/Test/VendorCreateTest.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_get_tests/diognostic_getTests_cubit.dart';
import 'package:revxpharma/Vendor/bloc/diognostic_get_tests/diognostic_getTests_state.dart';

import 'package:speech_to_text/speech_to_text.dart%20' as stt;

import '../../../Components/CutomAppBar.dart';

class VendorTest extends StatefulWidget {
  const VendorTest({super.key});

  @override
  State<VendorTest> createState() => _VendorTestState();
}

class _VendorTestState extends State<VendorTest> {
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  @override
  void initState() {
    context.read<DiagnosticTestsCubit>().getTests();
    super.initState();
  }

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
      return;
    }

    if (!_isListening) {
      print("Speech-to-Text is available.");

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
          title: 'Tests',
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: IconButton.filledTonal(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewTest()));
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
                            hintText: 'Search Tests',
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
                BlocBuilder<DiagnosticTestsCubit, DiagnosticTestsState>(
                  builder: (context, state) {
                    if (state is DiagnosticTestsLoading) {
                      Center(
                        child: _shimmerList(),
                      );
                    } else if (state is DiagnosticTestListLoaded) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.data.data?.length,
                        itemBuilder: (context, index) {
                          final item = state.data.data?[index];
                          print('item:${item}');

                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                border: Border.all(
                                    color: Color(0xffD6D6D6), width: 0.5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: w * 0.55,
                                      child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        item?.testName ?? '',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Color(0xff000000),
                                        ),
                                      ),
                                    ),
                                    IconButton.filledTonal(
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () {},
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.zero),
                                            shape: MaterialStateProperty.all(
                                                CircleBorder()),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color(0xffE5FCFC))),
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                          size: 18,
                                        )),
                                    IconButton.filledTonal(
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () {},
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.zero),
                                            shape: MaterialStateProperty.all(
                                                CircleBorder()),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    (Colors.red)
                                                        .withOpacity(0.2))),
                                        icon: Icon(
                                          Icons.delete_outline_rounded,
                                          color: Colors.black,
                                          size: 18,
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: w * 0.8,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Category : ${item?.category ?? ''}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                CustomAppButton(
                                    width: w * 0.65,
                                    height: h * 0.045,
                                    text: 'Price : ₹ ${item?.price ?? ''}0/- ',
                                    onPlusTap: () {})
                              ],
                            ),
                          );
                        },
                      );
                    } else if (state is DiagnosticTestsError) {
                      return Center(child: Text(state.message));
                    }
                    return Center(child: Text("No Data"));
                  },
                )
              ],
            ),
          ),
        ));
  }

  Widget _shimmerList() {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
                border: Border.all(color: Color(0xffD6D6D6), width: 0.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    shimmerText(120, 12, context),
                    shimmerCircle(18, context),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                shimmerText(120, 12, context),
                SizedBox(
                  height: 14,
                ),
                shimmerContainer(w * 0.5, 20, context),
              ],
            ),
          );
        },
      ),
    );
  }
}
