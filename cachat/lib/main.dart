import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
//Pages
import './pages/splash_page.dart';

//services
import './services/navigation_service.dart';

void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {},
    ),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "CaChat",
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(36, 36, 49, 1.0),
        scaffoldBackgroundColor: Color.fromRGBO(36, 36, 49, 1.0),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
        ),
      ),
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
