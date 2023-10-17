import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/animations/fade_animation.dart';
import 'package:vital_age/models/relatorio.dart';
import 'package:vital_age/providers/batimentos_repository.dart';
import 'package:vital_age/services/auth_service.dart';
import 'package:vital_age/util/media_query.dart';
import 'package:vital_age/util/snack_bar.dart';

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

  String selectedGender = "";
  String defaultGender = "";
  bool _isPress = false;

  final List<String> ageOptions =
      List.generate(101, (index) => index.toString());

  late String id;
  late DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    context.read<AuthService>().obterNome();
    id = context.read<AuthService>().usuario!.uid;
    databaseReference =
        FirebaseDatabase.instance.ref().child('users/$id/heartbeats');
  }

  // Método para mostrar feedback e voltar para a tela principal
  voltar() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    defaultAge = "${Provider.of<Relatorio>(context).idade}";
    defaultGender = Provider.of<Relatorio>(context).sexo;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: widthSize,
            height: heightSize,
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
                              ? 30.0
                              : 80.0,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: widthSize,
                                child: TextFormField(
                                  // Form Adicionar Batimentos
                                  onTapOutside: (event) =>
                                      FocusScope.of(context).unfocus(),
                                  controller: _batimentos,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        Util.getDeviceType(context) == 'phone'
                                            ? 30.0
                                            : 55.0,
                                  ),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Colors.white, width: 2)),
                                    label: const Text("   BPM"),
                                    floatingLabelAlignment:
                                        FloatingLabelAlignment.center,
                                    labelStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.monitor_heart_outlined,
                                      size:
                                          Util.getDeviceType(context) == 'phone'
                                              ? 40.0
                                              : 60.0,
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
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                          Util.getDeviceType(context) == 'phone'
                                              ? 20.0
                                              : 40.0,
                                    ),
                                    child: SizedBox(
                                      // Form Adicionar gênero
                                      width:
                                          Util.getDeviceType(context) == 'phone'
                                              ? 180.0
                                              : 390.0,
                                      child: DropdownButtonFormField<String>(
                                        dropdownColor: const Color(0xFF3c67b4),
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
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                Util.getDeviceType(context) ==
                                                        'phone'
                                                    ? 20.0
                                                    : 55.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              Util.getDeviceType(context) ==
                                                      'phone'
                                                  ? 25.0
                                                  : 55.0,
                                          height: 1.2,
                                          fontFamily: 'KanitBold',
                                        ),
                                        menuMaxHeight: 300,
                                        borderRadius: BorderRadius.circular(20),
                                        value: defaultGender,
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
                                    width:
                                        Util.getDeviceType(context) == 'phone'
                                            ? widthSize / 3.5
                                            : widthSize / 5,
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
                                        labelStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                Util.getDeviceType(context) ==
                                                        'phone'
                                                    ? 20.0
                                                    : 50.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              Util.getDeviceType(context) ==
                                                      'phone'
                                                  ? 25.0
                                                  : 50.0,
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
                              MaterialButton(
                                // Botão adicionar
                                onPressed: () {
                                  setState(() {
                                    if (_formKey.currentState!.validate()) {
                                      int batimentosValue =
                                          int.parse(_batimentos.text);
                                      // ignore: unused_local_variable
                                      int idadeValue;
                                      if (selectedAge.isEmpty) {
                                        idadeValue = int.parse(defaultAge);
                                      } else {
                                        idadeValue = int.parse(selectedAge);
                                      }
                                      String sexoValue;
                                      if (selectedGender.isEmpty) {
                                        sexoValue = defaultGender;
                                      } else {
                                        sexoValue = selectedAge;
                                      }
                                      Provider.of<BatimentosRepository>(context,
                                              listen: false)
                                          .criarInformacoesNoBanco(
                                              databaseReference,
                                              batimentosValue,
                                              idadeValue,
                                              sexoValue);

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
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      Util.getDeviceType(context) == 'phone'
                                          ? 10.0
                                          : 20.0,
                                  horizontal:
                                      Util.getDeviceType(context) == 'phone'
                                          ? 50.0
                                          : 200.0,
                                ),
                                color: const Color(0xFF3c67b4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size:
                                          Util.getDeviceType(context) == 'phone'
                                              ? 30.0
                                              : 40.0,
                                    ),
                                    Text(
                                      'ADICIONAR',
                                      style: TextStyle(
                                        fontSize: Util.getDeviceType(context) ==
                                                'phone'
                                            ? 20.0
                                            : 30.0,
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
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
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
