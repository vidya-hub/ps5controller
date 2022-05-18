import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ps5controller/main.dart';

class ButtonController extends StatefulWidget {
  const ButtonController({Key? key}) : super(key: key);

  @override
  State<ButtonController> createState() => _ButtonControllerState();
}

class _ButtonControllerState extends State<ButtonController>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 300);
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
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: duration,
                      child: SizedBox(
                        width: 300,
                        height: 200,
                        child: GestureDetector(
                          child: getCircle(),
                          onPanUpdate: (DragUpdateDetails details) {
                            var offSet = details.localPosition;
                            Map<String, int>? finalOffSet =
                                getFinalOffSet(offSet);
                            if (finalOffSet != null) {
                              log("$finalOffSet");
                              // socket.emit("joyStickData", finalOffSet);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
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
      Icons.radio_button_checked_rounded,
      size: 90,
    );
  }
}
