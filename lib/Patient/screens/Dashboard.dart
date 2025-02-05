
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:revxpharma/Patient/screens/servicecategory.dart';
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
        body: PageView(
          onPageChanged: (value) {
            HapticFeedback.lightImpact();
          },
          controller: pageController,
          children: [
            Homescreen(),
            ServiceCategory(),
            ChatSupport(),
            Notifications(),
            Profile()
          ],
          physics: const NeverScrollableScrollPhysics(),
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
            selectedItemColor: Color(0xff27BDBE),
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
                          ? Image.asset("assets/activehome.png",width: 25,height: 25,)
                          : Image.asset("assets/home.png",width: 25,height: 25,)
                    ],
                  )),
              BottomNavigationBarItem(
                  label: "ServiceCategory",
                  icon: Column(
                    children: [
                      _selectedIndex == 1
                          ? Image.asset("assets/activeservicecatogry.png",width: 25,height: 25,)
                          : Image.asset("assets/servicecatagory.png",width: 25,height: 25,)
                    ],
                  )),
              BottomNavigationBarItem(
                  label: "ServiceCategory",
                  icon: Column(
                    children: [
                      _selectedIndex == 2
                          ? Image.asset("assets/activechat.png",width: 25,height: 25,)
                          : Image.asset("assets/chat.png",width: 25,height: 25,)
                    ],
                  )),
              BottomNavigationBarItem(
                  label: "Notification",
                  icon: Column(
                    children: [
                      _selectedIndex == 3
                          ? Image.asset("assets/activenotification.png",width: 25,height: 25,)
                          : Image.asset("assets/notification.png",width: 25,height: 25,)
                    ],
                  )),
              BottomNavigationBarItem(
                  label: "Profile",
                  icon: Column(
                    children: [
                      _selectedIndex == 4
                          ? Image.asset("assets/activeprofile.png",width: 25,height: 25,)
                          : Image.asset("assets/profile.png",width: 25,height: 25,)
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
}
