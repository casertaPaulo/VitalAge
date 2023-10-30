import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/models/registro_model.dart';
import 'package:vital_age/providers/registro_repository.dart';
import 'package:vital_age/services/auth_service.dart';

class SeuWidget extends StatefulWidget {
  @override
  _SeuWidgetState createState() => _SeuWidgetState();
}

class _SeuWidgetState extends State<SeuWidget> {
  BatimentosRepository batimentosRepository = BatimentosRepository();
  late String id;
  int data = 0;
  String key = "";

  showData(int data) {
    this.data = data;
  }

  @override
  void initState() {
    super.initState();
    id = context.read<AuthService>().usuario!.uid;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste'),
      ),
      body: Center(
        child: Text(
          'DATA: $data',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  }
}
