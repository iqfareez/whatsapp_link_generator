import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_link_generator/Reuseable_widget.dart';
import 'package:whatsapp_link_generator/custom_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

String urlWaEncoded;
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
        break;
      case 'as link text':
        //TODO: Add share
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
              child: Container(
                padding: const EdgeInsets.all(cardPadding),
                child: Center(
                  child: RepaintBoundary(
                    key: globalKey,
                    child: QrImage(
                      data: urlWaEncoded,
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
                //add share button?
              ],
            ),
            //add share button?
          )
        ],
        //add share button?
      ),
    );
  }

  void copyLink() {
    Clipboard.setData(ClipboardData(text: urlWaEncoded));
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Copied successfully'),
    ));
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
