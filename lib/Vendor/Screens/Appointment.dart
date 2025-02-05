import 'package:flutter/material.dart';
import 'package:revxpharma/Components/CutomAppBar.dart';

class Appointments extends StatefulWidget {
  const Appointments({super.key});

  @override
  State<Appointments> createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Appointments',
          actions: [
            IconButton.filledTonal(
                visualDensity: VisualDensity.compact,
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.zero),
                    shape: MaterialStateProperty.all(
                        CircleBorder()),
                    backgroundColor:
                    MaterialStateProperty.all(
                        Color(0xffE5FCFC))),
                icon: Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 18,
                )),
            CircleAvatar(radius: 16,
              child: Image.asset('assets/person.png', fit: BoxFit.contain),
            ),
            SizedBox(width: 10), // Add some space between the icon and the avatar
          ],
          // We no longer need iconList and onPressedList here
        ));
  }
}
