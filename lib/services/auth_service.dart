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
  bool isLoading = true;

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
      }
    }
  }

  // Método de login de usuário
  login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }

  String? nome; // Adicione uma variável para armazenar o nome

  Future<void> obterNome() async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('usuarios');
    final String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      final DocumentSnapshot document = await users.doc(uid).get();
      final data = document.data() as Map<String, dynamic>;
      nome = data['usuario']; // Atualize a variável 'nome'
      notifyListeners(); // Notifique os ouvintes para atualizar o widget
    } catch (e) {
      print('Erro ao obter o nome: $e');
    }
  }
}
