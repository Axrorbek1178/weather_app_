import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/cubits/settings/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  static const routName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListTile(
        title: const Text("Temperature Unit"),
        subtitle: const Text('Celcius / Fahrenheit (default:Celcius)'),
        trailing: Switch.adaptive(
          value:
              context.watch<SettingsCubit>().state.tempUnits ==
                  TempUnits.celcius
              ? true
              : false,
          onChanged: (value) {
            context.read<SettingsCubit>().toggleTemperature();
          },
        ),
      ),
    );
  }
}
