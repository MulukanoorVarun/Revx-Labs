import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revxpharma/Authentication/LogInWithEmail.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Patient/screens/Dashboard.dart';
import 'package:revxpharma/Utils/Preferances.dart';

class MyPermission extends StatefulWidget {
  const MyPermission({super.key});
  @override
  State<MyPermission> createState() => _MyPermissionState();
}
class _MyPermissionState extends State<MyPermission> {
  @override
  void initState() {
    super.initState();
    checkPermissions();
    Fetchdetails();
  }

  String token = "";
  bool allPermissionsGranted = false;

  Fetchdetails() async {
    var Token = (await PreferenceService().getString('token')) ?? "";
    setState(() {
      token = Token;
    });
    print("Token:${token}");
  }

  Future<void> checkPermissions() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    List<Permission> requiredPermissions = [
      Permission.location,
      Permission.camera,
      Permission.notification,
    ];

    if (android.version.sdkInt < 33) {
      requiredPermissions.add(Permission.storage); // Deprecated in Android 13+
    } else {
      print("isAndroid11orAbove");
      requiredPermissions.add(Permission.photos);
    }

    // Request permissions
    Map<Permission, PermissionStatus> statuses = {};
    for (var permission in requiredPermissions) {
      statuses[permission] = await permission.request();
    }

    // Check if all required permissions are granted
    setState(() {
      allPermissionsGranted =
          statuses.values.every((status) => status.isGranted);
    });

    // Handle denied or permanently denied permissions
    if (!allPermissionsGranted) {
      _handleDeniedPermissions(statuses);
    }
  }

  void _handleDeniedPermissions(Map<Permission, PermissionStatus> statuses) {
    List<Permission> deniedPermissions = statuses.entries
        .where((entry) => entry.value.isDenied)
        .map((entry) => entry.key)
        .toList();

    List<Permission> permanentlyDeniedPermissions = statuses.entries
        .where((entry) => entry.value.isPermanentlyDenied)
        .map((entry) => entry.key)
        .toList();

    if (permanentlyDeniedPermissions.isNotEmpty) {
      _showPermanentlyDeniedDialog();
    } else if (deniedPermissions.isNotEmpty) {
      _showPermissionDeniedDialog(deniedPermissions);
    }
  }

  void _showPermissionDeniedDialog(List<Permission> deniedPermissions) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Permissions Required"),
        content: Text(
            "The app needs the following permissions: ${deniedPermissions.join(", ")}. Please grant them to continue.",
            style: TextStyle(
              fontFamily: 'Poppins',
            )),
        actions: [
          TextButton(
            child: Text("Retry",
                style: TextStyle(
                  fontFamily: 'Poppins',
                )),
            onPressed: () {
              Navigator.of(context).pop();
              checkPermissions(); // Retry permission request
            },
          ),
        ],
      ),
    );
  }

  void _showPermanentlyDeniedDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Permissions Denied"),
        content: Text(
            "Some permissions have been permanently denied. Please enable them in Settings.",
            style: TextStyle(
              fontFamily: 'Poppins',
            )),
        actions: [
          TextButton(
            child: Text(
              "Go to Settings",
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              SystemNavigator.pop();
              openAppSettings(); // Open app settings
            },
          ),
        ],
      ),
    );
  }

// Function to handle navigation based on token
  void _navigateToAppropriateScreen() {
    if (token != "") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LogInWithEmail()),
      );
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
              padding: EdgeInsets.only(left: 16, right: 16),
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
                    icon: "assets/camera.png",
                    title: "Camera",
                    description:
                        "Allow access to your camera to capture photos or videos for in-app functionality such as profile pictures or real-time media use.",
                  ),
                  _buildPermissionItem(
                    icon: "assets/gallery.png",
                    title: "Photo / Media / Files",
                    description:
                        "Grant access to your storage to upload or save media, documents, and files, supporting seamless interaction with app features.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
        child: InkResponse(
          onTap: () {
            if (allPermissionsGranted) {
              _navigateToAppropriateScreen();
            } else {
              openAppSettings();
            }
          },
          child: Container(
            width: w,
            height: 45,
            padding: EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: Color(0xFF00C4D3),
              borderRadius: BorderRadius.circular(30),
            ),
            alignment: Alignment.center,
            child: Text(
              'GET STARTED',
              style: TextStyle(
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
    return Container(padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        
      ),

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
                  color: Color(0xFFCDE2FB),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Center(
                    child: Image.asset(
                      icon,
                      color: Color(0xff000000),
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
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 7,
            ),
            child: Text(
              description,
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                  color: Color(0xFF00C4D3)),
            ),
          ),
        ],
      ),
    );
  }
}
