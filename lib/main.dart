import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_link_generator/CONSTANTS.dart';
import 'package:whatsapp_link_generator/custom_widget.dart';
import 'package:whatsapp_link_generator/form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
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
          leading: Icon(FontAwesomeIcons.whatsapp),
          title: Text(
            'WhatsApp Link Generator',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: MainForm(),
        floatingActionButton: NeumorphicFloatingActionButton(
          style: NeumorphicStyle(depth: -16, color: Colors.teal.shade400),
          onPressed: () {
            showAboutDialog(
                context: context,
                applicationName: 'WhatsApp Link Generator',
                applicationVersion: '1.2.4+3',
                applicationLegalese: '© maplerr 2020',
                applicationIcon: Image.network(
                  IconImageUrl,
                  width: 60.0,
                ),
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Text('https://whatsapp-quick-link.web.app/'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FlatButton(
                        child: FaIcon(
                          FontAwesomeIcons.twitter,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          _launchURL(context, 'https://twitter.com/iqfareez2');
                        },
                      ),
                      FlatButton(
                        child: FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.purple,
                        ),
                        onPressed: () {
                          _launchURL(
                              context, 'https://www.instagram.com/iqfareez/');
                        },
                      ),
                      FlatButton(
                        child: FaIcon(
                          FontAwesomeIcons.github,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          _launchURL(context,
                              'https://github.com/fareezMaple/WhatsApp-Link-Generator-Flutter');
                        },
                      ),
                    ],
                  ),
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

_launchURL(BuildContext context, String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    CustomWidgets.buildErrorSnackbar(context, 'Error opening socmed');
    throw 'Could not launch $url';
  }
}
