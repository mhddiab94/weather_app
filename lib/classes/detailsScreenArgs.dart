import 'package:weather_app/classes/weather.dart';
import 'package:weather_app/reusable_widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
///this class has been created to pass multiple arguments to DetailsScreen
class DetailsScreenArgs{
  List<HoursWeather> list;
  DetailsContainer child;
  DetailsScreenArgs({@required this.list,@required this.child});
}