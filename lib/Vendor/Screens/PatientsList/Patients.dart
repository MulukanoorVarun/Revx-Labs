import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Vendor/Screens/PatientsList/PatientDetails.dart';
import 'package:speech_to_text/speech_to_text.dart%20' as stt;

class Patients extends StatefulWidget {
  const Patients({super.key});

  @override
  State<Patients> createState() => _PatientsState();
}

class _PatientsState extends State<Patients> {
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
    return Scaffold(
      appBar: CustomAppBar(title: 'Patients', actions: [
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
                backgroundColor: MaterialStateProperty.all(Color(0xffE5FCFC))),
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 18,
            )),
        SizedBox(
          width: 16,
        )
      ]),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              margin: EdgeInsets.only(bottom: 10),
              height: 38,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff27BDBE),
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
                        hintText: 'Search here...',
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
                        color: Color(0xff27BDBE),
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
                      color: Color(0xff27BDBE),
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
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return InkResponse(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PateintDetails()));
                  },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffD6D6D6), width: 0.5))),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            child: Image.asset('assets/person.png',
                                fit: BoxFit.contain),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: w * 0.45,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              'Rameswer',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Spacer(),
                          IconButton.filledTonal(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {

                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                                  shape: MaterialStateProperty.all(CircleBorder()),
                                  backgroundColor:
                                  MaterialStateProperty.all(Color(0xffE5FCFC))),
                              icon: Icon(
                                Icons.call,
                                color: Colors.black,
                                size: 20,
                              )),
                          SizedBox(width: 12,),
                          IconButton.filledTonal(
                              visualDensity: VisualDensity.compact,
                              onPressed: () {

                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                                  shape: MaterialStateProperty.all(CircleBorder()),
                                  backgroundColor:
                                  MaterialStateProperty.all(Color(0xffE5FCFC))),
                              icon: Icon(
                                Icons.info_outline,
                                color: Colors.black,
                                size: 20,
                              )),


                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
