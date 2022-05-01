import 'dart:developer';

import 'package:control_pad/control_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ps5controller/common_functions.dart';
import 'package:ps5controller/main.dart';

class ButtonController extends StatefulWidget {
  const ButtonController({Key? key}) : super(key: key);

  @override
  State<ButtonController> createState() => _ButtonControllerState();
}

class _ButtonControllerState extends State<ButtonController> {
  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: isPortrait
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Change device orientation to landscape",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Icon(
                    Icons.screen_rotation_sharp,
                    color: Colors.blue,
                    size: 50,
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getJoyStickWidget(
                  context,
                  "Left",
                  (double degrees, double distance) {
                    getJoyStickMovement(degrees);
                  },
                ),
                getJoyStickWidget(
                  context,
                  "Right",
                  (double degrees, double distance) {
                    getJoyStickMovement(degrees);
                  },
                ),
              ],
            ),
    );
  }

  Widget getJoyStickWidget(
    BuildContext context,
    String stickText,
    JoystickDirectionCallback onDirectionChanged,
  ) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        ),
        JoystickView(
          onDirectionChanged: onDirectionChanged,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Text(
          stickText,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
