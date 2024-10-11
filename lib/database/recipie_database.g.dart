// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipie_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeDatabaseAdapter extends TypeAdapter<RecipeDatabase> {
  @override
  final int typeId = 0;

  @override
  RecipeDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeDatabase()
      ..key = fields[0] as dynamic
      ..recipieName = fields[1] as String
      ..recipieIngredients = fields[2] as String
      ..recipie = fields[3] as String
      ..image = fields[4] as Uint8List
      ..isFavourite = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, RecipeDatabase obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.recipieName)
      ..writeByte(2)
      ..write(obj.recipieIngredients)
      ..writeByte(3)
      ..write(obj.recipie)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
