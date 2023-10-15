// NECESSÁRIO REDIMENSIONAMENTO COM MEDIA QUERY

import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:vital_age/providers/batimentos_repository.dart';

// ignore: must_be_immutable
class ListaBatimentos extends StatelessWidget {
  late int batimentos;
  late int idade;
  late bool isMale;
  late DateTime dateTime;

  ListaBatimentos(
      {super.key,
      required this.dateTime,
      required this.batimentos,
      required this.idade,
      required this.isMale});

  @override
  Widget build(BuildContext context) {
    // Instância da classe Batimentos Repository
    BatimentosRepository bpm = BatimentosRepository();

    // Setando as cores com base nos batimentos
    // Métodos criados no repositório de batimentos
    Color cor = bpm.getCorComBaseNoBatimento(
      batimentos,
      idade,
      isMale,
    );
    String velocidadeBatimento = bpm.getStringComBaseNoBatimento(
      batimentos,
      idade,
      isMale,
    );

    // Estilização da widget listaBatimentos
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: const Color(0xFF1c1a4b),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5), // Cor da sombra
                      spreadRadius: 2, // Espalhamento da sombra
                      blurRadius: 5, // Desfoque da sombra
                      offset: const Offset(0, 5), // Deslocamento para cima
                    )
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(width: 10),
                  Image.asset(
                    'assets/images/frequencia-cardiaca.png',
                    height: 70,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$batimentos',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontFamily: "KanitBold"),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/coracao.png',
                    height: 30,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "${DateFormat('E').format(dateTime).capitalizeFirst}\n${dateTime.day}/${dateTime.month}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    velocidadeBatimento,
                    style: TextStyle(
                      fontFamily: "KanitBold",
                      color: cor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
