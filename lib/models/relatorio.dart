import 'package:flutter/material.dart';

class Relatorio extends ChangeNotifier {
  getPeso(double peso) {
    if (peso == 0) {
      return "N/D";
    } else {
      return "$peso kg";
    }
  }

  getAltura(double altura) {
    if (altura == 0) {
      return "N/D";
    } else {
      return "${altura.truncate() / 100}m";
    }
  }

  // Calcula o IMC
  calculaIMC(double peso, double altura) {
    return peso / (altura / 100 * altura / 100);
  }

  // Retorna o resultado do cálculo do IMC
  mostraIMC(double imc) {
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

  pesoIdeal(String feedback, double peso, double altura) {
    double imc = calculaIMC(peso, altura);
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
