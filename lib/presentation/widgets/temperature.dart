import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/logic/cubits/settings/settings_cubit.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key, required this.weather});

  final Weather weather;

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  String _showTemperature(double temp) {
    final tempUnits = context.watch<SettingsCubit>().state.tempUnits;
    if (tempUnits == TempUnits.fahrenheit) {
      return '${(temp * 9 / 5 + 32).toStringAsFixed(0)}℉';
    }
    return '${temp.toStringAsFixed(0)}℃';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          _showTemperature(widget.weather.temperature),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 70,
            height: 0.25,
          ),
        ),
        Row(
          children: [
            Image.network(
              'https://openweathermap.org/img/wn/${widget.weather.icon}@2x.png',
              width: 60,
              height: 60,
            ),
            Text(
              widget.weather.main,
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
          ],
        ),
      ],
    );
  }
}
