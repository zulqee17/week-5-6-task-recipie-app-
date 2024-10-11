import 'package:flutter/material.dart';
import 'package:recipie_app/database/recipie_database_box.dart';
import 'package:recipie_app/screens/full_recipe_screen.dart';
import 'package:recipie_app/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  RecipieDatabaseBox.getHiveInitFunction();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
