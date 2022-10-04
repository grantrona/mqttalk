import 'package:flutter/material.dart';

class Devices extends StatelessWidget {
  const Devices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Center(child: Text("Paired Devices")),
        ],
      ),
    );
  }
}
