import 'package:flutter/material.dart';

class AnalisePage extends StatefulWidget {
  const AnalisePage({super.key});

  @override
  State<AnalisePage> createState() => _AnalisePageState();
}

class _AnalisePageState extends State<AnalisePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Analíse'),
      ),
    );
  }
}
