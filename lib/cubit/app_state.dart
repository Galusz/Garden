part of 'app_cubit.dart';

abstract class AppState {}

class AppInitial extends AppState {}

class PlantListLoaded extends AppState {
  final List<Plant> plantList;

  PlantListLoaded({required this.plantList});
}

class PictureFavListLoaded extends AppState {}

class AddPlant extends AppState {}

class EditPlantForm extends AppState {
  final Plant plant;
  final List<PlantType> plantTypeList;

  EditPlantForm({required this.plantTypeList, required this.plant});
}

class AddPlantForm extends AppState {
  final List<PlantType> plantTypeList;

  AddPlantForm({required this.plantTypeList});
}
