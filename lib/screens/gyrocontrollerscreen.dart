import 'package:flutter/material.dart';
import 'package:ps5controller/main.dart';
import 'package:ps5controller/model/gyrodata.dart';
import 'package:ps5controller/service/socket-server.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ControllerScreen extends StatefulWidget {
  const ControllerScreen({Key? key}) : super(key: key);

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  @override
  void dispose() {
    gyroscopeEvents.asBroadcastStream().drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Controller"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: StreamBuilder<GyroscopeEvent>(
          stream: gyroscopeEvents.asBroadcastStream(),
          builder: (
            BuildContext context,
            AsyncSnapshot<GyroscopeEvent> snapshot,
          ) {
            if (snapshot.hasData) {
              GyroData gyroData = GyroData(
                x: double.parse(snapshot.data!.x.toStringAsFixed(3)),
                y: double.parse(snapshot.data!.x.toStringAsFixed(3)),
                z: double.parse(snapshot.data!.x.toStringAsFixed(3)),
              );
              sendData(socket, gyroData);
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "  X Value ${snapshot.data?.x.toStringAsFixed(4) ?? ""}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "  Y Value ${snapshot.data?.y.toStringAsFixed(4) ?? ""}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "  Z Value ${snapshot.data?.z.toStringAsFixed(4) ?? ""}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
