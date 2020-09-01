import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
          'Phone Number is ${widget.phoneNum} and message is ${widget.message}'),
    );
  }
}
