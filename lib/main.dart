import 'package:weather_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/days_weather_model.dart';
import 'Models/route_generator.dart';

void main() {
  ///using the provider package for state management and data caching
  ///by using provider we don't need to fetch weather data from the internet every time we initialize the main screen because
  /// we read the data from list that we store it the first time we fetch the data from the internet
  runApp(ChangeNotifierProvider(create: (_)=>DaysWeatherModel(),child: MyApp(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: MainScreen.id,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

