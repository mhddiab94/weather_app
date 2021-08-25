import 'package:weather_app/classes/detailsScreenArgs.dart';
import 'package:weather_app/screens/details_screen.dart';
import 'package:weather_app/screens/main_screen.dart';
import 'package:flutter/material.dart';

///RouteGenerator handles the Navigation between the screens
class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_)=> MainScreen());
      case '/DetailsScreen':
        return MaterialPageRoute(builder: (_) {
          DetailsScreenArgs argument = args;
          return DetailsScreen(
              child: argument.child, list: argument.list
          );
         }
        );
      default:
        return _OnError();
    }
  }
  static Route<dynamic> _OnError(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        body: Center(
          child: Text('This Page not found'),
      )
      );
    });
  }
}