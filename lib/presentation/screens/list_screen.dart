import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:garden_app/cubit/app_cubit.dart';
import 'package:garden_app/data/models/plant.dart';
import 'package:garden_app/data/models/plant_type.dart';

import '../../app_localizations.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  static int itemsOnPage = 10;
  int _currentListPage = 0;
  int _maxListPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.translate('garden')),
          actions: [
            InkWell(
              onTap: () {
                BlocProvider.of<AppCubit>(context).showAddPlantForm();
                Navigator.pushNamed(context, "/form_plant");
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add),
                    const SizedBox(width: 5),
                    Text(
                      AppLocalizations.of(context)!.translate('add_plant'),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom -
                kToolbarHeight,
            decoration: const BoxDecoration(
                image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.white70, BlendMode.lighten),
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.fill,
            )),
            child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
              if (state is AppInitial) {
                BlocProvider.of<AppCubit>(context).waitForDB();
              }

              if (state is PlantListLoaded) {
                var elements = state.plantList.length;
                List<Plant> plants;
                int rangeStart = _currentListPage * itemsOnPage;
                int rangeEnd = (_currentListPage + 1) * itemsOnPage;

                if (rangeStart >= elements) {
                  rangeStart = elements;
                }
                if (rangeEnd >= elements) {
                  rangeEnd = elements;
                }

                _maxListPage =
                    (state.plantList.length / itemsOnPage).ceil() - 1;

                plants =
                    state.plantList.getRange(rangeStart, rangeEnd).toList();

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 18),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),
                              TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _currentListPage = 0;
                                  });
                                  BlocProvider.of<AppCubit>(context)
                                      .getPlantList(searchString: value);
                                },
                                decoration: InputDecoration(
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    errorStyle: const TextStyle(
                                        color: Colors.redAccent),
                                    border: const OutlineInputBorder(),
                                    hintText: AppLocalizations.of(context)!
                                        .translate('plant_search'),
                                    labelText: AppLocalizations.of(context)!
                                        .translate('plant_search')),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 3,
                                child: plants.isNotEmpty
                                    ? ListView(
                                        children: plants
                                            .map((e) => _plantItem(e, context))
                                            .toList())
                                    : Align(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .translate('no_results'),
                                            style:
                                                const TextStyle(fontSize: 40)),
                                      ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  IconButton(
                                    splashRadius: 20,
                                    onPressed: () {
                                      if (_currentListPage > 0) {
                                        setState(() {
                                          _currentListPage--;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  ),
                                  plants.isNotEmpty
                                      ? Text("$_currentListPage/$_maxListPage")
                                      : const Text(" "),
                                  IconButton(
                                    splashRadius: 20,
                                    onPressed: () {
                                      if (plants.isNotEmpty &&
                                          _currentListPage < _maxListPage) {
                                        setState(() {
                                          _currentListPage++;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_forward),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return (Container());
              }
            }),
          ),
        ));
  }

  Widget _plantItem(Plant plant, context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AppCubit>(context).showEditPlantForm(plant);
        Navigator.pushNamed(context, "/form_plant");
      },
      child: Column(
        children: [
          const SizedBox(height: 2),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(100, 200, 220, 200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              const SizedBox(width: 10),
              Text(
                plant.name[0].toUpperCase() +
                    plant.name[plant.name.length - 1].toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color.fromARGB(100, 0, 150, 0),
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 10.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      )
                    ],
                    fontSize: 33),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                plant.date.toString(),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 8),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                plant.type.toString(),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 15),
                            Text(
                              plant.name,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 20, 70, 20),
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 2),
        ],
      ),
    );
  }
}
