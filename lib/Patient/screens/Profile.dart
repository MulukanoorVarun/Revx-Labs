import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_state.dart';
import 'package:revxpharma/Patient/screens/ProfileSettings.dart';
import 'package:revxpharma/Utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Authentication/LogInWithEmail.dart';
import '../../Models/ProfileDetailModel.dart';
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
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileStateLoading) {
            return _shimmerList();
          } else if (state is ProfileStateError) {
            return Center(child: Text(state.message));
          }
          ProfileDetailModel? profileData =
              state is ProfileStateLoaded ? state.profileDetailModel : null;
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
                            radius: 60,
                            backgroundColor: Colors.grey.withOpacity(0.5),
                            backgroundImage: (profileData != null &&
                                    profileData.data?.image?.isNotEmpty == true)
                                ? NetworkImage(profileData.data!.image!)
                                    as ImageProvider<Object>
                                : AssetImage('assets/person.png')
                                    as ImageProvider<Object>,
                            child: (profileData == null ||
                                    profileData.data?.image?.isEmpty != false)
                                ? Text(
                                    (profileData != null &&
                                            profileData.data?.fullName
                                                    ?.isNotEmpty ==
                                                true)
                                        ? profileData.data!.fullName![0]
                                            .toUpperCase()
                                        : '',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  )
                                : null,
                          ),
                          Positioned(
                              bottom: 0,
                              right: 5,
                              child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200,
                                  ),
                                  child: IconButton(
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () {
                                      context.push("/edit_profile");
                                    },
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero)),
                                    icon: Icon(
                                      Icons.edit,
                                      color: primaryColor,
                                      size: 20,
                                    ),
                                  ))),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        StringUtils.capitalizeFirstLetter(
                            profileData?.data?.fullName),
                        style: TextStyle(
                          color: Color(0xff151515),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        profileData?.data?.mobile ?? "",
                        style: TextStyle(
                            color: Color(0xff151515),
                            fontSize: 16,
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
                // ListTile(
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => Myappointments()));
                //   },
                //   leading: Image.asset(
                //     "assets/apointments.png",
                //     height: 24,
                //     width: 24,
                //   ),
                //   title: Text(
                //     "My Appointments",
                //     style: TextStyle(
                //       color: Color(0xff151515),
                //       fontSize: 17,
                //       fontWeight: FontWeight.w400,
                //       fontFamily: "Poppins",
                //     ),
                //   ),
                //   trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20),
                // ),
                ListTile(
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                  leading: Icon(
                    Icons.logout_outlined,
                    size: 24,
                  ),
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
        },
      ),
    );
  }

  Widget _shimmerList() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    shimmerCircle(100, context),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                shimmerText(100, 12, context),
                SizedBox(
                  height: 10,
                ),
                shimmerText(150, 12, context),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          shimmerText(80, 12, context),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: (context, index) {
              return ListTile(
                leading: shimmerRectangle(30, context),
                title: shimmerText(70, 12, context),
                trailing: shimmerRectangle(20, context),
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
                              color: primaryColor,
                              fontFamily: "Poppins"),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          "Are you sure you want to logout?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                              fontFamily: "Poppins"),
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
                                      primaryColor, // Filled button color
                                  foregroundColor: Colors.white, // Text color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: const Text(
                                  "No",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily: "Poppins"),
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
                                  foregroundColor: primaryColor, // Text color
                                  side: BorderSide(
                                      color: primaryColor), // Border color
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                ),
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
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
