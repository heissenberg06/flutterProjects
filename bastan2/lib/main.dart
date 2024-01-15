import 'package:bastan2/bindings.dart/news_bindings.dart';
import 'package:bastan2/pages/favourite_page.dart';
import 'package:bastan2/pages/forgotpass_page.dart';
import 'package:bastan2/pages/home_page.dart';
import 'package:bastan2/pages/login_page.dart';
import 'package:bastan2/pages/phone_deneme.dart';
import 'package:bastan2/pages/phone_verif_page.dart';
import 'package:bastan2/pages/register_page.dart';
import 'package:bastan2/pages/settings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //it is necessary for using firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          
          defaultTransition: Transition.upToDown,
          getPages: [
            GetPage(name: '/', page: (() => const MyApp())),
            GetPage(name: '/login', page: (() => LoginPage())),
            GetPage(name: '/register', page: (() => RegisterPage())),
            GetPage(
                name: '/home', page: () => HomePage(), binding: NewsBindings()),
            GetPage(name: '/settings', page: () => SettingsPage()),
            GetPage(name: '/forgot', page: () => ForgotPasswordPage()),
            GetPage(name: '/favourite', page: () => FavouritesPage())
          ],

          routes: {
            '/login' : (context) => LoginPage(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Sizer',
          theme: ThemeData.light(),
          home: LoginPage(),
        );
      },
    );
  }
}