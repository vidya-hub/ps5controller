//192.168.0.131

import 'package:ps5controller/model/gyrodata.dart';
import 'package:socket_io_client/socket_io_client.dart';

Future sendData(
  Socket socket,
  GyroData data,
) async {
  socket.emit(
    "sendGyroData",
    data.toJson(),
  );
}
