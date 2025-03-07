import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:revxpharma/Authentication/LogInWithEmail.dart';
import 'package:revxpharma/Patient/screens/Dashboard.dart';
import 'package:revxpharma/Patient/screens/Onboard1.dart';
import 'package:revxpharma/Patient/screens/Permission.dart';
import 'package:revxpharma/Utils/Preferances.dart';
import 'package:revxpharma/Vendor/Screens/VendorDashBoard.dart';
import '../../Utils/NoInternet.dart';
import '../logic/bloc/internet_status/internet_status_bloc.dart';
import 'OnBoarding.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String token = "";
  String status = "";

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    fetchDetails();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String Status = '';
  String Status1 = '';
  String Token = '';
  bool permissions_granted = false;
  String role="";

  void fetchDetails() async {
    var status = await PreferenceService().getString('on_boarding');
    var status1 = await PreferenceService().getString('on_boarding1');
    var token = await PreferenceService().getString('access_token');
    var Role = await PreferenceService().getString('role');

    setState(() {
      Status = status ?? '';
      Status1 = status1 ?? '';
      Token = token ?? '';
      role = Role ?? "" ;
    });
  }

  Future<void> _checkPermissions() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    Map<Permission, PermissionStatus> statuses = {
      Permission.location: await Permission.location.status,
      Permission.camera: await Permission.camera.status,
      Permission.notification: await Permission.notification.status,
    };

    if (android.version.sdkInt < 33) {

      statuses[Permission.storage] =
      await Permission.storage.status; // For Android 12 and below
    } else {
      statuses[Permission.photos] =
      await Permission.photos.status; // For Android 13+
    }

    bool allPermissionsGranted = statuses.values.every((status) => status.isGranted);

    setState(() {
      permissions_granted = allPermissionsGranted;
      print("permissions_granted:${permissions_granted}");
    });
      _navigateToNextScreen();
  }
  void _navigateToNextScreen() {
    Future.microtask(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Status == ''
              ? OnBoard()
              : Status1 == ''
              ? OnBoardOne()
              : permissions_granted == false
              ? MyPermission()
              : Token == ''
              ? LogInWithEmail()
              : (role == "Patient")
              ? Dashboard()
              : VendorDashboard(),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<InternetStatusBloc, InternetStatusState>(
        listener: (context, state) {
            if (state is InternetStatusLostState) {
            Future.microtask(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => NoInternetWidget()),
              );
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.white,
              height: screenheight,
              child: Center(
                child: Image.asset(
                  "assets/logo.png",
                  width: 260,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}