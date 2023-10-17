import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/animations/fade_animation.dart';
import 'package:vital_age/models/relatorio.dart';
import 'package:vital_age/services/auth_service.dart';
import 'package:vital_age/util/media_query.dart';
import 'package:vital_age/util/snack_bar.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _peso = TextEditingController();
  final _altura = TextEditingController();
  final _idade = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Controlando o DragonBottom
  bool _pressPeso = false;
  bool _pressAltura = false;
  bool _pressIdade = false;
  bool _pressSexo = false;

  @override
  Widget build(BuildContext context) {
    // Setando controladores

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cabeçalho
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Edite seus \nDados!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          MaterialButton(
                            color: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            onPressed: () {
                              context.read<AuthService>().logout();
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.exit_to_app,
                                  color: Colors.white,
                                ),
                                Text(
                                  'SAIR',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // Corpo
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _pressPeso = !_pressPeso;
                            });
                          },
                          // Container para o PESO
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 170,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Peso",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        Provider.of<Relatorio>(context)
                                                    .peso
                                                    .truncate() ==
                                                0
                                            ? "N/D"
                                            : "${Provider.of<Relatorio>(context).peso.truncate()}",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 60,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset("assets/images/escala.png"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Container para a ALTURA
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _pressAltura = !_pressAltura;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 170,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Altura",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        Provider.of<Relatorio>(context)
                                                    .altura ==
                                                0
                                            ? "N/D"
                                            : "${Provider.of<Relatorio>(context).altura}m",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 45,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset("assets/images/altura.png"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _pressIdade = true;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 170,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "   Idade",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        Provider.of<Relatorio>(context).idade ==
                                                0
                                            ? "N/D"
                                            : " ${Provider.of<Relatorio>(context).idade}",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 60,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                      "assets/images/grupo-de-idade.png"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Gênero
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _pressSexo = true;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 170,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(25.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Sexo",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        Provider.of<Relatorio>(context).sexo ==
                                                ""
                                            ? "N/D"
                                            : " ${Provider.of<Relatorio>(context).sexo}",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset("assets/images/sexologia.png"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_pressPeso)
              pesoScreen()
            else if (_pressAltura)
              alturaSreen()
            else if (_pressIdade)
              idadeScreen()
            else if (_pressSexo)
              sexoScreen()
          ],
        ),
      ),
    );
  }

  Widget pesoScreen() {
    return FadeInUp(
      duration: 400,
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _pressPeso = false;
                            _pressAltura = false;
                            _pressIdade = false;
                            _pressSexo = false;
                          });
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const Text(
                      "Peso",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextFormField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      controller: _peso,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 3,
                          color: Colors.white,
                        )),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        hintText: "Insira o peso",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                        contentPadding: EdgeInsets.all(15),
                        filled: false,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe o peso!';
                        }
                        return null;
                      },
                    ),
                    MaterialButton(
                        // Botão adicionar
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              _pressPeso = false;
                              double pesoValue = double.parse(_peso.text);
                              Provider.of<Relatorio>(context, listen: false)
                                  .setPeso(pesoValue);
                              SnackBarUtil.mostrarSnackBar(
                                  context,
                                  "Peso atualizado!",
                                  Colors.green,
                                  const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ));
                            } else {
                              SnackBarUtil.mostrarSnackBar(
                                context,
                                "Erro! Insira o peso corretamente!",
                                Colors.red,
                                const Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                              );
                            }
                          });
                        },
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
                        color: const Color(0xFF3c67b4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text(
                              'SALVAR',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'KanitBold',
                                  color: Colors.white),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget alturaSreen() {
    return FadeInUp(
      duration: 400,
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _pressPeso = false;
                            _pressAltura = false;
                            _pressIdade = false;
                            _pressSexo = false;
                          });
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const Text(
                      "Altura",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextFormField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      controller: _altura,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 3,
                          color: Colors.white,
                        )),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        hintText: "Insira a altura",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                        contentPadding: EdgeInsets.all(15),
                        filled: false,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe a altura!';
                        }
                        return null;
                      },
                    ),
                    MaterialButton(
                        // Botão adicionar
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              _pressAltura = false;
                              double alturaValue = double.parse(_altura.text);
                              Provider.of<Relatorio>(context, listen: false)
                                  .setAltura(alturaValue);
                              SnackBarUtil.mostrarSnackBar(
                                context,
                                "Altura atualizada!",
                                Colors.green,
                                const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              SnackBarUtil.mostrarSnackBar(
                                context,
                                "Erro! Insira a altura corretamente!",
                                Colors.red,
                                const Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                              );
                            }
                          });
                        },
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 50,
                        ),
                        color: const Color(0xFF3c67b4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text(
                              'SALVAR',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'KanitBold',
                                  color: Colors.white),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget idadeScreen() {
    return FadeInUp(
      duration: 400,
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _pressPeso = false;
                            _pressAltura = false;
                            _pressIdade = false;
                            _pressSexo = false;
                          });
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const Text(
                      "Idade",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    TextFormField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      controller: _idade,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          width: 3,
                          color: Colors.white,
                        )),
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        hintText: "Insira a idade",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                        contentPadding: EdgeInsets.all(15),
                        filled: false,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Informe a idade!';
                        }
                        return null;
                      },
                    ),
                    MaterialButton(
                      // Botão adicionar
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            _pressIdade = false;
                            int idadeValue = int.parse(_idade.text);
                            Provider.of<Relatorio>(context, listen: false)
                                .setIdade(idadeValue);
                            SnackBarUtil.mostrarSnackBar(
                              context,
                              "Idade atualizada!",
                              Colors.green,
                              const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            SnackBarUtil.mostrarSnackBar(
                              context,
                              "Erro! Insira a idade corretamente!",
                              Colors.red,
                              const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                            );
                          }
                        });
                      },
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                      color: const Color(0xFF3c67b4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            'SALVAR',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'KanitBold',
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget sexoScreen() {
    return FadeInUp(
      duration: 400,
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue,
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _pressPeso = false;
                            _pressAltura = false;
                            _pressIdade = false;
                            _pressSexo = false;
                          });
                        },
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const Text(
                      "Sexo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      // Form Adicionar gênero
                      width: Util.getDeviceType(context) == 'phone'
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: const Color(0xFF1c1a4b),
                          label: const Text('Sexo'),
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: Util.getDeviceType(context) == 'phone'
                                ? 20.0
                                : 55.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Util.getDeviceType(context) == 'phone'
                              ? 25.0
                              : 55.0,
                          height: 1.2,
                          fontFamily: 'KanitBold',
                        ),
                        menuMaxHeight: 300,
                        borderRadius: BorderRadius.circular(20),
                        value: Provider.of<Relatorio>(context).sexo,
                        onChanged: (newValue) {
                          Provider.of<Relatorio>(context, listen: false)
                              .setSexo(newValue!);
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
                    MaterialButton(
                      // Botão adicionar
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            _pressSexo = false;

                            SnackBarUtil.mostrarSnackBar(
                              context,
                              "Sexo atualizado!",
                              Colors.green,
                              const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            );
                          } else {
                            SnackBarUtil.mostrarSnackBar(
                              context,
                              "Erro! Insira o sexo corretamente!",
                              Colors.red,
                              const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                            );
                          }
                        });
                      },
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                      color: const Color(0xFF3c67b4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            'SALVAR',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'KanitBold',
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
