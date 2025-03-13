import 'package:flutter/material.dart';
import 'package:revxpharma/Utils/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        visualDensity: VisualDensity.compact,
        onPressed: () {
          Navigator.pop(context, true);
        },
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: primaryColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: primaryColor,
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: actions,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(2), // Height of the bottom border
        child: Container(
          color: Colors.grey.shade200, // Border color
          height: 1, // Border thickness
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
