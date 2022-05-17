import 'dart:developer';

import 'package:control_pad/control_pad.dart';
import 'package:control_pad/models/pad_button_item.dart';
import 'package:control_pad/views/circle_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ps5controller/common_functions.dart';
import 'package:ps5controller/enums/buttonEnums.dart';
import 'package:ps5controller/main.dart';

class ButtonController extends StatefulWidget {
  const ButtonController({Key? key}) : super(key: key);

  @override
  State<ButtonController> createState() => _ButtonControllerState();
}

class _ButtonControllerState extends State<ButtonController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  socket.emit("spacebuttonEvent");
                },
                icon: const Icon(Icons.speed_sharp),
                label: const Text("Nitro"),
              ),
              Container(
                height: 200,
                width: 300,
                color: Colors.grey,
                child: GestureDetector(
                  child: getCircle(),
                  onPanUpdate: (details) {
                    var offSet = details.localPosition;
                    Map<String, int>? finalOffSet = getFinalOffSet(offSet);
                    if (finalOffSet != null) {
                      log("$finalOffSet");
                      socket.emit("joyStickData", finalOffSet);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Map<String, int>? getFinalOffSet(Offset offSet) {
    if (isInsideThePosition(offSet)) {
      return {
        "x": (offSet.dx - 150).toInt(),
        "y": -1 * (offSet.dy - 100).toInt(),
      };
    }
    return null;
  }

  bool isInsideThePosition(Offset offSet) {
    return (offSet.dx < 300 && offSet.dx > 0) &&
        (offSet.dy < 200 && offSet.dy > 0);
  }

  Widget getCircle() {
    return const Icon(
      Icons.circle,
      size: 30,
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
          interval: const Duration(milliseconds: 100),
          showArrows: true,
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
