import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_link_generator/form.dart';
import 'package:whatsapp_link_generator/header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp link generator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppHeader(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: MainForm(),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAboutDialog(
              context: context,
              applicationName: 'WhatsApp link generator',
              applicationIcon: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/whatsapp-quick-link.appspot.com/o/WhatsApp%20link%20generator%20(Custom).png?alt=media&token=7dc62d66-37a7-4862-a615-2836e9fb3d47',
                width: 80.0,
              ),
            );
          },
          child: FaIcon(FontAwesomeIcons.infoCircle),
          tooltip: 'Info',
        ));
  }
}
