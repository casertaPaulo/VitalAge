import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/models/card_batimentos.dart';
import 'package:vital_age/providers/batimentos_repository.dart';
import 'package:vital_age/services/auth_service.dart';

class SeuWidget extends StatefulWidget {
  @override
  _SeuWidgetState createState() => _SeuWidgetState();
}

class _SeuWidgetState extends State<SeuWidget> {
  BatimentosRepository batimentosRepository = BatimentosRepository();
  final DatabaseReference databaseReference = FirebaseDatabase.instance
      .ref()
      .child('users/UIKjjOLpgcR0wDvrs4znuo28FQ32/heartbeats');

  void criarInformacoesNoBanco(int bpmValue) {
    final newBPMKey = databaseReference.push().key; // Gera uma chave única
    final newBPMData = {
      'bpm': bpmValue,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    if (newBPMKey != null) {
      // Define as informações no banco
      databaseReference.child(newBPMKey).set(newBPMData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enviar BPM para o Banco de Dados'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Registrar BPM no Banco de Dados'),
        ),
      ),
    );
  }
}
