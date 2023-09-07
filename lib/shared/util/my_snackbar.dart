import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void showErrorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(FontAwesomeIcons.triangleExclamation, color: Colors.grey),
          const SizedBox(width: 10),
          Text(message),
        ],
      ),
      backgroundColor: Colors.red,
    ),
  );
}
