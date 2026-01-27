import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/core/themes/colors.dart';
import 'package:recipe_app/firebase_options.dart';
import 'package:recipe_app/presentations/pages/app_main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: kBackgroundColor),
      debugShowCheckedModeBanner: false,
      home: AppMainPage(),
    );
  }
}
