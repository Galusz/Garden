import 'package:bloc/bloc.dart';
import 'package:garden_app/data/models/plant_type.dart';
import 'package:meta/meta.dart';
import 'package:garden_app/data/models/plant.dart';
import 'package:garden_app/data/repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final Repository repository;

  AppCubit({required this.repository}) : super(AppInitial());

  void waitForDB() {
    repository.dbService.initDB().then((value) => getPlantList());
  }

  void getPlantList({String? searchString}) {
    repository.getPlants().then((value) {
      List<Plant> newList;
      if (searchString != null) {
        newList = value
            .where((e) =>
                e.name.toLowerCase().contains(searchString.toLowerCase()))
            .toList();
      } else {
        newList = value;
      }
      emit(PlantListLoaded(plantList: newList));
    });
  }

  void showEditPlantForm(Plant plant) {
    repository.getPlantTypes().then((value) {
      emit(EditPlantForm(plant: plant, plantTypeList: value));
    });
  }

  void showAddPlantForm() {
    repository.getPlantTypes().then((value) {
      emit(AddPlantForm(plantTypeList: value));
    });
  }

  void addPlant(String name, String date, String type) {
    repository.addPlant(Plant(null, name, date, type));
    getPlantList();
  }

  void updatePlant(int id, String name, String date, String type) {
    repository.updatePlant(Plant(id, name, date, type));
    getPlantList();
  }

  void deletePlant() {
    void deletePlant(Plant plant) {
      repository.addPlant(plant);
      getPlantList();
    }
  }
}
