import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:weather_app/logic/cubits/weather/weather_cubit.dart';
import 'package:weather_app/logic/repositories/weather_repository.dart';
import 'package:weather_app/logic/services/https/weather_api_services.dart';
import 'package:weather_app/presentation/screens/search_screen.dart';
import './presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiServices: WeatherApiServices(client: Client()),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) =>
                WeatherCubit(weatherRepository: ctx.read<WeatherRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const HomeScreen(),
          routes: {SearchScreen.routeName: (ctx) => SearchScreen()},
        ),
      ),
    );
  }
}
