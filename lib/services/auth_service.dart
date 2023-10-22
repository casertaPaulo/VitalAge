import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? usuario;
  bool isLoading = false;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    notifyListeners();
  }

  // Método de registro de usuários
  registrar(String email, String senha, String nome) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
      if (usuario != null) {
        final userUid = usuario!.uid;
        final userRef =
            FirebaseFirestore.instance.collection('usuarios').doc(userUid);

        // Define o campo 'nome' no documento do usuário no Firestore
        await userRef.set({'usuario': nome}, SetOptions(merge: true));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      } else {
        throw AuthException('Ocorreu um erro inesperado');
      }
    }
  }

  // Método de login de usuário
  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
      obterDados();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      } else {
        throw AuthException('Verifique os dados!');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }

  String? nome;
  String sexo = "Masculino";
  double peso = 0;
  double altura = 0;
  int idade = 0;

  Future<void> obterDados() async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('usuarios');
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      final DocumentSnapshot document = await users.doc(uid).get();
      final data = document.data() as Map<String, dynamic>;
      nome = data['usuario'];
      notifyListeners();
      peso = double.parse(data['peso'].toString());
      notifyListeners();
      altura = double.parse(data['altura'].toString());
      notifyListeners();
      idade = int.parse(data['idade'].toString());
      notifyListeners();
      sexo = data['sexo'];
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print('Erro ao obter a altura: $e');
    }
  }
}
