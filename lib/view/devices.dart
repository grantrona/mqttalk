import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
