import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/animations/fade_animation.dart';
import 'package:vital_age/providers/registro_repository.dart';
import 'package:vital_age/services/auth_service.dart';
import 'package:vital_age/services/firestore_service.dart';
import 'package:vital_age/util/media_query.dart';
import 'package:vital_age/util/snack_bar.dart';

class AddBatimentosPage extends StatefulWidget {
  const AddBatimentosPage({
    super.key,
  });

  @override
  State<AddBatimentosPage> createState() => _AddBatimentosPageState();
}

class _AddBatimentosPageState extends State<AddBatimentosPage> {
  // Controladores
  final _batimentos = TextEditingController();
  final _oxigenacao = TextEditingController();
  final _temperatura = TextEditingController();
  final _glicose = TextEditingController();
  final _sistolica = TextEditingController();
  final _diastolica = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isPress = false;

  late String id;
  late DatabaseReference databaseReference;
  FirebaseService firebaseService = FirebaseService();

  @override
  void initState() {
    super.initState();
    // Coleta de dados
    context.read<AuthService>().obterDados();

    // Definindo path e id
    id = firebaseService.getUserId();
    databaseReference = firebaseService.getHeartbeatsReference();
  }

  // Método para mostrar feedback e voltar para a tela principal
  voltar() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Definindo tamanho da tela
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: widthSize,
            height: heightSize + 50,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        Util.getDeviceType(context) == 'phone' ? 30.0 : 120.0,
                    vertical: 10,
                  ),
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
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        Util.getDeviceType(context) == 'phone'
                                            ? 30.0
                                            : 60.0,
                                  ),
                                  children: const [
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
                              height: Util.getDeviceType(context) == 'phone'
                                  ? 50.0
                                  : 90.0,
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
                        padding: EdgeInsets.symmetric(
                          vertical: Util.getDeviceType(context) == 'phone'
                              ? 35.0
                              : 80.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      // CONTAINER DE BATIMENTOS
                                      Container(
                                        width: constraints.maxWidth / 2 - 5,
                                        height: 180,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 25,
                                                ),
                                                child: Row(
                                                  // Cabeçalho do card
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Batimentos',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontFamily:
                                                            'RobotoCondensed',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                      child: Image.asset(
                                                        'assets/images/VitalAge.png',
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              // Text Form Field
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth /
                                                            4,
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Informe os batimentos!";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      controller: _batimentos,
                                                      onTapOutside: (event) =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 50,
                                                        height: 0.9,
                                                        fontFamily: 'KanitBold',
                                                      ),
                                                      decoration:
                                                          const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'bpm',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      height: 2.5,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      // CONTAINER DE OXIGENAÇÃO
                                      Container(
                                        width: constraints.maxWidth / 2 - 5,
                                        height: 180,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 25,
                                                ),
                                                child: Row(
                                                  // Cabeçalho do card
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Oxigenação',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontFamily:
                                                            'RobotoCondensed',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                      child: Image.asset(
                                                        'assets/images/VitalAge.png',
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              // Text Form Field
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth /
                                                            4.5,
                                                    child: TextFormField(
                                                      controller: _oxigenacao,
                                                      onTapOutside: (event) =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 50,
                                                        height: 0.9,
                                                        fontFamily: 'KanitBold',
                                                      ),
                                                      decoration:
                                                          const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '%Sp02',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      height: 2.5,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    children: [
                                      // CONTAINER DE SISTÓLICA
                                      Container(
                                        width: constraints.maxWidth / 2 - 5,
                                        height: 180,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 25,
                                                ),
                                                child: Row(
                                                  // Cabeçalho do card
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Sistólica',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontFamily:
                                                            'RobotoCondensed',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                      child: Image.asset(
                                                        'assets/images/pressao.png',
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              // Text Form Field
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth /
                                                            4.5,
                                                    child: TextFormField(
                                                      controller: _sistolica,
                                                      onTapOutside: (event) =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 50,
                                                        height: 0.9,
                                                        fontFamily: 'KanitBold',
                                                      ),
                                                      decoration:
                                                          const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'mmHg',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      height: 2.5,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      // CONTAINER DE DIASTÓLICA
                                      Container(
                                        width: constraints.maxWidth / 2 - 5,
                                        height: 180,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 25,
                                                ),
                                                child: Row(
                                                  // Cabeçalho do card
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text(
                                                      'Diastólica',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontFamily:
                                                            'RobotoCondensed',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                      child: Image.asset(
                                                        'assets/images/pressao.png',
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),

                                              // Text Form Field
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        constraints.maxWidth /
                                                            4.5,
                                                    child: TextFormField(
                                                      controller: _diastolica,
                                                      onTapOutside: (event) =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 50,
                                                        height: 0.9,
                                                        fontFamily: 'KanitBold',
                                                      ),
                                                      decoration:
                                                          const InputDecoration(
                                                        focusedBorder:
                                                            UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'mmHg',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      height: 2.5,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  Container(
                                    width: constraints.maxWidth,
                                    height: 180,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(35),
                                        color: Theme.of(context).primaryColor),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 25,
                                            ),
                                            child: Row(
                                              // Cabeçalho do card
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Glicose',
                                                  style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily:
                                                        'RobotoCondensed',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 35,
                                                  child: Image.asset(
                                                    'assets/images/glicose.png',
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          // Text Form Field
                                          Row(
                                            children: [
                                              SizedBox(
                                                width:
                                                    constraints.maxWidth / 2.5,
                                                child: TextFormField(
                                                  controller: _glicose,
                                                  onTapOutside: (event) =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 60,
                                                    height: 0.9,
                                                    fontFamily: 'KanitBold',
                                                  ),
                                                  decoration:
                                                      const InputDecoration(
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'mg/dL',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  height: 2.5,
                                                  color: Colors.grey.shade600,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 20,
                                  ),
                                  // Botão de Salvar registros
                                  MaterialButton(
                                    color: Colors.white,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Batimento do formulário
                                        int oxigenacaoValue = 0;
                                        int glicoseValue = 0;
                                        int sistolicaValue = 0;
                                        int diastolicaValue = 0;
                                        int batimentosValue =
                                            int.parse(_batimentos.text);

                                        if (_oxigenacao.text.isNotEmpty) {
                                          oxigenacaoValue =
                                              int.parse(_oxigenacao.text);
                                        }

                                        if (_glicose.text.isNotEmpty) {
                                          glicoseValue =
                                              int.parse(_glicose.text);
                                        }

                                        if (_sistolica.text.isNotEmpty) {
                                          sistolicaValue =
                                              int.parse(_sistolica.text);
                                        }

                                        if (_diastolica.text.isNotEmpty) {
                                          diastolicaValue =
                                              int.parse(_diastolica.text);
                                        }

                                        // Cria registro no banco
                                        Provider.of<BatimentosRepository>(
                                                context,
                                                listen: false)
                                            .criarInformacoesNoBanco(
                                                databaseReference,
                                                batimentosValue,
                                                glicoseValue,
                                                oxigenacaoValue,
                                                sistolicaValue,
                                                diastolicaValue);

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
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(18.0),
                                      child: Text(
                                        'Salvar',
                                        style: TextStyle(
                                          fontFamily: 'RobotoCondensed',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
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
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
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
                                      child: SizedBox(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 20),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Center(
                                                child: Image.asset(
                                                  'assets/images/Screenshot 2023-09-09 173707.png',
                                                  width: Util.getDeviceType(
                                                              context) ==
                                                          'phone'
                                                      ? widthSize
                                                      : widthSize / 1.5,
                                                )
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
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Util.getDeviceType(
                                                            context) ==
                                                        'phone'
                                                    ? 30.0
                                                    : 160.0,
                                                vertical: 10,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      height: 1,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Util.getDeviceType(
                                                                context) ==
                                                            'phone'
                                                        ? 10.0
                                                        : 30.0,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize:
                                                            Util.getDeviceType(
                                                                        context) ==
                                                                    'phone'
                                                                ? 30.0
                                                                : 50.0,
                                                      ),
                                                      children: const [
                                                        TextSpan(
                                                          text:
                                                              'Batimentos em\n',
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
                                                    style: TextStyle(
                                                      fontSize:
                                                          Util.getDeviceType(
                                                                      context) ==
                                                                  'phone'
                                                              ? 18.0
                                                              : 25.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    'Para garantir que possamos fornecer a você a melhor experiência e informações precisas sobre sua saúde, solicitamos que você forneça seus batimentos cardíacos em repouso. Essa é uma medida importante para entender melhor o funcionamento do seu coração e monitorar sua saúde cardiovascular.',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      fontSize:
                                                          Util.getDeviceType(
                                                                      context) ==
                                                                  'phone'
                                                              ? 18.0
                                                              : 25.0,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 50),
                                                  Text(
                                                    'Por que é importante informar seus batimentos em repouso?',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize:
                                                          Util.getDeviceType(
                                                                      context) ==
                                                                  'phone'
                                                              ? 25.0
                                                              : 40.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    'Os batimentos cardíacos em repouso são um indicador crucial da saúde do seu coração. Eles refletem o quão eficientemente seu coração está bombeando sangue enquanto você está em um estado de repouso. Taxas de batimentos em repouso fora do intervalo normal podem ser um sinal de possíveis problemas cardíacos.',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      fontSize:
                                                          Util.getDeviceType(
                                                                      context) ==
                                                                  'phone'
                                                              ? 18.0
                                                              : 25.0,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    'Manter um registro dos seus batimentos em repouso ao longo do tempo permite que você e seus profissionais de saúde monitorem qualquer mudança ou tendência que possa exigir atenção médica. Isso ajuda na detecção precoce de problemas cardíacos e na prevenção de complicações futuras.',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      fontSize:
                                                          Util.getDeviceType(
                                                                      context) ==
                                                                  'phone'
                                                              ? 18.0
                                                              : 25.0,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Container(
                                                    height: 1,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(height: 30),
                                                  Text(
                                                    'Lembramos que essas informações são confidenciais e serão usadas exclusivamente para fornecer um serviço personalizado e melhorar sua experiência de saúde! O monitoramento regular dos batimentos cardíacos em repouso é uma prática importante para cuidar da sua saúde cardiovascular.',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                        fontSize:
                                                            Util.getDeviceType(
                                                                        context) ==
                                                                    'phone'
                                                                ? 18.0
                                                                : 25.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    'Agradecemos pela sua colaboração e por escolher cuidar da sua saúde conosco.',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      fontSize:
                                                          Util.getDeviceType(
                                                                      context) ==
                                                                  'phone'
                                                              ? 18.0
                                                              : 25.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Text(
                                                    'Atenciosamente,',
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      fontSize:
                                                          Util.getDeviceType(
                                                                      context) ==
                                                                  'phone'
                                                              ? 18.0
                                                              : 25.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      bottom: Util.getDeviceType(
                                                                  context) ==
                                                              'phone'
                                                          ? 0.0
                                                          : 100.0,
                                                    ),
                                                    child: Text(
                                                      'Equipe VitalAge',
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: TextStyle(
                                                        fontSize:
                                                            Util.getDeviceType(
                                                                        context) ==
                                                                    'phone'
                                                                ? 18.0
                                                                : 25.0,
                                                        color: const Color(
                                                            0xFF3c67b4),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            width:
                                                Util.getDeviceType(context) ==
                                                        'phone'
                                                    ? 50.0
                                                    : 80.0,
                                            height:
                                                Util.getDeviceType(context) ==
                                                        'phone'
                                                    ? 50.0
                                                    : 80.0,
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
                                              icon: Icon(
                                                Icons.close_rounded,
                                                color: Colors.red,
                                                size: Util.getDeviceType(
                                                            context) ==
                                                        'phone'
                                                    ? 30.0
                                                    : 40.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
