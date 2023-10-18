import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/models/batimentos.dart';
import 'package:vital_age/providers/batimentos_repository.dart';
import 'package:vital_age/services/api_service.dart';
import 'package:vital_age/services/auth_service.dart';

import '../models/relatorio.dart';

class RegistroPage extends StatefulWidget {
  final Batimentos batimentos;
  final String uniqueKey;

  const RegistroPage({
    required this.batimentos,
    required this.uniqueKey,
    super.key,
  });

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<IAService>(context, listen: false).completeChat(
        "De acordo a American Heart Association, uma pessoa com ${widget.batimentos.batimentos} batimentos por minuto, com ${widget.batimentos.idade} anos de idade e do sexo ${widget.batimentos.isMale ? "Masculino" : "Feminino"}, está dentro do ideal ou não?");
  }

  @override
  Widget build(BuildContext context) {
    final frequencia = widget.batimentos.batimentos;
    final idade = widget.batimentos.idade;
    final genero = widget.batimentos.isMale;

    BatimentosRepository batimentosRepository = BatimentosRepository();

    final authService = context.watch<AuthService>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            '${DateFormat('E').format(widget.batimentos.dateTime).capitalizeFirst}  ${widget.batimentos.dateTime.day}/${widget.batimentos.dateTime.month}/${widget.batimentos.dateTime.year} ${widget.batimentos.dateTime.hour}:${widget.batimentos.dateTime.minute}',
            style: const TextStyle(
              fontSize: 25,
              fontFamily: 'KanitBold',
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.stacked_line_chart),
                text: 'Visão geral',
              ),
              Tab(
                icon: Icon(Icons.computer_sharp),
                text: 'Inteligência Artificial',
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TabBarView(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Suas\nInformações',
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      children: [
                                        Consumer<Relatorio>(
                                          builder: (BuildContext context,
                                              Relatorio value, Widget? child) {
                                            return Text(
                                              "Nome: ${authService.nome?.capitalizeFirst}\nIdade:  $idade anos\nPeso:   ${value.getPeso()}\nAltura: ${value.getAltura()}",
                                              style: TextStyle(
                                                fontSize: 25,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Batimentos",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "$frequencia",
                                          style: TextStyle(
                                              fontSize: 75,
                                              color: batimentosRepository
                                                  .getCorComBaseNoBatimento(
                                                      widget.batimentos
                                                          .batimentos,
                                                      widget.batimentos.idade,
                                                      widget.batimentos.isMale),
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'KanitBold'),
                                        ),
                                        Image.asset(
                                          "assets/images/heart.png",
                                          height: 60,
                                        )
                                            .animate(
                                              onPlay: (controller) =>
                                                  controller.repeat(),
                                            )
                                            .shimmer(
                                                delay: 400.ms,
                                                duration: 1800.ms)
                                            .scaleXY(end: 1.2, duration: 600.ms)
                                            .then(delay: 600.ms)
                                            .scaleXY(end: 1 / 1.2),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Sua\nSaúde",
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                    Consumer<Relatorio>(
                                      builder: (BuildContext context,
                                          Relatorio value, Widget? child) {
                                        String imc = value.mostraIMC();
                                        String feedbackIMC = value.feedbackIMC(
                                            value.calculaIMC(),
                                            widget.batimentos.idade);

                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "IMC: $imc\nIMC: $feedbackIMC\nPeso ideal: ${value.pesoIdeal(feedbackIMC)}",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  fontWeight: FontWeight.w900,
                                                ),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 12),
                                                child: Text(
                                                  "Seus\nBatimentos",
                                                  style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 1,
                                                color: Colors.grey,
                                              ),
                                              if (batimentosRepository
                                                      .getStringComBaseNoBatimento(
                                                    frequencia,
                                                    idade,
                                                    genero,
                                                  ) ==
                                                  " Rápido")
                                                rapidoColumn()
                                              else if (batimentosRepository
                                                      .getStringComBaseNoBatimento(
                                                    frequencia,
                                                    idade,
                                                    genero,
                                                  ) ==
                                                  " Lento")
                                                lentoColumn()
                                              else
                                                idealColumn()
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                // Page 2
                SingleChildScrollView(
                  child: SizedBox(
                    //color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          SizedBox(
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                fontSize: 35.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              child: AnimatedTextKit(
                                repeatForever: false,
                                isRepeatingAnimation: false,
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                      'Inteligência artificial no seu resultado',
                                      curve: Curves.linear,
                                      speed: const Duration(milliseconds: 100)),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Consumer<IAService>(
                              builder: (BuildContext context, IAService value,
                                  Widget? child) {
                                return Text(
                                  value.resposta,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20,
                                    height: 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget rapidoColumn() {
    final frequencia = widget.batimentos.batimentos;
    final idade = widget.batimentos.idade;
    final genero = widget.batimentos.isMale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Seus batimentos estão muito rápidos!",
            style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 15,
          ),
          child: Text(
            "A frequência cardíaca deste registro é de $frequencia batimentos por minuto, acima da frequência atual ${genero ? "dos homens" : "das mulheres"} com idade ${idade < 65 ? "entre 1 e 65" : "acima dos 65 anos(idoso)"} anos!",
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
        ),
        const Text(
          "Cuidado!",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: Colors.grey,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Quando seus batimentos cardíacos estão muito rápidos, isso pode ser um sinal de que seu coração está trabalhando mais do que o normal. Isso é importante prestar atenção, pois pode ser um indicativo de várias condições de saúde. Se você está sentindo seus batimentos cardíacos acelerados e isso não está relacionado a atividades físicas intensas, como exercícios, aqui estão algumas ações que você deve considerar:\n\n1. Avalie a sua situação: Verifique se você está se sentindo bem em geral. Se estiver com outros sintomas preocupantes, como tontura, falta de ar ou dor no peito, procure ajuda médica imediatamente.\n2. Descanse e relaxe: Às vezes, o estresse e a ansiedade podem aumentar a frequência cardíaca. Tente relaxar, respirar profundamente e afastar-se de situações estressantes.\n3. Hidrate-se: A desidratação também pode afetar a frequência cardíaca. Beba água para garantir que você esteja bem hidratado.\n6. Procure ajuda médica: Se seus batimentos cardíacos rápidos persistirem ou se você tiver outros sintomas graves, é aconselhável procurar orientação médica. Se for um episódio agudo ou você estiver em um ambiente médico, a equipe médica poderá fornecer o tratamento adequado.\n\nLembre-se de que a frequência cardíaca rápida pode ser causada por uma série de fatores, e a avaliação de um profissional de saúde é essencial para determinar a causa e o tratamento adequado. Não hesite em procurar ajuda se você estiver preocupado com seus batimentos cardíacos.",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }

  Widget lentoColumn() {
    final frequencia = widget.batimentos.batimentos;
    final idade = widget.batimentos.idade;
    final genero = widget.batimentos.isMale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Seus batimentos estão lentos!",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 15,
          ),
          child: Text(
            "A frequência cardíaca deste registro é de $frequencia batimentos por minuto, abaixo da frequência atual ${genero ? "dos homens" : "das mulheres"} com idade ${idade < 65 ? "entre 1 e 65" : "acima dos 65 anos(idoso)"} anos!",
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
        ),
        const Text(
          "Cuidado!",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: Colors.grey,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Quando seus batimentos cardíacos estão mais lentos do que o normal, isso pode indicar uma condição médica que requer atenção. Batimentos cardíacos lentos, também conhecidos como bradicardia, podem ser causados por várias razões. Se você notar que seus batimentos cardíacos estão anormalmente lentos e não há razão óbvia, considere o seguinte:\n\n1. Avalie a sua situação: Verifique se você está se sentindo bem em geral. Se estiver com outros sintomas preocupantes, como tontura, desmaios ou falta de ar, procure ajuda médica imediatamente.\n2. Descanse e relaxe: Às vezes, o batimento cardíaco lento pode ser uma resposta ao relaxamento excessivo. No entanto, se isso persistir ou causar desconforto, procure orientação médica.\n 3. Procure ajuda médica: Se a bradicardia persistir ou se você tiver outros sintomas graves, é aconselhável procurar orientação médica. Se estiver em um ambiente médico, a equipe médica poderá fornecer o tratamento adequado.\n\n Lembre-se de que batimentos cardíacos lentos podem ser causados por várias razões, e a avaliação de um profissional de saúde é essencial para determinar a causa e o tratamento adequado. Não hesite em procurar ajuda se você estiver preocupado com seus batimentos cardíacos lentos.",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }

  Widget idealColumn() {
    final frequencia = widget.batimentos.batimentos;
    final idade = widget.batimentos.idade;
    final genero = widget.batimentos.isMale;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Seus batimentos estão ótimos!",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 15,
          ),
          child: Text(
            "A frequência cardíaca deste registro é de $frequencia batimentos por minuto, ideal entre a frequência atual ${genero ? "dos homens" : "das mulheres"} com idade ${idade < 65 ? "entre 1 e 65" : "acima dos 65 anos(idoso)"} anos!",
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
        ),
        const Text(
          "Fique Tranquilo!",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: Colors.grey,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Quando seus batimentos cardíacos estão dentro da faixa ideal, isso é um indicativo positivo da saúde do seu coração. Ter uma frequência cardíaca que está na faixa considerada normal é um sinal de que seu coração está funcionando eficientemente. No entanto, mesmo que seus batimentos cardíacos estejam dentro do ideal, ainda é importante cuidar da sua saúde cardíaca.\n\nLembre-se de que manter seus batimentos cardíacos dentro da faixa ideal é um sinal promissor, mas também é importante adotar um estilo de vida saudável para garantir que seu coração continue a funcionar da melhor maneira possível",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            textAlign: TextAlign.justify,
          ),
        ),
      ],
    );
  }
}
