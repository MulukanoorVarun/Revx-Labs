
import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
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
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: "Poppins",
              fontSize: 14,
            ),
          ),
        ),
        Text(
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
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
