import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/cart/cart_state.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/tests/test_state.dart';
import 'package:revxpharma/Patient/screens/DiagnosticInformation.dart';
import 'package:revxpharma/Patient/screens/Diagnosticcenter.dart';
import 'package:speech_to_text/speech_to_text.dart%20' as stt;

class Searchscreen extends StatefulWidget {
  String lat_lang;
  Searchscreen({super.key, required this.lat_lang});

  @override
  State<Searchscreen> createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  bool _isLoding = false;

  TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    // _loadInitialData();
    _initializeSpeechToText(); // Initialize speech recognition after data loading
  }

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
                          context
                              .read<TestCubit>()
                              .fetchTestList(widget.lat_lang, '', searchQuery);
                        } else {
                          searchQuery = "";
                        }
                      });
                    },
                    decoration: InputDecoration(
                      focusColor: Color(0xff27BDBE),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xff27BDBE),
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xff27BDBE),
                          )),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      isCollapsed: true,
                      hintText: 'Serach Diagnostics tests...',
                      hintStyle: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Color(0xff27BDBE),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        fontFamily: "Inter",
                      ),
                    ),
                    style: TextStyle(
                      color: Color(0xff27BDBE),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      decorationColor: Color(0xff27BDBE),
                      fontFamily: "Inter",
                      overflow: TextOverflow.ellipsis,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                // IconButton(
                //   icon: Icon(
                //     _isListening ? Icons.stop : Icons.mic,
                //     color:  Color(0xff27BDBE),
                //     size: 18,
                //   ),
                //   onPressed: () {
                //     if (_isListening) {
                //       _stopListening();
                //     } else {
                //       _startListening();
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              if(_searchController.text=="")...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.6,
                    ),
                    Text(
                      'Oops !',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'The Diagnostic test seems to be playing hide and seek.',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'Try Searching with a diffrent name. ',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ],
                )
              ]else...[
                Expanded(
                  child: BlocBuilder<TestCubit, TestState>(
                    builder: (context, state) {
                      if (state is TestStateLoading) {
                        return _shimmerList();
                      } else if (state is TestStateLoaded ||
                          state is TestStateLoadingMore) {
                        final testModel = (state is TestStateLoaded)
                            ? (state as TestStateLoaded).testModel
                            : (state as TestStateLoadingMore).testModel;
                        if ((testModel.data?.isEmpty ?? true) ||
                            searchQuery=="") {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 8,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.width * 0.005,
                              ),
                              Text(
                                'Oops !',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                'The Diagnostic test seems to be playing hide and seek.',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Try Searching with a diffrent name. ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey),
                              ),
                            ],
                          );
                        }
                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent * 0.9) {
                              if (state is TestStateLoaded && state.hasNextPage) {
                                context.read<TestCubit>().fetchMoreTestList(
                                    widget.lat_lang ?? '', '', searchQuery);
                              }
                              return false;
                            }
                            return false;
                          },
                          child: CustomScrollView(
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                    final labTests = testModel.data?[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xff949494),
                                            width: 0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            labTests?.testName ?? '',
                                            maxLines: 1,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '₹ ${labTests!.price}/-',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  side: const BorderSide(
                                                      color: Color(0xff27BDBE)),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(30),
                                                  ),
                                                  elevation: 0,
                                                  visualDensity:
                                                  VisualDensity.compact,
                                                ),
                                                child: Text(
                                                  'View Detail',
                                                  style: TextStyle(
                                                      color: Color(0xff27BDBE),
                                                      fontFamily: "Poppins"),
                                                ),
                                              ),
                                              BlocBuilder<CartCubit, CartState>(
                                                builder: (context, cartState) {
                                                  bool isLoading = cartState
                                                  is CartLoadingState &&
                                                      cartState.testId ==
                                                          labTests.id;
                                                  return ElevatedButton(
                                                    onPressed: isLoading
                                                        ? null
                                                        : () {
                                                      if (labTests
                                                          .exist_in_cart ??
                                                          false) {
                                                        context
                                                            .read<
                                                            CartCubit>()
                                                            .removeFromCart(
                                                            labTests.id ??
                                                                "",
                                                            context);
                                                      } else {
                                                        context
                                                            .read<
                                                            CartCubit>()
                                                            .addToCart({
                                                          "test":
                                                          "${labTests.id}"
                                                        }, context);
                                                      }
                                                    },
                                                    style:
                                                    ElevatedButton.styleFrom(
                                                        visualDensity:
                                                        VisualDensity
                                                            .compact,
                                                        backgroundColor:
                                                        labTests.exist_in_cart ??
                                                            false
                                                            ? Colors.red
                                                            : const Color(
                                                            0xff24AEB1),
                                                        shape:
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              30),
                                                        ),
                                                        elevation: 0),
                                                    child: isLoading
                                                        ? const SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child:
                                                      CircularProgressIndicator(
                                                        color: Colors.white,
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                        : Text(
                                                      labTests.exist_in_cart ??
                                                          false
                                                          ? 'Remove'
                                                          : 'Add Test',
                                                      style: TextStyle(
                                                          color:
                                                          Colors.white,
                                                          fontFamily:
                                                          "Poppins"),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin:
                                            const EdgeInsets.only(top: 10),
                                            padding: const EdgeInsets.all(6),
                                            decoration: const BoxDecoration(
                                                color: Color(0xffD40000)),
                                            child: Row(
                                              children: [
                                                const Icon(Icons.location_on,
                                                    color: Colors.white,
                                                    size: 15),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    '${labTests.diagnosticCentre} - ${labTests.distance} away',
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  childCount: testModel.data?.length ?? 0,
                                ),
                              ),
                              if (state is TestStateLoadingMore)
                                SliverToBoxAdapter(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                          strokeWidth: 0.8),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      } else if (state is TestStateError) {
                        return const Center(child: Text("Error loading data"));
                      }
                      return SizedBox();
                    },
                  ),
                ),
              ]
              // )
            ],
          ),
        ));
  }

  Widget _shimmerList() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Expanded(
        child: ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          width: w,
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xff949494), width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerText(120, 10, context),
              SizedBox(height: 8),
              shimmerText(120, 10, context),
              SizedBox(height: 26),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  shimmerContainer(140, 40, context),
                  shimmerContainer(140, 40, context),
                ],
              ),
              SizedBox(height: 26),
              shimmerContainer(w, 25, context),
            ],
          ),
        );
      },
    ));
  }
}
