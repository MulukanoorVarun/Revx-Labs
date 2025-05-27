import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, size: 24),
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.all(8),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xff151515),
          fontSize: 17,
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 20),
    );
  }
}
