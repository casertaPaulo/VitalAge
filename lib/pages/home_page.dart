import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vital_age/pages/analise_page.dart';
import 'package:vital_age/pages/home.dart';
import 'package:vital_age/pages/informacoes_page.dart';
import 'package:vital_age/pages/perfil_page.dart';
import 'package:vital_age/util/media_query.dart';

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
    final double heightSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Util.getDeviceType(context) == 'phone' ? 8.0 : 30.0,
            horizontal: Util.getDeviceType(context) == 'phone' ? 8.0 : 130.0,
          ),
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
              padding: EdgeInsets.all(heightSize / 40),
              backgroundColor: Colors.transparent,
              activeColor: Colors.white,
              gap: Util.getDeviceType(context) == 'phone' ? 8.0 : 20.0,
              tabBackgroundColor: const Color(0xFF3c67b4),
              tabBorderRadius: 35,
              selectedIndex: index,
              haptic: true,
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Util.getDeviceType(context) == 'phone' ? 15.0 : 25.0,
              ),
              iconSize: Util.getDeviceType(context) == 'phone' ? 20.0 : 35.0,
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
