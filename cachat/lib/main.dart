//import 'package:cachat/pages/settings.dart';

import 'package:cachat/pages/account_setting.dart';
import 'package:flutter/material.dart';

//Packages
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

//Serviecs
import './services/navigation_service.dart';

//Pages
import './pages/splash_page.dart';
import './pages/login_page.dart';
import './pages/home_page.dart';
import './pages/register_page.dart';
import './pages/user_agreement.dart';
//Providers
import './providers/authentication_provider.dart';
import 'pages/personal_info.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () async {
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
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (BuildContext _context) {
            return AuthenticationProvider();
          },
        )
      ],
      child: MaterialApp(
        title: "CaChat",
        theme: ThemeData(
          backgroundColor: const Color.fromRGBO(36, 36, 49, 1.0),
          scaffoldBackgroundColor: const Color.fromRGBO(36, 36, 49, 1.0),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
          ),
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (BuildContext _context) => LoginPage(),
          '/register': (BuildContext _context) => RegisterPage(),
          '/home': (BuildContext _context) => const HomePage(),
          '/userAG': (BuildContext _context) => UserAgreement(),
          '/accSetting': (BuildContext _context) => AccountSetting(),
          '/perInfo': (BuildContext _context) => PersonalInfo(),
        },
      ),
    );
  }
}
