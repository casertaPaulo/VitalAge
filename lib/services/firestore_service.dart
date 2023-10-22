// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FirebaseService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getUserId() {
    final User? user = _auth.currentUser;
    if (user != null) {
      return user.uid;
    }
    throw Exception("Usuário não autenticado.");
  }

  DatabaseReference getHeartbeatsReference() {
    final String userId = getUserId();
    return FirebaseDatabase.instance.ref().child('users/$userId/heartbeats');
  }

  // Função para salvar peso no banco
  Future<void> salvarPeso(String userId, double peso) async {
    try {
      // Acesse a instância do Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Crie uma referência ao documento do usuário
      DocumentReference userRef = firestore.collection('usuarios').doc(userId);

      // Atualize o campo 'peso' do documento do usuário
      await userRef.update({'peso': '$peso'});

      print('Dados atualizados com sucesso!');
    } catch (e) {
      print('Erro ao salvar os dados: $e');
    }
    notifyListeners();
  }

  // Função para salvar altura no banco
  Future<void> salvarAltura(String userId, double altura) async {
    try {
      // Acesse a instância do Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Crie uma referência ao documento do usuário
      DocumentReference userRef = firestore.collection('usuarios').doc(userId);

      // Atualize o campo 'altura' do documento do usuário
      await userRef.update({'altura': '$altura'});

      print('Dados atualizados com sucesso!');
    } catch (e) {
      print('Erro ao salvar os dados: $e');
    }
    notifyListeners();
  }

  Future<void> salvarIdade(String userId, int idade) async {
    try {
      // Acesse a instância do Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Crie uma referência ao documento do usuário
      DocumentReference userRef = firestore.collection('usuarios').doc(userId);

      // Atualize o campo 'idade' do documento do usuário
      await userRef.update({'idade': '$idade'});

      print('Dados atualizados com sucesso!');
    } catch (e) {
      print('Erro ao salvar os dados: $e');
    }
    notifyListeners();
  }

  Future<void> salvarSexo(String userId, String sexo) async {
    try {
      // Acesse a instância do Firestore
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Crie uma referência ao documento do usuário
      DocumentReference userRef = firestore.collection('usuarios').doc(userId);

      // Atualize o campo 'sexo' do documento do usuário
      await userRef.update({'sexo': sexo});

      print('Dados atualizados com sucesso!');
    } catch (e) {
      print('Erro ao salvar os dados: $e');
    }
    notifyListeners();
  }
}
