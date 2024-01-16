import 'package:flutter/material.dart';

class SeuWidget extends StatefulWidget {
  @override
  _SeuWidgetState createState() => _SeuWidgetState();
}

class _SeuWidgetState extends State<SeuWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverflowBox(
        minWidth: 0.0,
        minHeight: 0.0,
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 250,
          ),
          child: Container(
            color: Colors.red,
            child: Image.asset(
              'assets/images/inteligencia-artificial.png',
              width: 700,
            ),
          ),
        ),
      ),
    );
  }
}
