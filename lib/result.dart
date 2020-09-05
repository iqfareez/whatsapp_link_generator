import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_link_generator/Reuseable_widget.dart';
import 'package:whatsapp_link_generator/custom_widget.dart';

class ResultPage extends StatelessWidget {
  ResultPage({this.phoneNumber, this.message});
  final String phoneNumber;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated link'),
      ),
      body: ResultBody(phoneNumber, message),
    );
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
  bool isSelectedPhone = true;
  bool isSelectedMessage = true;

  @override
  Widget build(BuildContext context) {
    String urlWaEncoded =
        'https://wa.me/${widget.phoneNum}?text=${Uri.encodeComponent(widget.message)}';
    final chips = [
      FilterChip(
        label: Text('Phone number'),
        // avatar: FaIcon(FontAwesomeIcons.phone),
        selected: isSelectedPhone,
        onSelected: (bool value) {
          setState(() {
            isSelectedPhone = !isSelectedPhone;
          });
        },
      ),
      FilterChip(
        label: Text('Message'),
        // avatar: FaIcon(FontAwesomeIcons.envelopeOpenText),
        selected: isSelectedMessage,
        onSelected: (bool value) {
          setState(() {
            isSelectedMessage = !isSelectedMessage;
          });
        },
      )
    ];
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Expanded(
          //   flex: 1,
          //   child: Wrap(
          //     children: [
          //       for (final chip in chips)
          //         Padding(
          //           padding: EdgeInsets.all(4),
          //           child: chip,
          //         )
          //     ],
          //   ),
          // ),
          Expanded(
            flex: 4,
            child: FittedBox(fit: BoxFit.contain, child: Text(urlWaEncoded)),
          ),
          Expanded(
            flex: 2,
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
                        Clipboard.setData(ClipboardData(text: urlWaEncoded));
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text('Copied successfully'),
                        ));
                      },
                    ),
                  ],
                ),
                //add share button?
                NeumorButton()
              ],
            ),
            //add share button?
          )
        ],
        //add share button?
      ),
    );
  }
}

_launchURL(BuildContext context, String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    CustomWidgets.buildErrorSnackbar(context, 'Error opening WhatsApp');
    throw 'Could not launch $url';
  }
}
