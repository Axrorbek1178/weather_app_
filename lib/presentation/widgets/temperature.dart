import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather.dart';

class Temperature extends StatelessWidget {
  const Temperature({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          '${weather.temperature.toStringAsFixed(0)} ℃',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 70,
            height: 0.25,
          ),
        ),
        Row(
          children: [
            Image.network(
              'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
              width: 60,
              height: 60,
            ),
            Text(
              weather.main,
              style: const TextStyle(color: Colors.white, fontSize: 30),
            ),
          ],
        ),
      ],
    );
  }
}
