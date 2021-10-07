import 'package:garden_app/presentation/screens/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden_app/cubit/app_cubit.dart';
import '../../app_localizations.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AppCubit>(context).getPlantList();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
              if (state is EditPlantForm) {
                return Text(
                    AppLocalizations.of(context)!.translate('edit_plant'));
              } else {
                return Text(
                    AppLocalizations.of(context)!.translate('add_plant'));
              }
            }),
          ),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom -
                  kToolbarHeight,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.white70, BlendMode.lighten),
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.fill,
              )),
              child: Column(
                children: [
                  BlocBuilder<AppCubit, AppState>(
                    builder: (context, state) {
                      if (state is EditPlantForm) {
                        return EditForm(
                            state: state,
                            plant: state.plant,
                            plantTypeList: state.plantTypeList);
                      }
                      if (state is AddPlantForm) {
                        return EditForm(
                            state: state,
                            plant: null,
                            plantTypeList: state.plantTypeList);
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          )),
    );
  }
}
