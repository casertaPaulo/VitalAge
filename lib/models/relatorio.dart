import 'package:flutter/material.dart';

class Relatorio extends ChangeNotifier {
  mostrarGlicose(int? glicose) {
    if (glicose == 0) {
      return "N/D";
    } else {
      return "$glicose";
    }
  }

  mostrarOxig(int? onix) {
    if (onix == 0) {
      return "N/D";
    } else {
      return "$onix";
    }
  }

  mostrarSiastolica(int? sistolica) {
    if (sistolica == 0) {
      return "N/D";
    } else {
      return "$sistolica";
    }
  }

  mostrarDiastolica(int? diastolica) {
    if (diastolica == 0) {
      return "N/D";
    } else {
      return "$diastolica";
    }
  }

  mostrarPeso(double peso) {
    if (peso == 0) {
      return "N/D";
    } else {
      return "${peso.truncate()}";
    }
  }

  mostrarAltura(double altura) {
    if (altura == 0) {
      return "N/D";
    } else {
      return "${altura.truncate() / 100}";
    }
  }

  // Calcula o IMC
  calculaIMC(double peso, double altura) {
    return peso / ((altura / 100) * (altura / 100));
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
          return "PESO NORMAL";
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

  //feedback peso
  feedbackPeso(double imc, int idade) {
    if (imc.isNaN) {
      return "Inf. Insuficientes";
    } else {
      if (idade <= 65) {
        // ADULTO
        if (imc < 18.5) {
          return "MAGREZA";
        } else if (imc >= 18.5 && imc < 24.9) {
          return "NORMAL";
        } else if (imc > 25.0 && imc < 29.9) {
          return "SOBREPESO";
        } else {
          return "OBESO";
        }
      } else {
        if (imc < 22) {
          return "BAIXO PESO";
        } else if (imc > 22 && imc < 27) {
          return "ADEQUADO OU EUTRÓFICO";
        } else {
          return "SOBREPESO";
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
