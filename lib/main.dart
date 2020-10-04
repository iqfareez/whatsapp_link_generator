import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whatsapp_link_generator/CONSTANTS.dart';
import 'package:whatsapp_link_generator/form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      // debugShowCheckedModeBanner: false,
      title: 'WhatsApp link generator',
      themeMode: ThemeMode.light,
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
        appBar: NeumorphicAppBar(
          title: Text(
            'WhatsApp link generator',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MainForm(),
            )
          ],
        ),
        floatingActionButton: NeumorphicFloatingActionButton(
          style: NeumorphicStyle(depth: -16, color: Colors.teal.shade400),
          onPressed: () {
            showAboutDialog(
                context: context,
                applicationName: 'WhatsApp link generator',
                applicationVersion: '1.2.4+3',
                applicationLegalese: '© maplerr 2020',
                applicationIcon: Image.network(
                  IconImageUrl,
                  width: 60.0,
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
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text('https://whatsapp-quick-link.web.app/'),
                  )
                ]);
          },
          child: Center(child: FaIcon(FontAwesomeIcons.infoCircle)),
          tooltip: 'Info',
          mini: true,
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
