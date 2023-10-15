import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/animations/fade_animation.dart';
import 'package:vital_age/models/relatorio.dart';
import 'package:vital_age/providers/batimentos_repository.dart';
import 'package:vital_age/services/auth_service.dart';
import 'package:vital_age/util/snack_bar.dart';

import '../models/batimentos.dart';

class AddBatimentosPage extends StatefulWidget {
  const AddBatimentosPage({
    super.key,
  });

  @override
  State<AddBatimentosPage> createState() => _AddBatimentosPageState();
}

class _AddBatimentosPageState extends State<AddBatimentosPage>
    with SingleTickerProviderStateMixin {
  final _batimentos = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isMale = true;
  String defaultAge = "";
  String selectedAge = "";

  String selectedGender = "Masculino";
  bool _isPress = false;

  final List<String> ageOptions =
      List.generate(101, (index) => index.toString());

  @override
  void initState() {
    super.initState();
    context.read<AuthService>().obterNome();
  }

  // Método para mostrar feedback e voltar para a tela principal
  voltar() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    defaultAge = "${Provider.of<Relatorio>(context).idade}";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Cabeçalho da página
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Adicione\n',
                                      ),
                                      TextSpan(
                                        text: 'Batimentos',
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
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPress = !_isPress;
                                });
                              },
                              child: Image.asset(
                                'assets/images/ponto-de-interrogacao.png',
                                height: 50,
                              )
                                  .animate(
                                    onPlay: (controller) => controller.repeat(),
                                  )
                                  .shimmer(delay: 400.ms, duration: 1800.ms)
                                  .shake(hz: 4, curve: Curves.easeInOutCubic)
                                  .scaleXY(end: 1.3, duration: 600.ms)
                                  .then(delay: 600.ms)
                                  .scaleXY(end: 1 / 1.3),
                            )
                          ],
                        ),

                        // Corpo do página
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: TextFormField(
                                    // Form Adicionar Batimentos
                                    onTapOutside: (event) =>
                                        FocusScope.of(context).unfocus(),
                                    controller: _batimentos,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none),
                                      label: const Text("  BPM"),
                                      floatingLabelAlignment:
                                          FloatingLabelAlignment.center,
                                      labelStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.monitor_heart_outlined,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      filled: true,
                                      fillColor: const Color(0xFF1c1a4b),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'INFORME OS BATIMENTOS';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 30),
                                      child: SizedBox(
                                        // Form Adicionar gênero
                                        width: 200,
                                        child: DropdownButtonFormField<String>(
                                          dropdownColor:
                                              const Color(0xFF3c67b4),
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide.none,
                                            ),
                                            filled: true,
                                            fillColor: const Color(0xFF1c1a4b),
                                            label: const Text('Sexo'),
                                            floatingLabelAlignment:
                                                FloatingLabelAlignment.start,
                                            labelStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            height: 1.2,
                                            fontFamily: 'KanitBold',
                                          ),
                                          menuMaxHeight: 300,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          value: selectedGender,
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedGender = newValue!;
                                            });
                                          },
                                          items: ['Masculino', 'Feminino']
                                              .map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // Form Adicionar idade
                                      width: 100,
                                      child: DropdownButtonFormField<String>(
                                        alignment: Alignment.center,
                                        dropdownColor: const Color(0xFF3c67b4),
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide.none,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xFF1c1a4b),
                                          label: const Text('Idade'),
                                          floatingLabelAlignment:
                                              FloatingLabelAlignment.start,
                                          labelStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            height: 1.2,
                                            fontFamily: 'KanitBold'),
                                        menuMaxHeight: 300,
                                        borderRadius: BorderRadius.circular(20),
                                        value: defaultAge,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedAge = newValue!;
                                          });
                                        },
                                        items: ageOptions
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                MaterialButton(
                                  // Botão adicionar
                                  onPressed: () {
                                    setState(() {
                                      if (_formKey.currentState!.validate()) {
                                        int batimentosValue =
                                            int.parse(_batimentos.text);
                                        int idadeValue;
                                        if (selectedAge.isEmpty) {
                                          idadeValue = int.parse(defaultAge);
                                        } else {
                                          idadeValue = int.parse(selectedAge);
                                        }
                                        if (selectedGender == "Masculino") {
                                          isMale = true;
                                        } else {
                                          isMale = false;
                                        }
                                        Provider.of<BatimentosRepository>(
                                                context,
                                                listen: false)
                                            .addBatimento(Batimentos(
                                                dateTime: DateTime.now(),
                                                batimentos: batimentosValue,
                                                idade: idadeValue,
                                                isMale: isMale));

                                        voltar();
                                        SnackBarUtil.mostrarSnackBar(
                                            context,
                                            "Registro criado com sucesso!",
                                            Colors.green,
                                            const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                            ));
                                      } else {
                                        SnackBarUtil.mostrarSnackBar(
                                            context,
                                            "Erro ao criar registro!",
                                            Colors.red,
                                            const Icon(
                                              Icons.error,
                                              color: Colors.white,
                                            ));
                                      }
                                    });
                                  },
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 50),
                                  color: const Color(0xFF3c67b4),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                      Text(
                                        'ADICIONAR',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'KanitBold',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tela do ícone "interrogação"
                  _isPress
                      ? FadeInUp(
                          duration: 500,
                          child: DraggableScrollableSheet(
                            initialChildSize: 0.95,
                            minChildSize: 0.05,
                            maxChildSize: 0.95,
                            builder: (context, scrollController) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                ),
                                child: Stack(
                                  children: [
                                    SingleChildScrollView(
                                      controller: scrollController,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Image.asset(
                                                    'assets/images/Screenshot 2023-09-09 173707.png')
                                                .animate(
                                                  onPlay: (controller) =>
                                                      controller.repeat(),
                                                )
                                                .shimmer(
                                                  delay: 400.ms,
                                                  duration: 1800.ms,
                                                )
                                                .then(delay: 600.ms),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30),
                                              child: Container(
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 30, vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: const TextSpan(
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 30,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: 'Batimentos em\n',
                                                      ),
                                                      TextSpan(
                                                        text: 'Repouso',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: '!',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                Text(
                                                  // Aqui vai o nome vindo do banco
                                                  'Caro ${context.read<AuthService>().nome},',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                const Text(
                                                  'Para garantir que possamos fornecer a você a melhor experiência e informações precisas sobre sua saúde, solicitamos que você forneça seus batimentos cardíacos em repouso. Essa é uma medida importante para entender melhor o funcionamento do seu coração e monitorar sua saúde cardiovascular.',
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(height: 50),
                                                const Text(
                                                  'Por que é importante informar seus batimentos em repouso?',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                const Text(
                                                  'Os batimentos cardíacos em repouso são um indicador crucial da saúde do seu coração. Eles refletem o quão eficientemente seu coração está bombeando sangue enquanto você está em um estado de repouso. Taxas de batimentos em repouso fora do intervalo normal podem ser um sinal de possíveis problemas cardíacos.',
                                                  textAlign: TextAlign.justify,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Manter um registro dos seus batimentos em repouso ao longo do tempo permite que você e seus profissionais de saúde monitorem qualquer mudança ou tendência que possa exigir atenção médica. Isso ajuda na detecção precoce de problemas cardíacos e na prevenção de complicações futuras.',
                                                  textAlign: TextAlign.justify,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                const SizedBox(height: 10),
                                                Container(
                                                  height: 1,
                                                  color: Colors.grey,
                                                ),
                                                const SizedBox(height: 30),
                                                const Text(
                                                  'Lembramos que essas informações são confidenciais e serão usadas exclusivamente para fornecer um serviço personalizado e melhorar sua experiência de saúde! O monitoramento regular dos batimentos cardíacos em repouso é uma prática importante para cuidar da sua saúde cardiovascular.',
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 20),
                                                const Text(
                                                  'Agradecemos pela sua colaboração e por escolher cuidar da sua saúde conosco.',
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                const Text(
                                                  'Atenciosamente,',
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                const Text(
                                                  'Equipe VitalAge',
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xFF3c67b4),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: const Color(0xFF0f1539)
                                                    .withOpacity(0.3)),
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _isPress = !_isPress;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.close_rounded,
                                                color: Colors.red,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
