import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insulin_dose_calculation/Controllers/insulinDosePageController.dart';
import 'package:insulin_dose_calculation/Controllers/mealDoseCalulationPageController.dart';
import 'package:insulin_dose_calculation/insulinDosePage.dart';
import 'package:insulin_dose_calculation/loginScreen.dart';
import 'package:insulin_dose_calculation/signupScreen.dart';
import 'package:insulin_dose_calculation/splashScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => insulinDosePageController(),
        ),
        ChangeNotifierProvider(
          create: (context) => mealDoseCalculationPageController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Insulin Dose Calculation App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255, 106, 164, 88),
          ),
          useMaterial3: false,
        ),
        // home: splashScreen(),
        home: user != null ? insulinDosePage() : splashScreen(),
        // initialRoute: '/splashscreen',
      ),
    );
  }
}
