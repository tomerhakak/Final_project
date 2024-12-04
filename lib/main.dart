import 'package:CheckIt/Controllers/BenefitController.dart';
import 'package:CheckIt/Controllers/UserController.dart';
import 'package:CheckIt/Screens/BenefitScreen.dart';
import 'package:CheckIt/Screens/CardsScreen.dart';

import 'package:CheckIt/Screens/HomeScreen.dart';
import 'package:CheckIt/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:CheckIt/Screans/Login.dart';
import 'package:CheckIt/Screens/BenefitsScreen.dart';
import 'package:CheckIt/Screens/LoginScreen.dart';
import 'package:CheckIt/Screens/RegisterScreen.dart';
import 'package:CheckIt/Screens/SplashScreen.dart';

import 'package:get/get.dart';

import 'Screens/Contact.dart';
import 'Screens/ProfileScreen.dart';
import 'Screens/Reporting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final UserController userController = Get.put(UserController());
  final BenefitController benefitController = Get.put(BenefitController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: 'Inter',
            scaffoldBackgroundColor: const Color(0xff273B69)),
        initialRoute: '/login',
        getPages: [
          GetPage(name: '/home', page: () => HomeScreen()),
          GetPage(name: '/reporting', page: () => Reporting()),
          GetPage(name: '/profile', page: () => const ProfileScreen()),
          GetPage(name: '/', page: () => const CardScreen()),
          GetPage(name: '/contact', page: () => Contact()),
          GetPage(name: '/benefits', page: () => const BenefitsScreen()),
          GetPage(name: '/benefit', page: () => const BenefitScreen()),
          GetPage(name: '/login', page: () => const LoginScreen()),
          GetPage(name: '/splash', page: () => const SplashScreen()),
          GetPage(name: '/register', page: () => const RegisterScreen()),
        ]);
  }
}
