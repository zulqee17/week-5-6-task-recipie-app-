
import 'package:hive_flutter/adapters.dart';
import 'package:recipie_app/database/recipie_database.dart';

class RecipieDatabaseBox {
  static final databaseRecipie="databaseRecipie";

  // function to get data
  static Box<RecipeDatabase> getRecipieData(){
    return Hive.box(databaseRecipie);
  }

  static getHiveInitFunction()async{
    await Hive.initFlutter();
    if(!Hive.isAdapterRegistered(0)){
      Hive.registerAdapter(RecipeDatabaseAdapter());
    }

    //   now we open Hive
    //   for DatabaseNoteKeeper
    if(!Hive.isBoxOpen(databaseRecipie)){
      await Hive.openBox<RecipeDatabase>(databaseRecipie);
    }
  }

  // this function return key in that bases we store ,insert update and del the data
  static String getNewKey(){
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}