import 'dart:core';
import 'package:floor/floor.dart';

@entity
class PlantType {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String type;

  PlantType(this.id, this.type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PlantType &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              type == other.type;

  @override
  int get hashCode => id.hashCode ^ type.hashCode;

  @override
  String toString() {
    return 'PlantType{id: $id, type: $type}';
  }
}