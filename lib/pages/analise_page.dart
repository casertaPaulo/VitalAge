// ignore_for_file: avoid_print
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/animations/fade_animation.dart';
import 'package:vital_age/models/points.dart';
import 'package:vital_age/providers/registro_repository.dart';
import 'package:vital_age/services/firestore_service.dart';
import 'package:vital_age/util/media_query.dart';
import 'package:vital_age/widgets/line_chart.dart';

class AnalisePage extends StatefulWidget {
  const AnalisePage({super.key});

  @override
  State<AnalisePage> createState() => _AnalisePageState();
}

class _AnalisePageState extends State<AnalisePage> {
  bool selected = false;
  bool _isCurved = false;
  String selectedTip = '';
  List<int> dataSelected = [];
  List<int> batimentosData = [];
  List<int> oxigenacaoData = [];
  List<int> glicoseData = [];
  List<int> sistolicaData = [];
  List<int> diastolicaData = [];

  List<Points> get points {
    final data = dataSelected;
    return data.asMap().entries.map((entry) {
      final index = entry.key;
      final element = entry.value;
      return Points(x: index.toDouble(), y: element.toDouble());
    }).toList();
  }

  late String id;
  late DatabaseReference databaseReference;
  FirebaseService firebaseService = FirebaseService();

  iniciarLeitura(DatabaseReference databaseReference) {
    // ignore: unused_local_variable
    String key;

    databaseReference.once(DatabaseEventType.value).then((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> values =
            event.snapshot.value as Map<dynamic, dynamic>;
        List keys = values.keys.toList();

        // Ordenar as chaves por ordem cronológica
        keys.sort();

        for (var key in keys) {
          var value = values[key];
          int batimentos = int.parse(value['bpm'].toString());
          int oxigenacao = int.parse(value['oxigenacao'].toString());
          int glicose = int.parse(value['glicose'].toString());
          int sistolica = int.parse(value['sistolica'].toString());
          int diastolica = int.parse(value['diastolica'].toString());

          setState(() {
            batimentosData.add(batimentos);

            if (oxigenacao > 0) {
              oxigenacaoData.add(oxigenacao);
            }

            if (glicose > 0) {
              glicoseData.add(glicose);
            }

            if (sistolica > 0) {
              sistolicaData.add(sistolica);
            }

            if (diastolica > 0) {
              diastolicaData.add(diastolica);
            }
          });

          print("BPM: $batimentos");
        }
      } else {
        // Os dados não existem no caminho especificado
      }
    }).catchError((error) {
      // Lidar com erros, se houver algum
    });
  }

  @override
  void initState() {
    super.initState();
    // Definindo path e id
    id = firebaseService.getUserId();
    databaseReference = firebaseService.getHeartbeatsReference();
    Provider.of<BatimentosRepository>(context, listen: false).clear();
    // Adie a chamada para iniciarLeitura para o próximo quadro após a construção do widget
    iniciarLeitura(databaseReference);
  }

  @override
  void dispose() {
    databaseReference.onChildAdded.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInUp(
                  duration: 800,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'RobotoCondensed',
                                        color: Colors.black,
                                        fontSize: Util.getDeviceType(context) ==
                                                'phone'
                                            ? 35.0
                                            : 46.0,
                                      ),
                                      children: const [
                                        TextSpan(
                                            text: 'Analise os\n',
                                            style: TextStyle(fontSize: 20)),
                                        TextSpan(
                                          text: 'Gráficos',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '!',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 15,
                        bottom: 0,
                        child: FadeInUp(
                          duration: 1600,
                          child: Image.asset(
                            'assets/images/grafico.png',
                            height: 150,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // Form Adicionar gênero
                        width: MediaQuery.sizeOf(context).width / 2,
                        child: DropdownButtonFormField<String>(
                          dropdownColor: const Color(0xFF3c67b4),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1c1a4b),
                            label: const Text('Escolha'),
                            floatingLabelAlignment:
                                FloatingLabelAlignment.start,
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'RobotoCondensed',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            height: 1,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RobotoCondensed',
                          ),
                          menuMaxHeight: 300,
                          borderRadius: BorderRadius.circular(20),
                          onChanged: (newValue) {
                            setState(() {
                              selected = true;
                              selectedTip = newValue!;
                              if (selectedTip == "Batimentos") {
                                dataSelected = batimentosData;
                              } else if (selectedTip == "Glicose") {
                                dataSelected = glicoseData;
                              } else if (selectedTip == "Oxigenação") {
                                dataSelected = oxigenacaoData;
                              } else if (selectedTip == "Sistólica") {
                                dataSelected = sistolicaData;
                              } else {
                                dataSelected = diastolicaData;
                              }
                            });
                          },
                          items: [
                            'Batimentos',
                            'Glicose',
                            'Oxigenação',
                            'Sistólica',
                            'Diastólica'
                          ].map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            _isCurved = !_isCurved;
                          });
                        },
                        child: const Icon(Icons.show_chart),
                      )
                    ],
                  ),
                ),
                if (selected)
                  FadeInUp(
                    duration: 500,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: FadeInUp(
                                  duration: 1200,
                                  child: Text(
                                    selectedTip,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontFamily: 'RobotoCondensed',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.sizeOf(context).height / 2.5,
                              child: LineChartSample2(
                                  isCurved: _isCurved, points: points)),
                        ],
                      ),
                    ),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Center(
                          child: FadeInUp(
                              duration: 500,
                              child:
                                  Image.asset('assets/images/analisepage.png')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: FadeInUp(
                            duration: 1500,
                            child: const Text(
                              'Parece que você não selecionou uma categoria!',
                              style: TextStyle(
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
