import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vital_age/providers/bar_data.dart';
import 'package:vital_age/firebase_options.dart';
import 'package:vital_age/models/relatorio.dart';
import 'package:vital_age/providers/registro_repository.dart';
import 'package:vital_age/services/api_service.dart';
import 'package:vital_age/services/auth_service.dart';
import 'package:vital_age/services/firestore_service.dart';
import 'package:vital_age/widgets/auth_check.dart';

Future<void> loadEnvironment() async {
  await dotenv.load(fileName: ".env");
}

void main() async {
  // Garante que todo o framework do flutter esteja inicilizado
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Intl.defaultLocale = 'pt_BR'; // Inicialize o idioma para 'pt_BR'
  initializeDateFormatting(); // Inicialize os dados de localização

  // Pega a plataforma atual da qual o user está e iniciliza o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await loadEnvironment();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Relatorio(),
      ),
      ChangeNotifierProvider(
        create: (context) => AuthService(),
      ),
      ChangeNotifierProvider(
        create: (context) => BatimentosRepository(),
      ),
      ChangeNotifierProvider(
        create: (context) => BarData(
            context.read<BatimentosRepository>(), context.read<AuthService>()),
      ),
      ChangeNotifierProvider(
        create: (context) => IAService(),
      ),
      ChangeNotifierProvider(
        create: (context) => FirebaseService(),
      ),
    ],
    child: const MainApp(),
  ));
  Animate.restartOnHotReload;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF0f1539),
          primaryColor: const Color(0xFF1c1a4b),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: const Color(0xFF1c1a4b))),
      home: AuthCheck(),
    );
  }
}
