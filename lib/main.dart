import 'package:flutter/material.dart';
import 'package:taibahcare/Screens/WelcomeScreen.dart';
import 'package:taibahcare/Screens/LoginScreen.dart';
import 'package:taibahcare/Screens/RegisterScreen.dart';
// import 'package:taibahcare/Screens/Additional.dart';
import 'package:taibahcare/Screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taibahcare/Screens/chat.dart';
import 'package:taibahcare/Screens/AdminHome.dart';
import 'package:taibahcare/Screens/DoctorHome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const TaibahCare());
}

class TaibahCare extends StatelessWidget {
  const TaibahCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/LoginScreen': (context) => const LoginScreen(),
        '/RegisterScreen': (context) => const RegistrationScreen(),
        // '/Additional': (context) => const Additional(),
        '/homepage': (context) => const HomePage(),
        '/AdminHome': (context) => const AdminHome(),
        '/DoctorHome': (context) => const DoctorHome(),
        '/chat': (context) => Chat(),
      },
    );
  }
}
