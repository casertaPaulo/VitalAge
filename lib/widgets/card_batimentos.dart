// NECESSÁRIO REDIMENSIONAMENTO COM MEDIA QUERY
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/providers/batimentos_repository.dart';
import 'package:vital_age/services/auth_service.dart';
import 'package:vital_age/util/media_query.dart';

class ListaBatimentos extends StatelessWidget {
  final int batimentos;
  final DateTime dateTime;

  const ListaBatimentos({
    super.key,
    required this.batimentos,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    // Instância da classe Batimentos Repository
    BatimentosRepository bpm = BatimentosRepository();

    // Setando as cores com base nos batimentos
    // Métodos criados no repositório de batimentos
    Color cor = bpm.getCorComBaseNoBatimento(
      batimentos,
      authService.idade,
      authService.sexo,
    );
    String velocidadeBatimento = bpm.getStringComBaseNoBatimento(
      batimentos,
      authService.idade,
      authService.sexo,
    );

    // Estilização da widget listaBatimentos
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 110,
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
                  height: Util.getDeviceType(context) == 'phone' ? 70.0 : 140.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$batimentos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Util.getDeviceType(context) == 'phone'
                            ? 50.0
                            : 110.0,
                        fontFamily: "KanitBold",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/coracao.png',
                  height: Util.getDeviceType(context) == 'phone' ? 30.0 : 70.0,
                ),
                const SizedBox(width: 20),
                Text(
                  "${DateFormat('E').format(dateTime).capitalizeFirst}\n${dateTime.day}/${dateTime.month}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        Util.getDeviceType(context) == 'phone' ? 20.0 : 35.0,
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
              width: Util.getDeviceType(context) == 'phone' ? 120.0 : 140.0,
              height: Util.getDeviceType(context) == 'phone' ? 30.0 : 40.0,
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
                    fontSize:
                        Util.getDeviceType(context) == 'phone' ? 20.0 : 30.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
