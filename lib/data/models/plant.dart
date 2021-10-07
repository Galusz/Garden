import 'dart:core';
import 'package:floor/floor.dart';

@entity
class Plant {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  String date;
  String type;

  Plant(this.id, this.name, this.date, this.type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Plant &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              date == other.date &&
              type == other.type;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ date.hashCode ^ type.hashCode;

  @override
  String toString() {
    return 'Plant{id: $id, name: $name, type: $type, date: $date}';
  }
}

