import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class ControllerScreen extends StatefulWidget {
  const ControllerScreen({Key? key}) : super(key: key);

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
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
        child: StreamBuilder(
          stream: gyroscopeEvents.asBroadcastStream(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
                child: Center(
              child: Text(
                snapshot.hasData ? snapshot.data.toString() : "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
