import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/helpers/extensions/string_extension.dart';

class CityPart extends StatelessWidget {
  const CityPart({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          weather.city.capitalizeString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          weather.desc,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
