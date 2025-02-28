import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_state.dart';
import 'package:revxpharma/Patient/screens/ProfileSettings.dart';

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
          return Center(child: CircularProgressIndicator(color: Color(0xff27BDBE),));
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
                        state.profileDetailModel.data?.fullName??'',
                        style: TextStyle(
                            color: Color(0xff151515),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins"),
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
}
