import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

//Services
import './services/navigation_service.dart';

//Pages
import './pages/splash_page.dart';

//ty Omar for this Const <3
const color = Color.fromRGBO(36, 35, 49, 1.0);
//Gurls please use this const over all the code <3
void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(
          MainApp(),
        );
      },
    ),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CaChat',
      theme: ThemeData(
        backgroundColor: color,
        scaffoldBackgroundColor: color,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: color,
        ),
      ),
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
