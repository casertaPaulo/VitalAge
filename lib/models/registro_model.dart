/// Essa Classe simboliza um modelo para cada registro

class Registro {
  late int batimentos;
  late DateTime dateTime;
  late String uniqueKey;
  late int? oxigenacao;
  late int? glicose;
  late int? sistolica;
  late int? diastolica;
  late double? temp;

  Registro({
    this.temp,
    this.glicose,
    this.sistolica,
    this.diastolica,
    this.oxigenacao,
    required this.batimentos,
    required this.dateTime,
    required this.uniqueKey,
  });
}
