import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/cubits/weather/weather_cubit.dart';
import 'package:weather_app/presentation/screens/search_screen.dart';
import 'package:weather_app/presentation/widgets/city_part.dart';
import 'package:weather_app/presentation/widgets/temperature.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _getWeather('london');
  }

  void _getWeather(String city) {
    context.read<WeatherCubit>().getWeather(city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (ctx, state) async {
          if (state is WeatherError) {
            await showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.message),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
            if (state.message.toLowerCase().contains('not found')) {
              _getWeather('london');
            }
          }
        },
        builder: (ctx, state) {
          if (state is WeatherInitial) {
            return const Center(child: Text('Select a city'));
          }
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is WeatherLoaded) {
            final weather = state.weather;
            final mainWeather = weather.main.toLowerCase();
            String imagePath = '';
            if (mainWeather.contains('rain')) {
              imagePath = 'assets/rainy.jpg';
            } else if (mainWeather.contains('sun')) {
              imagePath = 'assets/sunny.jpg';
            } else if (mainWeather.contains('cloud')) {
              imagePath = 'assets/cloudy.jpeg';
            } else {
              imagePath = 'assets/night.jpg';
            }

            return Stack(
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
                Container(color: Colors.black.withAlpha(100)),
                Positioned(
                  right: 0,
                  top: 40,
                  child: IconButton(
                    onPressed: () async {
                      final _city = await Navigator.of(
                        context,
                      ).pushNamed(SearchScreen.routeName);
                      if (_city != null) {
                        _getWeather(_city as String);
                      }
                    },
                    icon: Icon(Icons.search, color: Colors.white),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CityPart(weather: weather),
                        Temperature(weather: weather),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
