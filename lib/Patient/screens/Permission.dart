import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Utils/Preferances.dart';
import 'package:revxpharma/Utils/color.dart';
import '../../Utils/PermissionManager.dart';

class MyPermission extends StatefulWidget {
  const MyPermission({super.key});
  @override
  State<MyPermission> createState() => _MyPermissionState();
}

class _MyPermissionState extends State<MyPermission> {

  @override
  void initState() {
    super.initState();
    _fetchDetailsAndCheckPermissions();
  }

  String token = "";
  bool allPermissionsGranted = false;

  Future<void> _fetchDetailsAndCheckPermissions() async {
    // Fetch token
    var tokenValue = (await PreferenceService().getString('token')) ?? "";
    setState(() {
      token = tokenValue;
    });
    await _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final granted = await PermissionManager.checkPermissions(
      context,
      onPermissionStatusChanged: (granted) {
        setState(() {
          allPermissionsGranted = granted;
        });
      },
    );
    setState(() {
      allPermissionsGranted = granted;
    });
  }

  void _navigateToAppropriateScreen() {
    if (token.isNotEmpty) {
      context.go('/dashboard');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'APP PERMISSIONS',
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPermissionItem(
                    icon: "assets/location.png",
                    title: "Location",
                    description:
                    "Access your location to provide region-specific features and services, ensuring accurate functionality and better user experience.",
                  ),
                  _buildPermissionItem(
                    icon: "assets/notification.png",
                    title: "Notifications",
                    description:
                    "Enable notifications to receive important updates about your test bookings, reminders, and promotional offers — ensuring you never miss a thing.",
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
        child: InkResponse(
          onTap: () async {
            if (allPermissionsGranted) {
              _navigateToAppropriateScreen();
            } else {
              // Retry permission request or open settings
              final granted = await PermissionManager.checkPermissions(
                context,
                onPermissionStatusChanged: (granted) {
                  setState(() {
                    allPermissionsGranted = granted;
                  });
                },
              );
              if (granted) {
                _navigateToAppropriateScreen();
              }
            }
          },
          child: Container(
            width: w,
            height: 45,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text(
              allPermissionsGranted ? 'GET STARTED' : 'GRANT PERMISSIONS',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionItem({
    required String icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color(0xFFCDE2FB),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Center(
                    child: Image.asset(
                      icon,
                      color: const Color(0xff000000),
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text(
              description,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w300,
                fontSize: 13,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
