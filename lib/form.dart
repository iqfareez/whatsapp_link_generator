import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MainForm extends StatefulWidget {
  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  TextEditingController phoneNumController = TextEditingController();
  String phoneNum = '';

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Neumorphic(
                style: NeumorphicStyle(
                    depth: -24.0,
                    intensity: 18.0,
                    color: Colors.transparent,
                    shape: NeumorphicShape.convex,
                    lightSource: LightSource.top),
                child: TextField(
                  controller: phoneNumController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.ac_unit),
                    suffixIcon: Icon(null),
                    hintText: 'Eg: 601956291',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Neumorhic docs - https://pub.dev/packages/flutter_neumorphic
