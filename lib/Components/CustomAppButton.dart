import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:revxpharma/Utils/color.dart';

class CustomAppButton extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final Color? color;
  final double? width;
  final double? height;
  final VoidCallback? onPlusTap;
  final bool? loading;

  CustomAppButton(
      {Key? key,
      required this.text,
      required this.onPlusTap,
      this.color,
      this.height,
      this.loading,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width ?? w,
      height: height ?? 42,
      child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100))),
            backgroundColor: MaterialStateProperty.all(color ?? primaryColor),
          ),
          onPressed: onPlusTap,
          child: loading ?? false
              ? Center(child: CircularProgressIndicator(strokeWidth: 1,color: Colors.white,))
              : Text(
                  text,
                  style: TextStyle(
                    color: Color(0xffFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                )),
    );
  }

  @override
  Size get preferredSize => throw UnimplementedError();
}
