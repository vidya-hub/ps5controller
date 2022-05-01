import 'package:flutter/services.dart';
import 'package:ps5controller/enums/buttonEnums.dart';

getJoyStickMovement(double degrees) {
  if (degrees < 45 || degrees > 315) {
    return ButtonEnum.forward;
  } else if (degrees < 135) {
    return ButtonEnum.right;
  } else if (degrees < 225) {
    return ButtonEnum.backward;
  } else {
    return ButtonEnum.left;
  }
}

void enableRotation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
}
