import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:garden_app/data/services/database.dart';
import 'package:garden_app/data/models/plant.dart';
import 'package:garden_app/data/models/plant_type.dart';
import 'package:garden_app/data/models/plant_dao.dart';
import 'package:garden_app/data/models/plant_type_dao.dart';

class DBService {
  late final FlutterDatabase _database;
  late final PlantDao _plantDao;
  late final PlantTypeDao _plantTypeDao;

  Future<bool> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    _database = await $FloorFlutterDatabase.databaseBuilder('dbo.db').build();

    _plantDao = _database.plantDao;
    _plantTypeDao = _database.plantTypeDao;

    _plantTypeDao.getAllPlantTypes().then((value) {
      if (value.isEmpty) {
        _plantTypeDao.insertPlantType(PlantType(null, "Alpines"));
        _plantTypeDao.insertPlantType(PlantType(null, "Aquatic"));
        _plantTypeDao.insertPlantType(PlantType(null, "Bulbs"));
        _plantTypeDao.insertPlantType(PlantType(null, "Carnivorous"));
        _plantTypeDao.insertPlantType(PlantType(null, "Climbers"));
        _plantTypeDao.insertPlantType(PlantType(null, "Ferns"));
        _plantTypeDao.insertPlantType(PlantType(null, "Grasses"));
        _plantTypeDao.insertPlantType(PlantType(null, "Succulents"));
        _plantTypeDao.insertPlantType(PlantType(null, "Threes"));
      }
    });
    return true;
  }

  Future<List<PlantType>> getPlantTypes() async {
    try {
      return _plantTypeDao.getAllPlantTypes();
    } catch (e) {
      return [];
    }
  }

  Future<List<Plant>> getPlants() async {
    try {
      return _plantDao.getPlants();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addPlant(Plant plant) async {
    try {
      _plantDao.insertPlant(plant);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updatePlant(Plant plant) async {
    try {
      _plantDao.updatePlant(plant);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePlant(Plant plant) async {
    try {
      return true;
    } catch (e) {
      return false;
    }
  }
}
