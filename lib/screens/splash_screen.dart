import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recipie_app/screens/recipies_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),loadScreen);
  }

   loadScreen(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RecipiesScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Recipie App',style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.deepPurple),),),
    );
  }
}
