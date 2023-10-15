import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:vital_age/models/batimentos.dart';

class BatimentosRepository extends ChangeNotifier {
  final List<Batimentos> _batimentos = [
    /*
      Aqui dentro vai as instancia de batimentos
    */
  ];

  // Método getter para tornar visível e não modificável a outras classes o
  // array de batimentos
  UnmodifiableListView<Batimentos> get batimentos =>
      UnmodifiableListView(_batimentos);

  void addBatimento(Batimentos batimento) {
    _batimentos.add(batimento);
    notifyListeners();
  }

  void removeBatimento(Batimentos batimento) {
    _batimentos.remove(batimento);
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

  Color getCorComBaseNoBatimento(int batimentos, int idade, bool isMale) {
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
      if (isMale) {
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

  String getStringComBaseNoBatimento(int batimentos, int idade, bool isMale) {
    if (idade < 5) {
      if (batimentos <= 80) {
        return " Lento";
      } else if (batimentos <= 140) {
        return " Ideal";
      }
    } else if (idade >= 5 && idade <= 18) {
      if (batimentos <= 80) {
        return " Lento";
      } else if (batimentos <= 100) {
        return " Ideal";
      }
    } else if (idade > 18 && idade <= 65) {
      if (isMale) {
        if (batimentos < 73) {
          return " Lento";
        } else if (batimentos < 78) {
          return " Ideal";
        }
      } else {
        if (batimentos < 70) {
          return " Lento";
        } else if (batimentos <= 76) {
          return " Ideal";
        }
      }
    } else if (idade > 65) {
      if (batimentos < 50) {
        return " Lento";
      } else if (batimentos <= 60) {
        return " Ideal";
      }
    }

    return " Rápido";
  }
}
