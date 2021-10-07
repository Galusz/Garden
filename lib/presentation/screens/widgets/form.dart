import 'package:garden_app/data/models/plant.dart';
import 'package:garden_app/data/models/plant_type.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garden_app/cubit/app_cubit.dart';
import '../../../app_localizations.dart';

class EditForm extends StatefulWidget {
  final Plant? plant;
  final List<PlantType> plantTypeList;
  final AppState state;

  const EditForm(
      {Key? key,
      required this.state,
      required this.plant,
      required this.plantTypeList})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  DateTime? _dateSelected;
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String? _currentSelectedType;

  @override
  Widget build(BuildContext context) {
    if (widget.plant != null &&
        _dateController.text.isEmpty &&
        _nameController.text.isEmpty &&
        _currentSelectedType == null) {
      _dateController.text = widget.plant!.date;
      _nameController.text = widget.plant!.name;
      _currentSelectedType = widget.plant!.type;
    }
    ;

    var _types = widget.plantTypeList.map((v) => v.type);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
        key: _formKey,
        child: Card(
          elevation: 10,
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .translate('enter_value');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.grey),
                      errorStyle: const TextStyle(color: Colors.redAccent),
                      border: const OutlineInputBorder(),
                      hintText:
                          AppLocalizations.of(context)!.translate('plant_name'),
                      labelText: AppLocalizations.of(context)!
                          .translate('plant_name')),
                  controller: _nameController,
                ),
                const SizedBox(height: 20),
                FormField<String>(
                  validator: (value) {
                    if (_currentSelectedType == null) {
                      if (value == null || value.isEmpty) {
                        return AppLocalizations.of(context)!
                            .translate('enter_value');
                      }
                    }
                    return null;
                  },
                  builder: (FormFieldState<String> fieldState) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          errorText: fieldState.errorText,
                          labelText: AppLocalizations.of(context)!
                              .translate('plant_type'),
                          hintText: AppLocalizations.of(context)!
                              .translate('plant_type'),
                          labelStyle: const TextStyle(color: Colors.grey),
                          errorStyle: const TextStyle(color: Colors.redAccent),
                          border: OutlineInputBorder()),
                      isEmpty: _currentSelectedType == null,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _currentSelectedType,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              _currentSelectedType = newValue;
                              fieldState.didChange(newValue);
                            });
                          },
                          items: _types.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!
                          .translate('enter_value');
                    }
                    return null;
                  },
                  onTap: () => pickDate(context),
                  readOnly: true,
                  decoration: InputDecoration(
                      labelStyle: const TextStyle(color: Colors.grey),
                      errorStyle: const TextStyle(color: Colors.redAccent),
                      border: const OutlineInputBorder(),
                      hintText:
                          AppLocalizations.of(context)!.translate('plant_date'),
                      labelText: AppLocalizations.of(context)!
                          .translate('plant_date')),
                  controller: _dateController,
                ),
                const SizedBox(height: 20),
                if (widget.state is AddPlantForm)
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<AppCubit>(context).addPlant(
                            _nameController.text,
                            _dateController.text,
                            _currentSelectedType!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                      .translate('plant_added') +
                                  " (" +
                                  _nameController.text +
                                  ")")),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child:
                        Text(AppLocalizations.of(context)!.translate('submit')),
                  ),
                if (widget.state is EditPlantForm)
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<AppCubit>(context).updatePlant(
                            widget.plant!.id!,
                            _nameController.text,
                            _dateController.text,
                            _currentSelectedType!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                      .translate('plant_edited') +
                                  " (" +
                                  _nameController.text +
                                  ")")),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child:
                        Text(AppLocalizations.of(context)!.translate('submit')),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: _dateSelected ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    setState(() {
      _dateSelected = newDate;
      _dateController.text =
          DateFormat('yyyy-MM-dd').format(_dateSelected ?? DateTime.now());
    });
  }
}
