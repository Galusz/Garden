import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden_app/cubit/app_cubit.dart';

import 'package:garden_app/data/services/db_service.dart';
import 'package:garden_app/data/models/plant.dart.';
import 'package:garden_app/data/repository.dart';

import 'package:garden_app/presentation/screens/edit_screen.dart';
import 'package:garden_app/presentation/screens/list_screen.dart';


class AppRouter {
  late Repository repository;
  late AppCubit appCubit;

  AppRouter() {
    repository = Repository(dbService: DBService());
    appCubit = AppCubit(repository: repository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: appCubit,
            child: const ListScreen(),
          ),
        );
      case "/form_plant":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: appCubit,
            child: const EditScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: appCubit,
            child: const ListScreen(),
          ),
        );
    }
  }
}
