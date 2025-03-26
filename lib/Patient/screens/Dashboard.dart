import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Patient/screens/Prescription.dart';
import 'package:revxpharma/Patient/screens/ScanReports.dart';
import 'package:revxpharma/Patient/screens/servicecategory.dart';
import 'package:revxpharma/Utils/color.dart';
import '../../Utils/NoInternet.dart';
import '../logic/bloc/internet_status/internet_status_bloc.dart';
import '../logic/cubit/Location/location_cubit.dart';
import '../logic/cubit/Location/location_state.dart';
import 'ChatSupport.dart';
import 'HomeScreen.dart';
import 'Notification.dart';
import 'Profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PageController pageController = PageController();
  int _selectedIndex = 0;

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
              }
            },
            child: PageView(
              onPageChanged: (value) {
                HapticFeedback.lightImpact();
              },
              controller: pageController,
              children: [
                Homescreen(),
                ServiceCategory(),
                ScanReports(),
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
                              "assets/activehome.png",
                              width: 25,
                              height: 25,
                              color: primaryColor,
                            )
                          : Image.asset(
                              "assets/home.png",
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
                              "assets/activeservicecatogry.png",
                              width: 25,
                              height: 25,
                              color: primaryColor,
                            )
                          : Image.asset(
                              "assets/servicecatagory.png",
                              width: 25,
                              height: 25,
                            )
                    ],
                  )),
              BottomNavigationBarItem(
                  label: "ScanReports",
                  icon: Column(
                    children: [
                      _selectedIndex == 2
                          ? Image.asset("assets/scanreports1.png",
                              width: 25, height: 25, color: primaryColor)
                          : Image.asset(
                              "assets/FileText.png",
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
                              "assets/activeprofile.png",
                              width: 25,
                              height: 25,
                              color: primaryColor,
                            )
                          : Image.asset(
                              "assets/profile.png",
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
      builder: (BuildContext bottomSheetContext) {
        return BlocConsumer<LocationCubit, LocationState>(
          listener: (context, state) {
            if (state is LocationLoaded) {
              // Close the bottom sheet when location is successfully fetched
              Navigator.pop(bottomSheetContext);
            }
          },
          builder: (context, state) {
            bool isLoading = state is LocationLoading;
            return WillPopScope(
              onWillPop: () async => !isLoading,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.gps_fixed_sharp, size: 18),
                        const SizedBox(width: 10),
                        Text(
                          'Location Permission is Off',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  context
                                      .read<LocationCubit>()
                                      .requestLocationPermission();
                                },
                          child: isLoading
                              ? CircularProgressIndicator(strokeWidth: 2)
                              : const Text('GRANT'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Granting location permission will ensure accurate address and hassle-free service.',
                      style: TextStyle(fontSize: 14),
                    ),
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
