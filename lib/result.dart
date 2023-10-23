import 'dart:io';
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CONSTANTS.dart';
import 'shared/util/my_snackbar.dart';
import 'shared/widgets/neu_button.dart';

NeumorphicStyle neuCardStyle = NeumorphicStyle(
  depth: 8,
  shape: NeumorphicShape.flat,
  boxShape: NeumorphicBoxShape.roundRect(
    BorderRadius.circular(16),
  ),
);
const cardMargin = 16.0;
const cardPadding = 16.0;

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.phoneNumber, required this.message})
      : super(key: key);
  final String phoneNumber;
  final String message;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  GlobalKey globalKey = GlobalKey();
  late final String urlWaEncoded;
  bool isSelectedPhone = true;
  bool isSelectedMessage = true;

  @override
  void initState() {
    super.initState();
    urlWaEncoded = widget.message.isNotEmpty
        ? 'wa.me/${widget.phoneNumber}?text=${Uri.encodeComponent(widget.message)}'
        : 'wa.me/${widget.phoneNumber}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: const Text(
          'Generated',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleClick,
            tooltip: 'Share as image or Text',
            icon: const FaIcon(FontAwesomeIcons.shareNodes),
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
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Neumorphic(
                margin: const EdgeInsets.all(cardMargin),
                style: neuCardStyle,
                child: RepaintBoundary(
                  key: globalKey,
                  child: NeumorphicBackground(
                    child: Container(
                      padding: const EdgeInsets.all(cardPadding),
                      child: Center(
                        child: QrImageView(
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
                margin: const EdgeInsets.all(cardMargin),
                padding: const EdgeInsets.all(cardPadding),
                style: neuCardStyle,
                child: Center(
                  child: AutoSizeText(
                    urlWaEncoded,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                    maxLines: 8,
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
            ),
          ],
        ),
      ),
    );
  }

  handleClick(String value) {
    switch (value) {
      case 'as QR image':
        captureAndShareImage();
        break;
      case 'as link text':
        Share.share('https://$urlWaEncoded');
        break;
    }
  }

  void copyLink() {
    Clipboard.setData(ClipboardData(text: urlWaEncoded));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      content: Row(
        children: [
          Icon(FontAwesomeIcons.clipboardCheck, color: Colors.grey),
          SizedBox(width: 10),
          Text('Copied successfully'),
        ],
      ),
    ));
  }

  Future<void> captureAndShareImage() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    // In debug mode Android sometimes will return !debugNeedsPrint error
    if (kDebugMode || boundary.debugNeedsPaint) {
      debugPrint("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
    }
    ui.Image image = await boundary.toImage(pixelRatio: 2.5);

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    var saveImagePath = tempDir.path;
    final file = await File('$saveImagePath/image.png').create();
    await file.writeAsBytes(pngBytes);

    Share.shareXFiles([XFile(file.path)], text: 'Get the app: $kPlayStoreLink');
  }
}

_launchURL(BuildContext context, String url) async {
  final uri = Uri.parse('https://$url');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    showErrorSnackbar(context, 'Failed to open WhatsApp');
    throw 'Could not launch $uri';
  }
}
