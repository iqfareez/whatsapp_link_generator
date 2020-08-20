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
          fontFamily: 'Helvetivca'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppHeader(),
            Expanded(
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
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
                applicationVersion: '1.0.0+1',
                applicationLegalese: '©maplerr 2020',
                applicationIcon: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/whatsapp-quick-link.appspot.com/o/WhatsApp%20link%20generator%20(Custom).png?alt=media&token=7dc62d66-37a7-4862-a615-2836e9fb3d47',
                  width: 80.0,
                ),
                children: <Widget>[
                  FlatButton(
                    child: FaIcon(
                      FontAwesomeIcons.twitter,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      print('Twitter pressed');
                    },
                  )
                ]);
          },
          child: FaIcon(FontAwesomeIcons.infoCircle),
          tooltip: 'Info',
          mini: true,
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
