import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class testui extends StatefulWidget {
  const testui({super.key});

  @override
  State<testui> createState() => _testuiState();
}

class _testuiState extends State<testui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Flexible(
            flex: 2,
              fit: FlexFit.tight,
              child: Container(
                color: Colors.redAccent,
                height: 200,
              )),
          SizedBox(height: 20,),
          Flexible(
            flex: 1,
              fit: FlexFit.tight,
              child: Container(
                color: Colors.redAccent,
                height: 200,
              ))
        ],
      ),
    );
  }
}
