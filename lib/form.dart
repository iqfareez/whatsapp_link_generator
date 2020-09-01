import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:whatsapp_link_generator/result.dart';

class MainForm extends StatefulWidget {
  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController messageContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 5.0),
      child: KeyboardAvoider(
        autoScroll: true,
        child: Column(
          children: [
            inputPhoneForm(),
            SizedBox(
              height: 10.0,
            ),
            inputMessageForm(),
            Row(
              children: [
                Expanded(child: generateButton()),
                Expanded(child: clearAllButton()),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget inputPhoneForm() {
    return Neumorphic(
      margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 2.0),
      style: NeumorphicStyle(
        lightSource: LightSource.right,
        shape: NeumorphicShape.convex,
        depth: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[300],
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Phone number',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              subtitle: Text(
                'Include your country code\n(Optional when message is included)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Neumorphic(
                style: NeumorphicStyle(
                    depth: -24.0,
                    intensity: 18.0,
                    color: Colors.transparent,
                    shape: NeumorphicShape.convex,
                    lightSource: LightSource.top),
                child: TextField(
                  controller: phoneNumController,
                  maxLength: 15,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    counter: Offstage(),
                    border: InputBorder.none,
                    // prefixIcon: Icon(Icons.contact_phone),
                    // suffixIcon: Icon(null),
                    prefixIcon: Icon(null),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        phoneNumController.clear();
                      },
                    ),
                    hintText: 'Eg: 601956291',
                  ),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  onSubmitted: (value) => context.nextEditableTextFocus(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputMessageForm() {
    return Neumorphic(
      margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 2.0),
      style: NeumorphicStyle(
        lightSource: LightSource.left,
        shape: NeumorphicShape.convex,
        depth: 8,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey[300],
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Message',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              subtitle: Text(
                '(optional)',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Neumorphic(
                style: NeumorphicStyle(
                    depth: -24.0,
                    intensity: 18.0,
                    color: Colors.transparent,
                    shape: NeumorphicShape.convex,
                    lightSource: LightSource.top),
                child: TextField(
                  controller: messageContentController,
                  maxLines: 4,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    // prefixIcon: Icon(Icons.contact_phone),
                    // suffixIcon: Icon(null),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        messageContentController.clear();
                      },
                    ),
                    hintText: 'Eg: Hi. How are you?',
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) => FocusScope.of(context).unfocus(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget generateButton() {
    return Neumorphic(
      margin: EdgeInsets.all(16.0),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        depth: 8,
      ),
      child: FlatButton(
        child: Text('Generate Link'),
        onPressed: () {
          print('generate called');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(
                  phoneNumber: phoneNumController.text,
                  message: messageContentController.text,
                ),
              ));
        },
      ),
    );
  }

  Widget clearAllButton() {
    return Neumorphic(
      margin: EdgeInsets.all(16.0),
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        depth: 8,
      ),
      child: FlatButton(
        child: Text('Clear All'),
        onPressed: () {
          print('Called clear');
        },
      ),
    );
  }
}

extension Utility on BuildContext {
  void nextEditableTextFocus() {
    do {
      FocusScope.of(this).nextFocus();
    } while (FocusScope.of(this).focusedChild.context.widget is! EditableText);
  }
  //solution by https://stackoverflow.com/a/63005046/13617136
}
//Neumorhic docs - https://pub.dev/packages/flutter_neumorphic
