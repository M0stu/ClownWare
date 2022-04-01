import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//packages
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

//services
import '../services/navigation_service.dart';
import '../services/media_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/database_service.dart';

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
    Future.delayed(const Duration(seconds: 1)).then(
      (_) {
        _setup().then(
          (_) => widget.onInitializationComplete(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cachat',
        theme: ThemeData(
          backgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
          scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
        ),
        home: Scaffold(
          body: Center(
            child: Container(
              height: 900,
              width: 600,
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
    GetIt.instance.registerSingleton<MediaService>(
      MediaService(),
    );
  }
}
