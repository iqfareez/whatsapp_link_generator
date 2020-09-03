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
        depth: 8,
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
