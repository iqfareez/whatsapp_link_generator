import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeuButton extends StatelessWidget {
  const NeuButton({Key key, this.label, this.onPressedButton})
      : super(key: key);

  final String label;
  final Function onPressedButton;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      margin: EdgeInsets.all(16.0),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        depth: 4,
      ),
      child: FlatButton(
        child: Text(label),
        onPressed: () {
          print('Called $label');
          onPressedButton();
        },
      ),
    );
  }
}

class NeumorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
        margin: EdgeInsets.only(top: 12),
        onPressed: () {},
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          "Toggle Theme",
        ));
  }
}
