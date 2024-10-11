import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'recipie_database.g.dart';

@HiveType(typeId:0)
class RecipeDatabase extends HiveObject{
  @HiveField(0)
  dynamic key;
  @HiveField(1)
  late String recipieName;
  @HiveField(2)
  late String recipieIngredients;
  @HiveField(3)
  late String recipie;
  @HiveField(4)
  late Uint8List image;
  @HiveField(5)
  bool isFavourite=false;
}