import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  final String title;
  TermsAndConditionsScreen({Key? key, required this.title}) : super(key: key);

  @override
  _TermsAndConditionsScreenState createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(widget.title),
      ),
    );
  }
}
