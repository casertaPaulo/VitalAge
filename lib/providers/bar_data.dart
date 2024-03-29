import 'dart:collection';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vital_age/models/registro_model.dart';
import 'package:vital_age/providers/registro_repository.dart';
import 'package:vital_age/services/auth_service.dart';

class BarData extends ChangeNotifier {
  // Instância privada de batimentos repository
  final BatimentosRepository _batimentosRepository;
  final AuthService authService;

  // Array de barras do graph
  List<BarChartGroupData> _barData = [];

  // Método getter que retorna apenas a visualização do array, para que não seja
  // diretamente modificada
  UnmodifiableListView<BarChartGroupData> get barData =>
      UnmodifiableListView(_barData);

  // Construtor da classe BarData que recebe BatimentosRepository como parâmetro
  BarData(this._batimentosRepository, this.authService) {
    _batimentosRepository.addListener(_onBatimentosRepositoryChanged);
    _initializeData();
  }

  // Método que é chamado sempre que há alguma mudança em BatimentosRepository
  void _onBatimentosRepositoryChanged() {
    _initializeData();
  }

  void clearData() {
    _barData.clear();
    notifyListeners();
  }

  // Método que mapeia a lista de batimentos e adiciona para um objeto BarData
  void _initializeData() {
    _barData = _batimentosRepository.batimentos.asMap().entries.map((entry) {
      Registro batimento = entry.value;
      int diaMes = (batimento.dateTime.day * 100) + batimento.dateTime.month;

      return BarChartGroupData(
        x: diaMes,
        barRods: [
          BarChartRodData(
              toY: batimento.batimentos.toDouble(),
              borderRadius: BorderRadius.circular(5),
              width: 25,
              backDrawRodData: BackgroundBarChartRodData(
                color: Colors.red,
                show: true,
              ),
              color: _batimentosRepository.getCorComBaseNoBatimento(
                  batimento.batimentos, authService.idade, authService.sexo)),
        ],
      );
    }).toList();
    // Notifica os ouvintes (widgets dependentes do Provider)
    notifyListeners();
  }

  // Remove o ouvinte para otimização de memória
  @override
  void dispose() {
    _batimentosRepository.removeListener(_onBatimentosRepositoryChanged);
    super.dispose();
  }
}
