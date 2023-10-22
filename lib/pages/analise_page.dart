import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/providers/batimentos_repository.dart';

class AnalisePage extends StatefulWidget {
  const AnalisePage({super.key});

  @override
  State<AnalisePage> createState() => _AnalisePageState();
}

class _AnalisePageState extends State<AnalisePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<BatimentosRepository>(context, listen: false).clear();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        'EM\nDESENVOLVIMENTO',
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900),
      ),
    ));
  }
}
