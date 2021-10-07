import 'package:garden_app/data/models/plant.dart';
import 'package:floor/floor.dart';

@dao
abstract class PlantDao {
  @Query('SELECT * FROM Plant')
  Future<List<Plant>> getPlants();

  @insert
  Future<void> insertPlant(Plant plant);

  @update
  Future<void> updatePlant(Plant plant);

  @delete
  Future<void> deletePlant(Plant plant);
}
