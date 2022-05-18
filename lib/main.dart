import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ps5controller/common_functions.dart';
import 'package:ps5controller/screens/gyrocontrollerscreen.dart';
import 'package:ps5controller/screens/homescreen.dart';
import 'package:socket_io_client/socket_io_client.dart';

late final Socket socket;
void main() async {
  try {
    socketConnect().then((value) => {
          runApp(
            MyApp(),
          ),
        });
  } catch (e) {
    print(e);
  }
}

String clientUrl = "http://192.168.0.131:3000";
Future socketConnect() async {
  socket = io(clientUrl, <String, dynamic>{
    "transports": ["websocket"],
    "autoConnect": true,
  });
  socket.connect();
  socket.on('connect', (data) {
    log("here   ${socket.connected}");
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
