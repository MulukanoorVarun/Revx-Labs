import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_state.dart';
import 'package:revxpharma/Patient/screens/ProfileSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Authentication/LogInWithEmail.dart';
import '../../Utils/constants.dart';
import 'AccountSettings.dart';
import 'MyAppointments.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    context.read<ProfileCubit>().getProfileDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Profile", actions: []),
      body: BlocBuilder<ProfileCubit,ProfileState>(builder: (context, state) {
        if(state is ProfileStateLoading){
          return _shimmerList();
        }else if(state is ProfileStateLoaded){
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius:60,
                            backgroundColor: Color(0xff27BDBE), // Set background color for initials
                            child:
                            // state.prfileDetails.data?.image != null &&
                            //     state.prfileDetails.data!.image!.isNotEmpty
                            //     ? ClipRRect(
                            //   borderRadius: BorderRadius.circular(50), // Ensures it's circular
                            //   child: Image.network(
                            //     state.prfileDetails.data!.image!,
                            //     fit: BoxFit.cover,
                            //     width: double.infinity,
                            //     height: double.infinity,
                            //   ),
                            // )
                            //     :
                            Text(
                              state.profileDetailModel.data?.fullName?.isNotEmpty == true
                                  ? state.profileDetailModel.data!.fullName![0].toUpperCase()
                                  : "?",
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Positioned(
                          //     bottom: 0,
                          //     right: 5,
                          //     child: Container(
                          //         decoration: BoxDecoration(
                          //           shape: BoxShape.circle,
                          //           color: Colors.grey.shade200,
                          //         ),
                          //         child: IconButton(
                          //           visualDensity: VisualDensity.compact,
                          //           onPressed: () {
                          //             Navigator.push(
                          //                 context,
                          //                 MaterialPageRoute(
                          //                     builder: (context) =>
                          //                         ProfileSettings()));
                          //           },
                          //           style: ButtonStyle(
                          //               padding: MaterialStateProperty.all(
                          //                   EdgeInsets.zero)),
                          //           icon: Icon(
                          //             Icons.edit,
                          //             color: Color(0xff27BDBE),
                          //             size: 20,
                          //           ),
                          //         ))),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        StringUtils.capitalizeFirstLetter(state.profileDetailModel.data?.fullName),
                        style: TextStyle(
                          color: Color(0xff151515),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        state.profileDetailModel.data?.mobile??'',
                        style: TextStyle(
                            color: Color(0xff151515),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("My Profile",
                    style: TextStyle(
                        color: Color(0xff151515),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins")),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Myappointments()));
                  },
                  leading: Image.asset(
                    "assets/apointments.png",
                    height: 24,
                    width: 24,
                  ),
                  title: Text(
                    "My Appointments",
                    style: TextStyle(
                      color: Color(0xff151515),
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Accountsettings()));
                  },
                  leading: Image.asset(
                    "assets/settings.png",
                    height: 24,
                    width: 24,
                  ),
                  title: Text(
                    "Settings",
                    style: TextStyle(
                      color: Color(0xff151515),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                ),
                ListTile(
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                  leading: Icon(Icons.logout_outlined,size: 24,),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: Color(0xff151515),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                ),
              ],
            ),
          );
        }else if(state is ProfileStateError){
          return Center(child: Text(state.message));
        }
        return Center(child: Text("No Data"));

      },

      ),
    );
  }
Widget _shimmerList(){
    return Padding(
      padding:  EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    shimmerContainer(60, 60, context),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
               shimmerText(50, 12, context),
                SizedBox(
                  height: 10,
                ), shimmerText(50, 12, context),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          shimmerText(80, 12, context),
          ListView.builder(shrinkWrap: true,itemCount: 10,
            itemBuilder: (context, index) {
            return  ListTile(
              leading: shimmerRectangle(24, context),
              title: shimmerText(100, 12, context),
              trailing: shimmerRectangle(10, context),
            );
          },

          ),

        ],
      ),
    );

}
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 4.0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 14.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Power Icon Positioned Above Dialog
                Positioned(
                  top: -35.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    width: 70.0,
                    height: 70.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(width: 6.0, color: Colors.white),
                      shape: BoxShape.circle,
                      color: Colors.red.shade100, // Light red background
                    ),
                    child: const Icon(
                      Icons.power_settings_new,
                      size: 40.0,
                      color: Colors.red, // Power icon color
                    ),
                  ),
                ),

                // Dialog Content
                Positioned.fill(
                  top: 30.0, // Moves content down
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 15.0),
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff27BDBE),
                              fontFamily: "Poppins"
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "Are you sure you want to logout?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              fontFamily: "Poppins"
                          ),
                        ),
                        const SizedBox(height: 20.0),

                        // Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // No Button (Filled)
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                  Color(0xff27BDBE), // Filled button color
                                  foregroundColor: Colors.white, // Text color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: const Text("No",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: "Poppins"
                                  ),
                                ),
                              ),
                            ),

                            // Yes Button (Outlined)
                            SizedBox(
                              width: 100,
                              child: OutlinedButton(
                                onPressed: () async {
                                  SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                                  sharedPreferences.remove('access_token');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LogInWithEmail()));
                                },
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                  Color(0xff27BDBE), // Text color
                                  side: BorderSide(
                                      color: Color(0xff27BDBE)), // Border color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: const Text(
                                  "Yes",
                                  style: TextStyle( fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
