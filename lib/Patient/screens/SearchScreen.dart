

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/screens/DiagnosticInformation.dart';
import 'package:revxpharma/Patient/screens/Diagnosticcenter.dart';
import 'package:speech_to_text/speech_to_text.dart%20' as stt;

class Searchscreen extends StatefulWidget {
  const Searchscreen({super.key});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  bool isLoading = true;
  bool _isLoding = false;

  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;

  TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    // _loadInitialData();
    _initializeSpeechToText(); // Initialize speech recognition after data loading
  }

 List searchData = [];

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
          _isListening = true;
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
    return Scaffold(
      backgroundColor: Color(0xffEFF4F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 6),
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
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
                        // GetSearchData(searchQuery);
                      } else {
                        searchQuery = "";
                      }
                    });
                  },
                  decoration: InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: 'Serach Diagnostics...',
                    hintStyle: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Color(0xff27BDBE),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: "Inter",
                    ),
                  ),
                  style: TextStyle(
                    color:  Color(0xff27BDBE),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    decorationColor:  Color(0xff27BDBE),
                    fontFamily: "Inter",
                    overflow: TextOverflow.ellipsis,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              IconButton(
                icon: Icon(
                  _isListening ? Icons.stop : Icons.mic,
                  color:  Color(0xff27BDBE),
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: isLoading
              ? Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.width*0.6),
                  Center(child: CircularProgressIndicator()),
                ],
              )
              : Column(
                  children: [
                    if (searchQuery.isNotEmpty) ...[
                      if (_isLoding == true) ...[
                        Center(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 20,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          shimmerContainer(45, 45, context),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          shimmerText(200, 20, context),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );

                                }))
                      ] else ...[
                        if (searchData.isEmpty)
                          Center(
                              child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 8,
                                ),
                                Text( 'Oops !',style: TextStyle(
    fontSize: 24,fontFamily:'Poppins',
    fontWeight: FontWeight.w600
    ),
                                    ),
                                SizedBox(
                                  height: 8,
                                ),
    Text(  'The Product seems to be playing hide and seek.',style: TextStyle(
    fontSize: 24,fontFamily:'Poppins',
    fontWeight: FontWeight.w600
    ),
    ),          SizedBox(
                                  height: 8,
                                ),
    Text(   'Try Searching with a diffrent name.',style: TextStyle(
    fontSize: 14,fontFamily:'Poppins',
    fontWeight: FontWeight.w600, color: Color(0xff808080)
    ),
    )
                              ],
                            ),
                          ))
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            // itemCount: searchData.length,
                            itemBuilder: (context, index) {
                              // final searchItem = searchData[index];
                              return InkResponse(
                                onTap: (){
                                  Navigator.of(context)
                                      .push(
                                      PageRouteBuilder(
                                        pageBuilder: (context,
                                            animation,
                                            secondaryAnimation) {
                                          return DiagnosticInformation(diognosticId: 'diognosticId');
                                        },
                                        transitionsBuilder:
                                            (context,
                                            animation,
                                            secondaryAnimation,
                                            child) {
                                          const begin =
                                          Offset(1.0, 0.0);
                                          const end =
                                              Offset.zero;
                                          const curve =
                                              Curves.easeInOut;
                                          var tween = Tween(
                                              begin: begin,
                                              end: end)
                                              .chain(CurveTween(
                                              curve:
                                              curve));
                                          var offsetAnimation =
                                          animation
                                              .drive(tween);
                                          return SlideTransition(
                                              position:
                                              offsetAnimation,
                                              child: child);
                                        },
                                      ));
                                },
                                child: ListTile(
                                  leading: Container(
                                      padding: EdgeInsets.all(2),
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          color: Color(0xff808080).withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Image.network(
                                        // searchItem.image ??
    '',
                                        fit: BoxFit.contain,
                                      )),
                                  title: Text(
                                  // searchItem.name ??
                                  ''),
                                ),
                              );
                            },
                          ),
                      ]
                    ] else ...[
                      // _buildSection('Diagnostic Center',
                      //     (item) => item.categoryName),

                    ],
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildSection(
      String title, List<dynamic> data, String Function(dynamic) getText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 8,),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 2,
          ),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return InkResponse(
              onTap: (){
                Navigator.of(context)
                    .push(PageRouteBuilder(
                  pageBuilder: (context, animation,
                      secondaryAnimation) {
                    return Diagnosticcenter(lat_lng: '');
                  },
                  transitionsBuilder: (context,
                      animation,
                      secondaryAnimation,
                      child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(
                        begin: begin, end: end)
                        .chain(CurveTween(
                        curve: curve));
                    var offsetAnimation =
                    animation.drive(tween);
                    return SlideTransition(
                        position: offsetAnimation,
                        child: child);
                  },
                ));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8)),
                child: Center(child: Text(getText(item))),
              ),
            );
          },
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
