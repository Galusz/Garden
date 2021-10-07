import 'package:garden_app/data/models/plant_type.dart';
import 'package:floor/floor.dart';

@dao
abstract class PlantTypeDao {
  @Query('SELECT * FROM PlantType')
  Future<List<PlantType>> getAllPlantTypes();

  @insert
  Future<void> insertPlantType(PlantType plantType);
}
