import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
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
        SystemNavigator.pop();
        return false;
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
                // ScanReports(),
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
              // BottomNavigationBarItem(
              //     label: "Notification",
              //     icon: Column(
              //       children: [
              //         _selectedIndex == 3
              //             ? Image.asset(
              //                 "assets/activenotification.png",
              //                 width: 25,
              //                 height: 25,
              //               )
              //             : Image.asset(
              //                 "assets/notification.png",
              //                 width: 25,
              //                 height: 25,
              //               )
              //       ],
              //     )
              // ),
              // BottomNavigationBarItem(
              //     label: "Reports",
              //     icon: Column(
              //       children: [
              //         _selectedIndex == 2
              //             ? Image.asset(
              //           "assets/active_reports.png",
              //           width: 25,
              //           height: 25,
              //           color: primaryColor,
              //         )
              //             : Image.asset(
              //           "assets/reports.png",
              //           width: 25,
              //           height: 25,
              //         )
              //       ],
              //     )),
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
      isScrollControlled: true, // Allow dynamic height
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationLoaded) {
              Navigator.pop(bottomSheetContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Location fetched successfully!')),
              );
            } else if (state is LocationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            bool isLoading = state is LocationLoading;
            String message =
                'Granting location permission will ensure accurate address and hassle-free service.';

            if (state is LocationPermissionDenied) {
              message = 'Location permission is required to proceed.';
            } else if (state is LocationError) {
              message = state.message;
            }

            return WillPopScope(
              onWillPop: () async => !isLoading,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.gps_fixed_sharp, size: 18),
                        const SizedBox(width: 10),
                        const Text(
                          'Location Permission',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (state is LocationError &&
                                      state.message
                                          .contains('permanently denied')) {
                                    Geolocator.openAppSettings();
                                  } else {
                                    context
                                        .read<LocationCubit>()
                                        .requestLocationPermission();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Text(state is LocationError &&
                                      state.message
                                          .contains('permanently denied')
                                  ? 'OPEN SETTINGS'
                                  : 'GRANT'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      message,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    if (state is LocationError) ...[
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => context
                            .read<LocationCubit>()
                            .checkLocationPermission(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
