import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipie_app/database/recipie_database_box.dart';
import 'package:recipie_app/screens/add_recipie_screen.dart';
import 'package:recipie_app/screens/full_recipe_screen.dart';
import 'package:recipie_app/utils/utils.dart';

import '../database/recipie_database.dart';

class RecipiesScreen extends StatefulWidget {
  const RecipiesScreen({Key? key}) : super(key: key);

  @override
  State<RecipiesScreen> createState() => _RecipiesScreenState();
}

class _RecipiesScreenState extends State<RecipiesScreen> {
  Box recipeBox = RecipieDatabaseBox.getRecipieData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Recipies'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
                child: ValueListenableBuilder<Box<RecipeDatabase>>(
              valueListenable: RecipieDatabaseBox.getRecipieData().listenable(),
              builder: (context, box, _) {
                List<RecipeDatabase> recipeList =
                    box.values.toList().cast<RecipeDatabase>();
                if (box.isEmpty) {
                  return const Center(
                      child: Text(
                    'no recipe added yet...',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ));
                } else {
                  return GridView.builder(
                      itemCount: recipeList.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              mainAxisExtent: 250,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (context, animation,
                                        secoundryAnimation) =>
                                    FullRecipeScreen(
                                        recipeName: recipeList[index]
                                            .recipieName
                                            .toString(),
                                        recipeIngredients: recipeList[index]
                                            .recipieIngredients
                                            .toString(),
                                        recipe: recipeList[index]
                                            .recipie
                                            .toString(),
                                        image: recipeList[index].image),
                                transitionsBuilder: (context, animation,
                                    secoundryAnimation, child) {
                                  const begin =
                                      Offset(1.0, 0.0); // Start from the right
                                  const end =
                                      Offset.zero; // Slide to the center
                                  const curve = Curves.ease;


                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Card(
                              color: Colors.deepPurple.shade100,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 7, right: 7),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              recipeList[index].isFavourite =
                                                  !recipeList[index]
                                                      .isFavourite;
                                              // .save() upadate hive box
                                              recipeList[index].save();
                                            });
                                          },
                                          child: Icon(
                                            recipeList[index].isFavourite
                                                ? Icons.favorite
                                                : Icons
                                                    .favorite_border_outlined,
                                            color: recipeList[index].isFavourite
                                                ? Colors.deepPurple
                                                : Colors.deepPurple,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showMyDialog(recipeList[index].key);
                                          },
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: Colors.deepPurple,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  CircleAvatar(
                                    radius: 80,
                                    backgroundImage:
                                        MemoryImage(recipeList[index].image),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    recipeList[index].recipieName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        );
                      });
                }
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation,
                  secoundryAnimation) =>
                  AddRecipieScreen(),
              transitionsBuilder: (context, animation,
                  secoundryAnimation, child) {
                const begin =
                Offset(1.0, 0.0); // Start from the right
                const end =
                    Offset.zero; // Slide to the center
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
  void showMyDialog(String keyId) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete',style: TextStyle(fontWeight: FontWeight.bold),),
            content: Text('Are you sure to delete this recipe?...',style: TextStyle(fontSize: 20),),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    recipeBox
                        .delete(keyId).then((onValue){
                          Utils.toastMessage('deleted successfully', Colors.green);
                    }).onError((e,stackTrace){
                      Utils.toastMessage(e.toString(), Colors.red);
                    });

                  },
                  child: const Text('Yes')),
            ],
          );
        });
  }
}
