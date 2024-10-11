import 'dart:typed_data';

import 'package:flutter/material.dart';

class FullRecipeScreen extends StatefulWidget {
  String recipeName;
  String recipeIngredients;
  String recipe;
  Uint8List image;
  FullRecipeScreen({Key? key,required this.recipeName,required this.recipeIngredients,required this.recipe, required this.image}) : super(key: key);

  @override
  State<FullRecipeScreen> createState() => _FullRecipeScreenState();
}

class _FullRecipeScreenState extends State<FullRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Full Recipe'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 130,
                  backgroundImage: MemoryImage(widget.image),
                ),
              ),
              SizedBox(height: 10,),
              Text('Recipe Name',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              Text(widget.recipeName,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
          
              SizedBox(height: 10,),
              Text('Recipe Ingredients',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              Text(widget.recipeIngredients,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
          
              SizedBox(height: 10,),
              Text('Recipe',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              Text('Follow the below Steps:',textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
              Text(widget.recipe,textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),),

          
          
            ],
          ),
        ),
      ),
    );
  }
}
