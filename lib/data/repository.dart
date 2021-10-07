import 'package:garden_app/data/models/plant.dart';
import 'package:garden_app/data/models/plant_type.dart';
import 'package:garden_app/data/services/db_service.dart';

class Repository {
  final DBService dbService;

  Repository({required this.dbService});

  Future<List<Plant>> getPlants() async {
    return dbService.getPlants();
  }

  Future<List<PlantType>> getPlantTypes() async {
    return dbService.getPlantTypes();
  }

  Future<bool> addPlant(Plant plant) async {
    dbService.addPlant(plant);
    return true;
  }

  Future<bool> updatePlant(Plant plant) async {
    dbService.updatePlant(plant);
    return true;
  }

  Future<bool> deletePlant(Plant plant) async {
    return true;
  }
}
