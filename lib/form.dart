import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MainForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 5.0),
      child: Column(
        children: [
          inputForm(),
        ],
      ),
    );
  }

  Widget inputForm() {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.convex,
        depth: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[300],
        ),
        child: Column(
          children: [
            Text('Phone number here'),
            Text('Include your country code'),
            Neumorphic(child: TextField()),
          ],
        ),
      ),
    );
  }
}

//Neumorhic docs - https://pub.dev/packages/flutter_neumorphic
