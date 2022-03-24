import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
//Pages
import './pages/splash_page.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {},
    ),
  );
}

/*use_frameworks! #add here
  
  copied_flutter_dir = File.join(__dir__, 'Flutter')
  copied_framework_path = File.join(copied_flutter_dir, 'Flutter.framework')
  copied_podspec_path = File.join(copied_flutter_dir, 'Flutter.podspec')*/
