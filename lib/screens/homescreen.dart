import 'package:flutter/material.dart';
import 'package:ps5controller/common_functions.dart';
import 'package:ps5controller/main.dart';
import 'package:ps5controller/screens/ButtonController.dart';
import 'package:ps5controller/screens/gyrocontrollerscreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const Center(
              child: Text(
                "PS5 Controller",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: RadioListTile(
                value: socket.connected,
                groupValue: socket.connected,
                onChanged: (value) {},
                title: const Text("Socket Connected"),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: ElevatedButton(
                child: const Text("Button Controller"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const ButtonController();
                    },
                  )).then((value) => enableRotation());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: ElevatedButton(
                child: const Text("Gyro Controller"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const ControllerScreen();
                    },
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
