import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart' as OpenAppSettings;
import 'package:revxpharma/Patient/screens/MyAppointments.dart';
import 'package:revxpharma/Patient/screens/servicecategory.dart';
import 'package:revxpharma/Utils/color.dart';
import '../logic/bloc/internet_status/internet_status_bloc.dart';
import '../logic/cubit/Location/location_cubit.dart';
import '../logic/cubit/Location/location_state.dart';
import 'HomeScreen.dart';
import 'Profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PageController pageController = PageController();
  int _selectedIndex = 0;
  String latlngs = "";

  @override
  void initState() {
    context.read<LocationCubit>().checkLocationPermission();
    super.initState();
  }

  void onItemTapped(int selectedItems) {
    pageController.jumpToPage(selectedItems);
    setState(() {
      _selectedIndex = selectedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex > 0) {
          // Navigate to the previous tab
          final newIndex = _selectedIndex - 1;
          pageController.jumpToPage(newIndex);
          setState(() {
            _selectedIndex = newIndex;
          });
          return false;
        } else {
          // Exit the app if on Home tab
          SystemNavigator.pop();
          return false;
        }
      },
      child: Scaffold(
        body: BlocListener<InternetStatusBloc, InternetStatusState>(
          listener: (context, state) {
            if (state is InternetStatusLostState) {
              context.push('/no_internet');
            }
          },
          child: BlocListener<LocationCubit, LocationState>(
            listener: (context, state) {
              if (state is LocationPermissionDenied) {
                showLocationBottomSheet(context);
              } else if (state is LocationLoaded) {
                latlngs = state.latlng;
              }
            },
            child: PageView(
              onPageChanged: (value) {
                HapticFeedback.lightImpact();
              },
              controller: pageController,
              children: [
                Homescreen(),
                ServiceCategory(
                  latlngs: latlngs,
                  query: "",
                ),
                Myappointments(),
                Profile()
              ],
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -1),
                blurRadius: 10,
                color: (_selectedIndex != 0)
                    ? Colors.grey.withOpacity(0.5)
                    : Colors.grey.withOpacity(0),
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.black,
            selectedFontSize: 12.0,
            unselectedFontSize: 9.0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                  label: "Home",
                  icon: Column(
                    children: [
                      _selectedIndex == 0
                          ? Image.asset(
                        "assets/homefilled.png",
                        width: 25,
                        height: 25,
                        color: primaryColor,
                      )
                          : Image.asset(
                        "assets/homeoutline.png",
                        width: 25,
                        height: 25,
                      )
                    ],
                  )),
              BottomNavigationBarItem(
                  label: "ServiceCategory",
                  icon: Column(
                    children: [
                      _selectedIndex == 1
                          ? Image.asset(
                        "assets/categoryfilled.png",
                        width: 25,
                        height: 25,
                        color: primaryColor,
                      )
                          : Image.asset(
                        "assets/categoryoutline.png",
                        width: 25,
                        height: 25,
                      )
                    ],
                  )),
              BottomNavigationBarItem(
                  label: "My Appointments",
                  icon: Column(
                    children: [
                      _selectedIndex == 2
                          ? Image.asset("assets/CalendarDots1.png",
                          width: 25, height: 25, color: primaryColor)
                          : Image.asset(
                        "assets/CalendarDots.png",
                        width: 25,
                        height: 25,
                      )
                    ],
                  )),
              BottomNavigationBarItem(
                  label: "Profile",
                  icon: Column(
                    children: [
                      _selectedIndex == 3
                          ? Image.asset(
                        "assets/User.png",
                        width: 25,
                        height: 25,
                        color: primaryColor,
                      )
                          : Image.asset(
                        "assets/User1.png",
                        width: 25,
                        height: 25,
                      )
                    ],
                  )),
            ],
            currentIndex: _selectedIndex,
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }

  void showLocationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext bottomSheetContext) {
        bool hasRequestedPermission = false; // Prevent multiple requests
        return BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(bottomSheetContext).pop();
              });
            }
          },
          builder: (context, state) {
            bool isLoading = state is LocationLoading;
            bool isServiceDisabled = state is LocationServiceDisabled;
            bool isPermanentlyDenied = state is LocationError &&
                state.message.contains("permanently denied");

            return Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.grey[50]!,
                  ],
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          isServiceDisabled
                              ? 'Location Services Disabled'
                              : isPermanentlyDenied
                              ? 'Location Permissions Denied'
                              : 'Location Permission Needed',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            fontFamily: "lexend",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isServiceDisabled
                        ? 'Please enable location services to allow us to find your accurate location for better service.'
                        : isPermanentlyDenied
                        ? 'Location permissions are permanently denied. Please enable them in the app settings.'
                        : 'We need your location to provide personalized services and accurate delivery information.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                      fontFamily: "lexend",
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // if (!isPermanentlyDenied)
                      //   TextButton(
                      //     onPressed: isLoading
                      //         ? null
                      //         : () {
                      //       context.read<LocationCubit>().handlePermissionDismissed();
                      //     },
                      //     child: Text(
                      //       'NOT NOW',
                      //       style: TextStyle(
                      //         color: Colors.grey[600],
                      //         fontWeight: FontWeight.w600,
                      //         fontFamily: "lexend",
                      //       ),
                      //     ),
                      //   ),
                      ElevatedButton(
                        onPressed: isLoading || hasRequestedPermission
                            ? null
                            : () {
                          hasRequestedPermission = true;
                          if (isPermanentlyDenied) {
                            OpenAppSettings.openAppSettings();
                          } else {
                            context.read<LocationCubit>().requestLocationPermission();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                            : Text(
                          isPermanentlyDenied ? 'OPEN SETTINGS' : 'ENABLE LOCATION',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            fontFamily: "lexend",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
