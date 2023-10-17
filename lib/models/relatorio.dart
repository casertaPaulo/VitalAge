import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/services/auth_service.dart';

class Relatorio extends ChangeNotifier {
  int _idade = 0;
  double _peso = 0;
  double _altura = 0;
  String _sexo = "Masculino";

  // Getters & Setters
  int get idade => _idade;

  void setIdade(int idade) {
    _idade = idade;
  }

  double get peso => _peso;

  getPeso() {
    if (peso == 0) {
      return "N/D";
    } else {
      return "$peso kg";
    }
  }

  void setPeso(double peso) {
    _peso = peso;
  }

  String get sexo => _sexo;

  void setSexo(String sexo) {
    _sexo = sexo;
  }

  getSexo() {
    return _sexo;
  }

  double get altura => _altura;

  getAltura() {
    if (altura == 0) {
      return "N/D";
    } else {
      return "${altura}m";
    }
  }

  void setAltura(double altura) {
    _altura = altura;
  }

  // Calcula o IMC
  calculaIMC() {
    return _peso / (altura * altura);
  }

  // Retorna o resultado do cálculo do IMC
  mostraIMC() {
    double imc = calculaIMC();
    if (imc.isNaN) {
      return "Inf. Insuficientes";
    } else {
      return imc.toStringAsFixed(2);
    }
  }

  // Mostra um feedback com base no cálculo do IM
  feedbackIMC(double imc, int idade) {
    if (imc.isNaN) {
      return "Inf. Insuficientes";
    } else {
      if (idade <= 65) {
        // ADULTO
        if (imc < 18.5) {
          return "Baixo peso";
        } else if (imc >= 18.5 && imc < 24.9) {
          return "Peso normal";
        } else if (imc > 25.0 && imc < 29.9) {
          return "Excesso de peso";
        } else if (imc > 30 && imc < 34.9) {
          return "Obesidade de Classe 1";
        } else if (imc > 35 && imc < 39.9) {
          return "Obesidade de Classe 2";
        } else {
          return "Obesidade de Classe 3";
        }
      } else {
        if (imc < 22) {
          return "Baixo peso";
        } else if (imc > 22 && imc < 27) {
          return "Adequado ou eutrófico";
        } else {
          return "Sobrepeso";
        }
      }
    }
  }

  pesoIdeal(String feedback) {
    double imc = calculaIMC();
    if (imc.isNaN) {
      return "N/A";
    } else {
      if (feedback == "Peso normal") {
        return "SIM";
      } else {
        return "NÃO";
      }
    }
  }
}
