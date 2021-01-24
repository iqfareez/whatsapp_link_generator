//Custom class in project directory
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomWidgets {
  CustomWidgets._();
  static buildErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(FontAwesomeIcons.exclamationTriangle, color: Colors.grey),
            SizedBox(width: 10),
            Text("$message"),
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
