// ignore_for_file: avoid_print
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/animations/fade_animation.dart';
import 'package:vital_age/models/batimento.dart';
import 'package:vital_age/pages/registro_page.dart';
import 'package:vital_age/providers/bar_data.dart';
import 'package:vital_age/providers/batimentos_repository.dart';
import 'package:vital_age/services/firestore_service.dart';
import 'package:vital_age/util/media_query.dart';
import 'package:vital_age/util/snack_bar.dart';
import 'package:vital_age/widgets/bar_graph.dart';
import 'package:vital_age/services/auth_service.dart';

import '../widgets/card_batimentos.dart';
import 'add_batimentos_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  late String id;
  late DatabaseReference databaseReference;
  FirebaseService firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Coleta dados do Banco
    context.read<AuthService>().obterDados();

    // Definindo path e id
    id = firebaseService.getUserId();
    databaseReference = firebaseService.getHeartbeatsReference();

    // Iniciando repositório de batimentos
    Provider.of<BatimentosRepository>(context, listen: false)
        .iniciarRepositorio(databaseReference);
  }

  // Rota para tela de inserção de batimentos
  telaBatimentos() {
    Get.to(const AddBatimentosPage(), transition: Transition.downToUp);
  }

  @override
  void dispose() {
    databaseReference.onChildAdded.drain();
    databaseReference.onChildRemoved.drain();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Pega as informações do dispositivo
    MediaQueryData deviceInfo = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Util.getDeviceType(context) == 'phone'
                ? 30.0
                : deviceInfo.orientation == Orientation.portrait
                    ? 130
                    : 50,
          ),
          child: Stack(
            children: [
              deviceInfo.orientation == Orientation.portrait
                  ? orientacionPortrait()
                  : orientacionLandscape()
            ],
          ).animate().fadeIn(duration: 1200.ms).slideY(
                begin: 1,
                duration: 800.ms,
                curve: Curves.fastEaseInToSlowEaseOut,
              ),
        ),
      ),
    );
  }

  // Modo paisagem
  Widget orientacionLandscape() {
    final authService = context.watch<AuthService>();
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Boas-vindas ao usuário
            Padding(
              padding: EdgeInsets.only(
                top: Util.getDeviceType(context) == 'phone' ? 20.0 : 50.0,
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        Util.getDeviceType(context) == 'phone' ? 25.0 : 46.0,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Bem-Vindo,\n',
                    ),
                    TextSpan(
                      text: authService.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: '!',
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              width: widthSize / 2.2,
              height: heightSize / 1.8,
              //color: Colors.red,
              child: SizedBox(
                height: Util.getDeviceType(context) == 'phone'
                    ? heightSize * .5
                    : heightSize * .57,
                child: listaDeBatimentos(),
              ),
            )
          ],
        ),
        graficoDeBatimentos()
      ],
    );
  }

  // Modo retrato
  Widget orientacionPortrait() {
    final double heightSize = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Boas-vindas ao usuário
        Padding(
          padding: EdgeInsets.only(
            top: Util.getDeviceType(context) == 'phone' ? 20.0 : 50.0,
          ),
          child: Consumer<AuthService>(
            builder: (BuildContext context, AuthService value, Widget? child) {
              return RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        Util.getDeviceType(context) == 'phone' ? 25.0 : 46.0,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Bem-Vindo,\n',
                    ),
                    TextSpan(
                      text: value.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: '!',
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // Estilização do TabBar
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            height: heightSize / 16,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF1c1a4b)),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              tabs: [
                Tab(
                  child: Center(
                    child: Icon(
                      Icons.calendar_month,
                      size:
                          Util.getDeviceType(context) == 'phone' ? 25.0 : 40.0,
                      color: const Color(0xFF3c67b4),
                    ),
                  ),
                ),
                Tab(
                  child: Center(
                    child: Icon(
                      Icons.bar_chart_outlined,
                      size:
                          Util.getDeviceType(context) == 'phone' ? 25.0 : 40.0,
                      color: const Color(0xFF3c67b4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // TabView e a lista de batimentos
        SizedBox(
          height: Util.getDeviceType(context) == 'phone'
              ? heightSize / 1.78
              : heightSize / 1.6,
          child: Stack(
            children: [
              SizedBox(
                height: Util.getDeviceType(context) == 'phone'
                    ? heightSize * .52
                    : heightSize * .57,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Mostra todos os cards de Batimentos na tela
                    listaDeBatimentos(),

                    // Gráfico
                    graficoDeBatimentos(),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    telaBatimentos();
                  },
                  child: Container(
                    width:
                        Util.getDeviceType(context) == 'phone' ? 60.0 : 100.0,
                    height:
                        Util.getDeviceType(context) == 'phone' ? 60.0 : 100.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3c67b4),
                      shape: BoxShape.circle,
                      border: Border(
                        bottom: BorderSide(color: Colors.white, width: 2),
                        top: BorderSide(color: Colors.white, width: 2),
                        left: BorderSide(color: Colors.white, width: 2),
                        right: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .shimmer(delay: 400.ms, duration: 1800.ms)
                      .shake(hz: 4, curve: Curves.easeInOutCubic)
                      .scaleXY(end: 1.2, duration: 600.ms)
                      .then(delay: 600.ms)
                      .scaleXY(end: 1 / 1.2),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget listaDeBatimentos() {
    final authService = context.watch<AuthService>();
    final nome = authService.nome;

    return FirebaseAnimatedList(
      defaultChild: const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
      query: databaseReference,
      itemBuilder: (context, snapshot, animation, index) {
        // Resgata a chave única do registro
        String uniqueKey = snapshot.key.toString();

        // Resgata o valor de batimentos do registro
        int batimentos = int.parse(snapshot.child('bpm').value.toString());

        // Resgata a data de inserção do resgistro
        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(
            snapshot.child('timestamp').value.toString(),
          ),
        );

        return GestureDetector(
          onTap: () {
            Get.to(
              () => RegistroPage(
                uniqueKey: uniqueKey,
                batimento: Batimento(
                  batimentos: batimentos,
                  idade: authService.idade,
                  isMale: authService.sexo == "Masculino" ? true : false,
                  dateTime: dateTime,
                  uniqueKey: uniqueKey,
                ),
                nome: nome,
              ),
            );
          },
          child: Slidable(
            startActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  backgroundColor: Colors.transparent,
                  icon: Icons.delete,
                  foregroundColor: Colors.red,
                  label: 'Excluir',
                  spacing: 15,
                  onPressed: (context) {
                    // Apaga o registro onde a key coincidir
                    Provider.of<BatimentosRepository>(context, listen: false)
                        .apagaInformacaoNoBanco(databaseReference, uniqueKey);

                    SnackBarUtil.mostrarSnackBar(
                        context,
                        "Registro deletado com sucesso!",
                        Colors.green,
                        const Icon(Icons.check));
                  },
                ),
              ],
            ),
            child: FadeInUp(
              duration: 1000,
              child: ListaBatimentos(
                batimentos: batimentos,
                idade: authService.idade,
                isMale: authService.sexo == "Masculino" ? true : false,
                dateTime: dateTime,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget graficoDeBatimentos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Consumer<BarData>(
          builder: (context, value, child) {
            return MyBarGraph(
              bars: value.barData,
              cor: Colors.green,
            );
          },
        ),
      ),
    );
  }
}
