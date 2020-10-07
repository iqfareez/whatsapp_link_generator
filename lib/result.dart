import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_link_generator/CONSTANTS.dart';
import 'package:whatsapp_link_generator/Reuseable_widget.dart';
import 'package:whatsapp_link_generator/custom_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

String urlWaEncoded;
String temporaryDirectory;
NeumorphicStyle neuCardStyle = NeumorphicStyle(
  depth: 8,
  shape: NeumorphicShape.flat,
  boxShape: NeumorphicBoxShape.roundRect(
    BorderRadius.circular(16),
  ),
);
const cardMargin = 16.0;
const cardPadding = 16.0;

class ResultPage extends StatelessWidget {
  ResultPage({this.phoneNumber, this.message});
  final String phoneNumber;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text(
          'Generated',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            tooltip: 'Share as image or Text',
            icon: FaIcon(FontAwesomeIcons.shareAlt),
            itemBuilder: (BuildContext context) {
              return {'as QR image', 'as link text'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ResultBody(phoneNumber, message),
    );
  }

  handleClick(String value) {
    switch (value) {
      case 'as QR image':
        print(value);
        Share.shareFiles(['$temporaryDirectory/image.png'],
            text: 'Get the app: $kPlayStoreLink');
        //https://medium.com/@ekosuprastyo15/qr-code-generator-and-scanner-flutter-bd69eaa504a6
        break;
      case 'as link text':
        Share.share(urlWaEncoded);
        break;
    }
  }
}

class ResultBody extends StatefulWidget {
  ResultBody(this.phoneNum, this.message);
  final String phoneNum;
  final String message;
  @override
  _ResultBodyState createState() => _ResultBodyState();
}

class _ResultBodyState extends State<ResultBody> {
  GlobalKey globalKey = GlobalKey();
  bool isSelectedPhone = true;
  bool isSelectedMessage = true;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print('timeStamp $timeStamp');
      captureAndShareImage();
    });
    urlWaEncoded = widget.message.isNotEmpty
        ? 'wa.me/${widget.phoneNum}?text=${Uri.encodeComponent(widget.message)}'
        : 'wa.me/${widget.phoneNum}';

    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Neumorphic(
              margin: EdgeInsets.all(cardMargin),
              style: neuCardStyle,
              child: RepaintBoundary(
                key: globalKey,
                child: NeumorphicBackground(
                  child: Container(
                    padding: const EdgeInsets.all(cardPadding),
                    child: Center(
                      child: QrImage(
                        data: urlWaEncoded,
                        foregroundColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Neumorphic(
              margin: EdgeInsets.all(cardMargin),
              padding: EdgeInsets.all(cardPadding),
              style: neuCardStyle,
              child: Container(
                child: Center(
                  child: AutoSizeText(
                    urlWaEncoded,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                    maxLines: 8,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NeuButton(
                      label: 'Open WhatsApp',
                      onPressedButton: () {
                        _launchURL(context, urlWaEncoded);
                      },
                    ),
                    NeuButton(
                      label: 'Copy link',
                      onPressedButton: () {
                        copyLink();
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void copyLink() {
    Clipboard.setData(ClipboardData(text: urlWaEncoded));
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Copied successfully'),
    ));
  }

  Future<void> captureAndShareImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext.findRenderObject();
      if (boundary.debugNeedsPaint) {
        print("Waiting for boundary to be painted.");
        await Future.delayed(const Duration(milliseconds: 20));
        return captureAndShareImage();
        //https://stackoverflow.com/questions/57645037/unable-to-take-screenshot-in-flutter
      }
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      temporaryDirectory = tempDir.path;
      print('fareez here $temporaryDirectory');
      final file = await new File('$temporaryDirectory/image.png').create();
      await file.writeAsBytes(pngBytes);
    } catch (e) {
      print('Error in capturePng: $e');
    }
  }
}

_launchURL(BuildContext context, String url) async {
  final uri = 'https://$url';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    CustomWidgets.buildErrorSnackbar(context, 'Error opening WhatsApp');
    throw 'Could not launch $uri';
  }
}
