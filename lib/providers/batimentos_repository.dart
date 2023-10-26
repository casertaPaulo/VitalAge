// ignore_for_file: avoid_print

import 'dart:collection';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:vital_age/models/batimento.dart';

class BatimentosRepository extends ChangeNotifier {
  // Constructor para inicializar 'id' e 'databaseReference'

  final List<Batimento> _batimentos = [];
  final List<Batimento> _batimentoFavorito = [];

  // Método getter para tornar visível e não modificável a outras classes o
  // array de batimentos
  UnmodifiableListView<Batimento> get batimentos =>
      UnmodifiableListView(_batimentos);
  UnmodifiableListView<Batimento> get batimentosFavoritos =>
      UnmodifiableListView(_batimentoFavorito);

  void iniciarRepositorio(DatabaseReference databaseReference) {
    int data;
    String key;

    // Caso adicione um batimento
    databaseReference.onChildAdded.listen((DatabaseEvent event) {
      key = event.snapshot.key.toString();
      data = int.parse(event.snapshot.child('bpm').value.toString());

      // Verifica se o batimento já está na lista com base no uniqueKey
      bool batimentoJaExiste =
          _batimentos.any((batimento) => batimento.uniqueKey == key);

      if (!batimentoJaExiste) {
        _batimentos.add(
          Batimento(
            batimentos: data,
            dateTime: DateTime.now(),
            uniqueKey: key,
          ),
        );
        notifyListeners();
      }

      print("Chave: $key, BPM: $data");
    });

    // Caso remova um batimento
    databaseReference.onChildRemoved.listen((DatabaseEvent event) {
      key = event.snapshot.key.toString();
      int index =
          _batimentos.indexWhere((batimento) => batimento.uniqueKey == key);
      if (index != -1) {
        _batimentos.removeAt(index);
        print("Chave removida: $key");
        notifyListeners();
      } else {
        print("Erro");
      }
    });
  }

  // Cria um registro de Batimento no banco de dados (Realtime Database)
  void criarInformacoesNoBanco(
      DatabaseReference databaseReference, int bpmValue) {
    final newBPMKey = databaseReference.push().key; // Gera uma chave única
    print(newBPMKey);
    final newBPMData = {
      'bpm': bpmValue,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    if (newBPMKey != null) {
      // Define as informações no banco
      databaseReference.child(newBPMKey).set(newBPMData);
    }
  }

  // Apaga um registro no banco de dados (Realtime Database)
  void apagaInformacaoNoBanco(
      DatabaseReference databaseReference, String uniqueKey) {
    // Remove o registro
    databaseReference.child(uniqueKey).remove().then((_) {
      print('Registro removido com sucesso.');
    }).catchError((error) {
      print('Erro ao remover o registro: $error');
    });
  }

  void clear() {
    _batimentos.clear();
  }

  void removeBatimento(String key) {
    int index =
        _batimentos.indexWhere((batimento) => batimento.uniqueKey == key);
    if (index != -1) {
      _batimentos.removeAt(index);
      print("Chave removida: $key");
      notifyListeners();
    } else {
      print("Erro");
    }
  }

  void addFavorito(Batimento batimento) {
    _batimentoFavorito.add(batimento);
    notifyListeners();
  }

  /*
    Condicionais com base nos valores ideais em cada situação
    Valores pegos no site: https://www.hospitalimigrantes.com.br/post/qual-a-frequencia-cardiaca-normal-por-idade-e-como-avaliar/24/#:~:text=Confira%20a%20frequ%C3%AAncia%20card%C3%ADaca%20ideal%20por%20idade%3A&text=De%208%20at%C3%A9%2017%20anos,anos%2050%20a%206%20bpm
  */

  // Caso 1: Crianças de até 2 anos: 120 a 140 bpm
  // Caso 2: De 8 até 17 anos: 80 a 100 bpm
  // Caso 3: Mulheres de 18 a 65 anos: 73 a 78 bpm
  // Caso 4: Homens de 18 a 65 anos: 70 a 76 bpm
  // Caso 5: Idosos: mais de 65 anos 50 a 6 bpm

  Color getCorComBaseNoBatimento(int batimentos, int idade, String sexo) {
    if (idade < 5) {
      if (batimentos <= 80) {
        return Colors.red;
      } else if (batimentos <= 140) {
        return Colors.green;
      }
    } else if (idade >= 5 && idade <= 18) {
      if (batimentos <= 80) {
        return Colors.red;
      } else if (batimentos <= 100) {
        return Colors.green;
      }
    } else if (idade > 18 && idade <= 65) {
      if (sexo == "Masculino") {
        if (batimentos < 73) {
          return Colors.red;
        } else if (batimentos < 78) {
          return Colors.green;
        }
      } else {
        if (batimentos < 70) {
          return Colors.red;
        } else if (batimentos <= 76) {
          return Colors.green;
        }
      }
    } else if (idade > 65) {
      if (batimentos < 50) {
        return Colors.red;
      } else if (batimentos <= 60) {
        return Colors.green;
      }
    }

    return Colors.orange.shade700;
  }

  String getStringComBaseNoBatimento(int batimentos, int idade, String sexo) {
    if (idade < 5) {
      if (batimentos <= 80) {
        return "Lento";
      } else if (batimentos <= 140) {
        return "Ideal";
      }
    } else if (idade >= 5 && idade <= 18) {
      if (batimentos <= 80) {
        return "Lento";
      } else if (batimentos <= 100) {
        return "Ideal";
      }
    } else if (idade > 18 && idade <= 65) {
      if (sexo == "Masculino") {
        if (batimentos < 73) {
          return "Lento";
        } else if (batimentos < 78) {
          return "Ideal";
        }
      } else {
        if (batimentos < 70) {
          return "Lento";
        } else if (batimentos <= 76) {
          return "Ideal";
        }
      }
    } else if (idade > 65) {
      if (batimentos < 50) {
        return "Lento";
      } else if (batimentos <= 60) {
        return "Ideal";
      }
    }

    return "Rápido";
  }

  retornaIdade(int idade) {
    if (idade > 1 && idade < 12) {
      return "CRIANÇA";
    } else if (idade > 12 && idade < 21) {
      return "JOVEM";
    } else if (idade > 21 && idade < 65) {
      return "ADULTO";
    } else {
      return "IDOSO";
    }
  }
}
