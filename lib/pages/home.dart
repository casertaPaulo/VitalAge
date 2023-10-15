import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/providers/bar_data.dart';
import 'package:vital_age/util/snack_bar.dart';
import 'package:vital_age/widgets/bar_graph.dart';
import 'package:vital_age/pages/registro_page.dart';
import 'package:vital_age/providers/batimentos_repository.dart';
import 'package:vital_age/services/auth_service.dart';

import '../models/card_batimentos.dart';
import 'add_batimentos_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  // Instânciando controladores
  late TabController _tabController;
  bool _isPress = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Chama a função que busca o nome no banco
    context.read<AuthService>().obterNome();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Método que joga para a tela de inserção de batimentos
  telaBatimentos() {
    Get.to(const AddBatimentosPage(),
        transition: Transition.leftToRightWithFade);
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Bolinha do perfil
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: const Icon(Icons.person_2_outlined),
                            ),
                          )
                        ],
                      ),

                      // Boas-vindas ao usuário
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
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

                      // Estilização do TabBar
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFF1c1a4b)),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            tabs: const [
                              Tab(
                                child: Center(
                                  child: Icon(
                                    Icons.calendar_month,
                                    color: Color(0xFF3c67b4),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Center(
                                  child: Icon(
                                    Icons.bar_chart_outlined,
                                    color: Color(0xFF3c67b4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // TabView e a lista de batimentos
                      SizedBox(
                        height: constraints.maxHeight * .65,
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              height: constraints.maxHeight * .6,
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
                                  setState(() {
                                    _isPress = !_isPress;
                                  });
                                  telaBatimentos();
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3c67b4),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(),
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
                  ),
                ],
              ).animate().fadeIn(duration: 1200.ms).slideY(
                    begin: 1,
                    duration: 800.ms,
                    curve: Curves.fastEaseInToSlowEaseOut,
                  ),
            );
          },
        ),
      ),
    );
  }

  Widget listaDeBatimentos() {
    return Consumer<BatimentosRepository>(
      builder: (context, value, child) {
        return ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegistroPage(
                        batimentos: value.batimentos[index],
                      ),
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
                          Provider.of<BatimentosRepository>(context,
                                  listen: false)
                              .removeBatimento(
                            value.batimentos[index],
                          );
                          SnackBarUtil.mostrarSnackBar(
                              context,
                              "Registro deletado com sucesso!",
                              Colors.green,
                              const Icon(
                                Icons.check,
                                color: Colors.white,
                              ));
                        },
                      )
                    ],
                  ),
                  child: ListaBatimentos(
                    batimentos: value.batimentos[index].batimentos,
                    idade: value.batimentos[index].idade,
                    isMale: value.batimentos[index].isMale,
                    dateTime: value.batimentos[index].dateTime,
                  ),
                ),
              );
            },
            itemCount: value.batimentos.length);
      },
    );
  }

  Widget graficoDeBatimentos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
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
