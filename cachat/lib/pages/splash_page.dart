//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:flutter/widgets.dart';
//Packages
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

//Pages
import '../services/navigation_service.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({
    required Key key,
    required this.onInitializationComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setup().then(
      (value) => widget.onInitializationComplete(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CaChat',
        theme: ThemeData(
          backgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
          scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
        ),
        home: Scaffold(
          body: Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('Assets/img/cat_icon-01.png'),
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _registerServices();
  }

  void _registerServices() {
    GetIt.instance.registerSingleton<NavigationService>(
      NavigationService(),
    );
  }
}
