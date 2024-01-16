// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:vital_age/animations/fade_animation.dart';
import 'package:vital_age/models/onboarding_content.dart';
import 'package:vital_age/services/auth_service.dart';
import 'package:vital_age/util/snack_bar.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // Definindo os controladores para o Form
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();
  final nome = TextEditingController();

  // Definindo lógica de tela de login ou register
  bool isLogin = true;
  bool isRegister = false;
  bool isLoading = false;
  late String title;
  late String actionButton;
  late String toggleButton;
  late String image;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setForm(true);
  }

  // Verifica se é tela de login ou é tela de registro
  setForm(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        title = "Bem vindo";
        actionButton = "Login";
        toggleButton = "Ainda não tem uma conta? Cadastre-se.";
        image = 'assets/images/login.png';
        isRegister = false;
      } else {
        title = "Crie sua conta";
        actionButton = "Cadastrar";
        toggleButton = "Voltar ao Login";
        image = 'assets/images/personagem-login.png';
        isRegister = true;
      }
    });
  }

  // PageView Controller
  final PageController _pageController = PageController(initialPage: 0);
  bool _isPress = false;
  int _currentIndex = 0;
  bool obscureText = true;

  // Lógica para os métodos de Login ou Registro
  login() async {
    setState(() => isLoading = true);
    try {
      await context.read<AuthService>().login(email.text, senha.text);
      // ignore: use_build_context_synchronously
    } on AuthException catch (e) {
      setState(() => isLoading = false);
      SnackBarUtil.mostrarSnackBar(
        context,
        e.message,
        Colors.red,
        const Icon(
          Icons.error,
          color: Colors.white,
        ),
      );
    }
  }

  registrar() async {
    setState(() => isLoading = true);
    try {
      await context
          .read<AuthService>()
          .registrar(email.text, senha.text, nome.text);
    } on AuthException catch (e) {
      setState(() => isLoading = false);
      SnackBarUtil.mostrarSnackBar(
        context,
        e.message,
        Colors.red,
        const Icon(
          Icons.error,
          color: Colors.white,
        ),
      );
    }
  }

  // Dados do Onboarding
  final data = OnboadingContent().data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF161342),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double padding = constraints.maxWidth * .06;
            return Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight * .8,
                      width: constraints.maxWidth,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            _currentIndex = value;
                          });
                        },
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: padding),
                            child: FadeInUp(
                              duration: 1000,
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    controller: _scrollController,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Image.asset(
                                            data[index].image,
                                            height: constraints.maxHeight * .4,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                constraints.maxHeight * .02),
                                        Text(
                                          data[index].title,
                                          style: TextStyle(
                                            fontFamily: 'CM Sans Serif',
                                            height: 1,
                                            fontSize:
                                                constraints.maxHeight * .05,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                constraints.maxHeight * .02),
                                        Text(
                                          data[index].description,
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize:
                                                constraints.maxHeight * .02,
                                            height: 1.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                // Parte para o Feedback
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Controladores de página
                    FadeInUp(
                      duration: 1000,
                      child: SizedBox(
                        height: constraints.maxHeight * .07,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: padding),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmoothPageIndicator(
                                effect: ExpandingDotsEffect(
                                  activeDotColor: Colors.white,
                                  dotHeight: constraints.maxHeight * .01,
                                  dotWidth: constraints.maxHeight * .02,
                                ),
                                controller: _pageController,
                                count: data.length,
                              ),
                              _currentIndex != data.length - 1
                                  ? FloatingActionButton(
                                      backgroundColor: Colors.white,
                                      onPressed: () {
                                        _pageController.nextPage(
                                          duration: const Duration(
                                              milliseconds: 1200),
                                          curve: Curves.ease,
                                        );
                                      },
                                      child: Icon(
                                        Icons.arrow_right_alt_outlined,
                                        color: const Color(0xFF161342),
                                        size: constraints.maxHeight * .05,
                                      ),
                                    )
                                  : const Text(''),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Icon seta para cima para Login
                    _currentIndex == data.length - 1
                        ? Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isPress = true;
                                  });
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_upward_outlined,
                                      color: Color(0xFF161342),
                                      size: 30,
                                    ),
                                  ),
                                ).animate().fadeIn(duration: 1200.ms).slideY(
                                    begin: 1,
                                    duration: 800.ms,
                                    curve: Curves.fastEaseInToSlowEaseOut),
                              ),
                            ),
                          )
                        : const Text(''),
                    const SizedBox(height: 30),
                  ],
                ),

                // AREA QUE SOBE O LOGIN
                _isPress
                    ? FadeInUp(
                        duration: 500,
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.95,
                          minChildSize: 0.1,
                          maxChildSize: 0.95,
                          snap: true,
                          builder: (context, scrollController) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30)),
                              ),
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),

                                  // Onde se inicia o Form, tanto de login quando de registro
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            height:
                                                constraints.maxHeight * .01),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isPress = false;
                                            });
                                          },
                                          child: const Icon(
                                              Icons.arrow_downward_sharp),
                                        ),
                                        const SizedBox(height: 10),
                                        Image.asset(
                                          image,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .3,
                                        )
                                            .animate()
                                            .fadeIn(duration: 1200.ms)
                                            .slideY(
                                                begin: 1,
                                                duration: 1200.ms,
                                                curve: Curves.ease),
                                        const SizedBox(height: 20),
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            height: 1.2,
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            children: [
                                              // Se registro for true, ele adiciona o campo de nome
                                              isRegister
                                                  ? TextFormField(
                                                      onTapOutside: (event) =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      controller: nome,
                                                      decoration: const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          labelText: 'Nome',
                                                          prefixIcon: Icon(Icons
                                                              .person_2_outlined)),
                                                      keyboardType:
                                                          TextInputType.name,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Informe o nome!';
                                                        }
                                                        return null;
                                                      },
                                                    )
                                                  : Container(),
                                              SizedBox(
                                                  height:
                                                      constraints.maxHeight *
                                                          .03),
                                              TextFormField(
                                                onTapOutside: (event) =>
                                                    FocusScope.of(context)
                                                        .unfocus(),
                                                controller: email,
                                                decoration:
                                                    const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        labelText: 'Email',
                                                        prefixIcon:
                                                            Icon(Icons.email)),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Informe o email corretamente!';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(
                                                  height:
                                                      constraints.maxHeight *
                                                          .03),
                                              TextFormField(
                                                onTapOutside: (event) =>
                                                    FocusScope.of(context)
                                                        .unfocus(),
                                                controller: senha,
                                                obscureText: obscureText,
                                                decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    suffixIcon: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          obscureText =
                                                              !obscureText;
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.remove_red_eye,
                                                      ),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                    labelText: 'Senha',
                                                    prefixIcon:
                                                        const Icon(Icons.key)),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Informa sua senha!';
                                                  } else if (value.length < 6) {
                                                    return 'Sua senha deve ter no mínimo 6 caracteres';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                constraints.maxHeight * .03),
                                        MaterialButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              if (isLogin) {
                                                login();
                                              } else {
                                                registrar();
                                              }
                                            }
                                          },
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 40),
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            side: const BorderSide(
                                              color: Colors.blue,
                                              width: 2,
                                            ),
                                          ),
                                          elevation: 4,
                                          highlightColor: Colors.blue,
                                          highlightElevation: 0,
                                          child: (isLoading)
                                              ? const Padding(
                                                  padding: EdgeInsets.all(1),
                                                  child: SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                )
                                              : Text(
                                                  actionButton,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setForm(!isLogin);
                                          },
                                          child: Text(
                                            toggleButton,
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Text('')
              ],
            );
          },
        ),
      ),
    );
  }
}
