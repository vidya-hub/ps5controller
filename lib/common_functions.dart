import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:ps5controller/enums/buttonEnums.dart';
import 'package:ps5controller/main.dart';

ButtonEnum getJoyStickMovement(double degrees) {
  if (degrees >= 45 && degrees < 135) {
    return ButtonEnum.right;
  } else if (degrees >= 135 && degrees < 225) {
    return ButtonEnum.backward;
  } else if (degrees >= 225 && degrees < 315) {
    return ButtonEnum.left;
  } else if ((degrees >= 315 && degrees <= 360) ||
      (degrees >= 0 && degrees < 45)) {
    return ButtonEnum.forward;
  } else {
    return ButtonEnum.center;
  }
}

sendSocketData(double degrees) {
  ButtonEnum buttonEnum = getJoyStickMovement(degrees);
  String buttonString = getButtonString()[buttonEnum].toString();
  log(buttonString);
  socket.emit("sendButtonData", buttonString);
}

void sendJoyStickData(
  double degrees,
  double distance,
) {
  Map<String, double> joyStickModel = {
    "degrees": double.parse(degrees.toStringAsFixed(2)),
    "distance": double.parse(distance.toStringAsFixed(2)),
  };
  log("$joyStickModel");
  socket.emit("joyStickData", joyStickModel);
}

void enableRotation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
}

void setToPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
