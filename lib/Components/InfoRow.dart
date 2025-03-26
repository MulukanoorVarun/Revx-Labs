import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xff333333),
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              fontSize: 14,
            ),
          ),
        ),
        const Text(
          ":",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: Color(0xff333333),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
