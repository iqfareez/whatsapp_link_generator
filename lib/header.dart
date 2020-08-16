import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        child: Center(
          child: AutoSizeText(
            'WhatsApp link tool',
            style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.bold),
            minFontSize: 20,
            maxFontSize: 50,
            maxLines: 2,
          ),
        ),
        height: 238,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.green.shade600, Colors.teal.shade600],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
            image: DecorationImage(
              image: AssetImage("assets/images/abstract_shapes_3874551.png"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.white24.withOpacity(0.2), BlendMode.dstATop),
            )),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

//idea https://youtu.be/zx6uMCoW2gQ - COVID-19 App - Flutter UI - Speed Code
