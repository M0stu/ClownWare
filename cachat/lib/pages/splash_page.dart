import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const SplashPage({
    required Key key,
    required this.onInitializationComplete,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SplashPageState();
  }
  class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
  super.initState();
  }
  Widget build(BuildContext context) {
  return MaterialApp(
  title: 'Cachat',
  theme: ThemeData(
  backgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
  scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0)
  ),
  );
  }}
