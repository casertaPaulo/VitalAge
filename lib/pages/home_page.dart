import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vital_age/pages/analise_page.dart';
import 'package:vital_age/pages/home.dart';
import 'package:vital_age/pages/informacoes_page.dart';
import 'package:vital_age/pages/perfil_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final List<Widget> screen = [
    const Home(),
    const AnalisePage(),
    const InfoPage(),
    const PerfilPage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Theme.of(context).primaryColor,
            ),
            child: GNav(
              onTabChange: (value) {
                setState(() {
                  index = value;
                });
              },
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.transparent,
              activeColor: Colors.white,
              gap: 8,
              tabBackgroundColor: const Color(0xFF3c67b4),
              tabBorderRadius: 35,
              selectedIndex: index,
              haptic: true,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.bar_chart_outlined,
                  text: "Análise",
                ),
                GButton(
                  icon: Icons.info_outline_rounded,
                  text: 'Informações',
                ),
                GButton(
                  icon: Icons.person_2_outlined,
                  text: 'Perfil',
                )
              ],
            ),
          ),
        ),
        body: screen[index],
      ),
    );
  }
}
