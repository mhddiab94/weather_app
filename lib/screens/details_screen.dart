import 'package:weather_app/classes/weather.dart';
import 'package:weather_app/reusable_widgets/widgets.dart';
import 'package:weather_app/values.dart';
import 'package:flutter/material.dart';
class DetailsScreen extends StatelessWidget {
  static String id = '/DetailsScreen';
  List<HoursWeather> list ;
  DetailsContainer child;
  DetailsScreen({this.list,this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context,constraints) {
          List<Details> _listOfDetails = list.map((e) => Details(maxWidth:constraints.maxWidth,maxHeight: constraints.maxHeight ,description: e.weatherDescription,icon: e.icon,temp: e.temp.toString(),time: "${e.hour}:00",)).toList();
          _listOfDetails[0].time = 'Now';
         return Container(
              color: kBackgroundColor,
              child: constraints.maxWidth < 450 ? Column(
                children: [
                  Expanded(flex: 5, child: child),
                  Expanded(flex: 5, child: SingleChildScrollView(
                    child: Column(
                      children: _listOfDetails,
                    ),
                  ),)
                ],
              ) : Row(
                children: [
                  Expanded(flex: 5, child: child),
                  Expanded(flex: 5, child: Padding(
                    padding: EdgeInsets.only(top: constraints.maxHeight*0.1),
                    child: SingleChildScrollView(
                      child: Column(
                        children: _listOfDetails,
                      ),
                    ),
                  ),)
                ],
              )
          );
        }
      ),
    );
  }
}
