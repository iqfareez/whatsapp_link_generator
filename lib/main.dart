import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_link_generator/CONSTANTS.dart';
import 'custom_widget.dart';
import 'form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appName = 'WA link generator';
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      // debugShowCheckedModeBanner: false,
      title: appName,
      themeMode: ThemeMode.light,
      home: MyHomePage(
        appName: appName,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({this.appName});
  final String appName;

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
            appName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: MainForm(),
        floatingActionButton: NeumorphicFloatingActionButton(
          style: NeumorphicStyle(depth: -16, color: Colors.teal.shade400),
          onPressed: () {
            showAboutDialog(
              context: context,
              applicationName: appName,
              applicationVersion: '1.2.14-F+6',
              applicationLegalese: 'Copyright © Muhammad Fareez 2021',
              applicationIcon: Image.asset(
                'assets/logo.png',
                width: 48.0,
              ),
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                FlatButton.icon(
                  onPressed: () {
                    Share.share(
                        'Hey! I\'m using WA Link Generator to generate whatsapp contact link and QR code. Download it now on Google Play Store: $kPlayStoreLink');
                  },
                  icon: FaIcon(FontAwesomeIcons.share),
                  label: Text('Share this app'),
                ),
                SizedBox(
                  height: 10,
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
                            'https://github.com/iqfareez/WhatsApp-Link-Generator-Flutter');
                      },
                    ),
                  ],
                ),
              ],
            );
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
