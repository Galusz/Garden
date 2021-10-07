import 'dart:async';
import 'package:garden_app/data/models/plant.dart';
import 'package:garden_app/data/models/plant_type.dart';
import 'package:garden_app/data/models/plant_dao.dart';
import 'package:garden_app/data/models/plant_type_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Plant, PlantType])
abstract class FlutterDatabase extends FloorDatabase {
  PlantDao get plantDao;
  PlantTypeDao get plantTypeDao;
}
