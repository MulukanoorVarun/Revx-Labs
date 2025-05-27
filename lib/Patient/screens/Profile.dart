import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';
import 'package:revxpharma/Components/Shimmers.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_cubit.dart';
import 'package:revxpharma/Patient/logic/cubit/profile_details/profile_state.dart';
import 'package:revxpharma/Patient/screens/ProfileSettings.dart';
import 'package:revxpharma/Patient/screens/widgets/SettingsTile.dart';
import 'package:revxpharma/Utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Authentication/LogInWithEmail.dart';
import '../../Components/CustomSnackBar.dart';
import '../../Models/ProfileDetailModel.dart';
import '../../Utils/constants.dart';
import '../logic/cubit/delete_account/DeleteAccountCubit.dart';
import '../logic/cubit/delete_account/DeleteAccountStates.dart';
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
                SettingsTile(
                  icon: Icons.policy_outlined,
                  title: "Terms & Conditions",
                  onTap: () => context.push("/terms_conditions"),
                ),
                SettingsTile(
                  icon: Icons.assignment_return_outlined,
                  title: "Refund Policy",
                  onTap: () => context.push("/refund_policy"), // same route assumed
                ),
                SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: "Privacy Policy",
                  onTap: () => context.push("/privacy_policy"),
                ),
                SettingsTile(
                  icon: Icons.logout_outlined,
                  title: "Logout",
                  onTap: () => _showLogoutDialog(context),
                ),
                SettingsTile(
                  icon: Icons.delete_forever,
                  title: "Delete Account",
                  onTap: () => DeleteAccountConfirmation.showDeleteConfirmationSheet(context),
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

class DeleteAccountConfirmation {
  static void showDeleteConfirmationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      elevation: 8,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
                listener: (context, state) {
              if (state is DeleteAccountSuccessState) {
                context.pushReplacement('/login_mobile');
                CustomSnackBar1.show(context, state.message ?? '');
              } else if (state is DeleteAccountError) {
                CustomSnackBar1.show(context, state.message ?? '');
              }
            }, builder: (context, state) {
              final bool isLoading = state is DeleteAccountLoading;
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // Description
                    Text(
                      'Are you sure you want to delete your account?',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black87,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          fontFamily: "lexend"),
                      textAlign: TextAlign.center,
                    ),
                    // Description
                    Text(
                      'All your data, including Booking history and preferences, will be permanently removed.',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                          fontFamily: "lexend"),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    context.pop();
                                  },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey[400]!),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    context
                                        .read<DeleteAccountCubit>()
                                        .deleteAccount();
                                  },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                              backgroundColor: primaryColor,
                              foregroundColor: primaryColor,
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            });
          },
        );
      },
    );
  }
}
