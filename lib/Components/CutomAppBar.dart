import 'package:flutter/material.dart';

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
      automaticallyImplyLeading: false,
      leading: Container(),
      leadingWidth: 0,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 20,
                  color: Colors.black,
                )),
            Text(
              title,
              style: TextStyle(
                color: Color(0xff000000),
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
