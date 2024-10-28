import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DeviceFrame(
          device: Devices.android.samsungGalaxyA50,
          orientation: Orientation.portrait,
          screen: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text(
                "Salut la team",
                style: TextStyle(color: Colors.white),
              ),
            ),
            // body: ListView.builder(
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text("Mon titre ${index + 1}"),
            //       subtitle: Text("Salut la team"),
            //     );
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
