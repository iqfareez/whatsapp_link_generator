import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_link_generator/CONSTANTS.dart';

import 'custom_widget.dart';
import 'form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final appName = 'WA link generator';

  const MyApp({Key? key}) : super(key: key);
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
  const MyHomePage({Key? key, required this.appName}) : super(key: key);
  final String appName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: NeumorphicAppBar(
          leading: const Icon(FontAwesomeIcons.whatsapp),
          title: Text(
            appName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: const MainForm(),
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
                const SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () {
                    Share.share(
                        'Hey! I\'m using WA Link Generator to generate whatsapp contact link and QR code. Download it now on Google Play Store: $kPlayStoreLink');
                  },
                  icon: const FaIcon(FontAwesomeIcons.share),
                  label: const Text('Share this app'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: const FaIcon(
                        FontAwesomeIcons.twitter,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _launchURL(context, 'https://twitter.com/iqfareez2');
                      },
                    ),
                    TextButton(
                      child: const FaIcon(
                        FontAwesomeIcons.instagram,
                        color: Colors.purple,
                      ),
                      onPressed: () {
                        _launchURL(
                            context, 'https://www.instagram.com/iqfareez/');
                      },
                    ),
                    TextButton(
                      child: const FaIcon(
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
          tooltip: 'Info',
          mini: true,
          child: const Center(child: FaIcon(FontAwesomeIcons.circleInfo)),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

_launchURL(BuildContext context, String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    CustomWidgets.buildErrorSnackbar(context, 'Error opening socmed');
    throw 'Could not launch $url';
  }
}
