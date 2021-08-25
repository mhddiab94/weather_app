import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Models/days_weather_model.dart';
import 'package:weather_app/classes/adaptivetextsize.dart';
import 'package:weather_app/classes/detailsScreenArgs.dart';
import 'package:weather_app/classes/weather.dart';
import 'package:weather_app/reusable_widgets/widgets.dart';
import 'package:weather_app/screens/details_screen.dart';
import 'package:weather_app/values.dart';

class MainScreen extends StatefulWidget {
  static String id = '/';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<DaysWeather> _daysList;

  bool isFetchingDone = false;

  ///to track the data
  bool isConnect = true;

  ///to track the status of internet connection
  Future<Map<String, dynamic>> getData() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnect = true;
        await Provider.of<DaysWeatherModel>(context, listen: false).setDays();
        if (Provider.of<DaysWeatherModel>(context, listen: false)
                .listOfDays
                .length ==
            0) {
          isFetchingDone = false;
        } else {
          _daysList =
              Provider.of<DaysWeatherModel>(context, listen: false).listOfDays;
          isFetchingDone = true;
        }
      }
    } on SocketException catch (_) {
      setState(() {
        isConnect = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isConnect == true) {
      List<DaysWeather> data = Provider.of<DaysWeatherModel>(context).listOfDays;
      return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
        return !isFetchingDone?Center(
                child: Container(
                  height: constraints.maxHeight * 0.1,
                  width: constraints.maxHeight * 0.1,
                  child: CircularProgressIndicator(
                    backgroundColor: kFontColor,
                  ),
                ),
              )
            : constraints.maxWidth < 450
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: DetailsContainer(
                          city: data[0].city,
                          date: data[0].date,
                          description: data[0].weatherDescription,
                          iconImage: data[0].icon,
                          temp: data[0].temp,
                          tempMax: double.tryParse(data[0].tempMax)
                              .toStringAsFixed(0),
                          tempMin: double.tryParse(data[0].tempMin)
                              .toStringAsFixed(0),
                          maxHeight: constraints.maxHeight,
                          maxWidth: constraints.maxWidth,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: kBackgroundColor,
                          child: Column(children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom: constraints.maxWidth > 450
                                        ? constraints.maxWidth * 0.05
                                        : constraints.maxWidth * 0.1),
                                child: Text(
                                  '5-day Forecast',
                                  style: TextStyle(
                                      fontSize: 30, color: kFontColor),
                                )),
                            Expanded(
                              child: isFetchingDone
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _daysList.length,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                left:
                                                    constraints.maxWidth * 0.1),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Provider.of<DaysWeatherModel>(
                                                          context,
                                                          listen: false)
                                                      .setListOfHours(
                                                          DateFormat('EEE')
                                                              .format(_daysList[
                                                                      index]
                                                                  .date));
                                                  List<
                                                      HoursWeather> list = Provider
                                                          .of<DaysWeatherModel>(
                                                              context,
                                                              listen: false)
                                                      .listOfHours;
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          DetailsScreen.id,
                                                          arguments:
                                                              DetailsScreenArgs(
                                                            list: list,
                                                            child:
                                                                DetailsContainer(
                                                              maxWidth:
                                                                  constraints
                                                                      .maxWidth,
                                                              maxHeight:
                                                                  constraints
                                                                      .maxHeight,
                                                              temp: _daysList[
                                                                      index]
                                                                  .temp,
                                                              description:
                                                                  _daysList[
                                                                          index]
                                                                      .weatherDescription,
                                                              city: _daysList[
                                                                      index]
                                                                  .city,
                                                              date: _daysList[
                                                                      index]
                                                                  .date,
                                                              tempMax: double
                                                                      .tryParse(
                                                                          data[0]
                                                                              .tempMax)
                                                                  .toStringAsFixed(
                                                                      0),
                                                              tempMin: double
                                                                      .tryParse(
                                                                          data[0]
                                                                              .tempMin)
                                                                  .toStringAsFixed(
                                                                      0),
                                                              iconImage:
                                                                  _daysList[
                                                                          index]
                                                                      .icon,
                                                            ),
                                                          ));
                                                },
                                                child: DayWeather(
                                                  maxHeight:
                                                      constraints.maxHeight,
                                                  maxWidth:
                                                      constraints.maxWidth,
                                                  temp:
                                                      "${double.tryParse(_daysList[index].tempMax).toStringAsFixed(0)} / ${double.tryParse(_daysList[index].tempMax).toStringAsFixed(0)}",
                                                  date: DateFormat('d/M')
                                                      .format(_daysList[index]
                                                          .date),
                                                  icon: _daysList[index].icon,
                                                  day: DateFormat('EEE').format(
                                                      _daysList[index].date),
                                                  weatherDescription:
                                                      _daysList[index]
                                                          .weatherDescription,
                                                )),
                                          );
                                        } else {
                                          return GestureDetector(
                                              onTap: () {
                                                Provider.of<DaysWeatherModel>(
                                                        context,
                                                        listen: false)
                                                    .setListOfHours(
                                                        DateFormat('EEE')
                                                            .format(
                                                                _daysList[index]
                                                                    .date));
                                                List<
                                                    HoursWeather> list = Provider
                                                        .of<DaysWeatherModel>(
                                                            context,
                                                            listen: false)
                                                    .listOfHours;
                                                //Navigator.push(context, MaterialPageRoute(builder: (_){return DetailsScreen(list: list,child: DetailsContainer(temp: _daysList[index].temp,description: _daysList[index].weatherDescription,city: _daysList[index].city,date: _daysList[index].date,tempMax: double.tryParse(data[0].tempMax).toStringAsFixed(0), tempMin: double.tryParse(data[0].tempMin).toStringAsFixed(0),iconImage: _daysList[index].icon,),);}));
                                                Navigator.of(context).pushNamed(
                                                    DetailsScreen.id,
                                                    arguments:
                                                        DetailsScreenArgs(
                                                      list: list,
                                                      child: DetailsContainer(
                                                        maxWidth: constraints
                                                            .maxWidth,
                                                        maxHeight: constraints
                                                            .maxHeight,
                                                        temp: _daysList[index]
                                                            .temp,
                                                        description: _daysList[
                                                                index]
                                                            .weatherDescription,
                                                        city: _daysList[index]
                                                            .city,
                                                        date: _daysList[index]
                                                            .date,
                                                        tempMax: double
                                                                .tryParse(data[
                                                                        0]
                                                                    .tempMax)
                                                            .toStringAsFixed(0),
                                                        tempMin: double
                                                                .tryParse(data[
                                                                        0]
                                                                    .tempMin)
                                                            .toStringAsFixed(0),
                                                        iconImage:
                                                            _daysList[index]
                                                                .icon,
                                                      ),
                                                    ));
                                              },
                                              child: DayWeather(
                                                maxHeight:
                                                    constraints.maxHeight,
                                                maxWidth: constraints.maxWidth,
                                                temp:
                                                    "${double.tryParse(_daysList[index].tempMax).toStringAsFixed(0)} / ${double.tryParse(_daysList[index].tempMax).toStringAsFixed(0)}",
                                                date: DateFormat('d/M').format(
                                                    _daysList[index].date),
                                                icon: _daysList[index].icon,
                                                day: DateFormat('EEE').format(
                                                    _daysList[index].date),
                                                weatherDescription:
                                                    _daysList[index]
                                                        .weatherDescription,
                                              ));
                                        }
                                      })
                                  : Container(),
                            ),
                            Container(
                              height: constraints.maxHeight * 0.15,
                            )
                          ]),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: DetailsContainer(
                          city: data[0].city,
                          date: data[0].date,
                          description: data[0].weatherDescription,
                          iconImage: data[0].icon,
                          temp: data[0].temp,
                          tempMax: double.tryParse(data[0].tempMax)
                              .toStringAsFixed(0),
                          tempMin: double.tryParse(data[0].tempMin)
                              .toStringAsFixed(0),
                          maxHeight: constraints.maxHeight,
                          maxWidth: constraints.maxWidth,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: kBackgroundColor,
                          padding: EdgeInsets.symmetric(
                              vertical: constraints.maxHeight * 0.1),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        bottom: constraints.maxWidth > 450
                                            ? constraints.maxWidth * 0.05
                                            : constraints.maxWidth * 0.1),
                                    child: Text(
                                      '5-day Forecast',
                                      style: TextStyle(
                                          fontSize: 30, color: kFontColor),
                                    )),
                                Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _daysList.length,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                left:
                                                    constraints.maxWidth * 0.1),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Provider.of<DaysWeatherModel>(
                                                          context,
                                                          listen: false)
                                                      .setListOfHours(
                                                          DateFormat('EEE')
                                                              .format(_daysList[
                                                                      index]
                                                                  .date));
                                                  List<
                                                      HoursWeather> list = Provider
                                                          .of<DaysWeatherModel>(
                                                              context,
                                                              listen: false)
                                                      .listOfHours;
                                                  //Navigator.push(context, MaterialPageRoute(builder: (_){return DetailsScreen(list: list,child: DetailsContainer(temp: _daysList[index].temp,description: _daysList[index].weatherDescription,city: _daysList[index].city,date: _daysList[index].date,tempMax: double.tryParse(data[0].tempMax).toStringAsFixed(0), tempMin: double.tryParse(data[0].tempMin).toStringAsFixed(0),iconImage: _daysList[index].icon,),);}));
                                                  Navigator.of(context)
                                                      .pushNamed(
                                                          DetailsScreen.id,
                                                          arguments:
                                                              DetailsScreenArgs(
                                                            list: list,
                                                            child:
                                                                DetailsContainer(
                                                              maxWidth:
                                                                  constraints
                                                                      .maxWidth,
                                                              maxHeight:
                                                                  constraints
                                                                      .maxHeight,
                                                              temp: _daysList[
                                                                      index]
                                                                  .temp,
                                                              description:
                                                                  _daysList[
                                                                          index]
                                                                      .weatherDescription,
                                                              city: _daysList[
                                                                      index]
                                                                  .city,
                                                              date: _daysList[
                                                                      index]
                                                                  .date,
                                                              tempMax: double
                                                                      .tryParse(
                                                                          data[0]
                                                                              .tempMax)
                                                                  .toStringAsFixed(
                                                                      0),
                                                              tempMin: double
                                                                      .tryParse(
                                                                          data[0]
                                                                              .tempMin)
                                                                  .toStringAsFixed(
                                                                      0),
                                                              iconImage:
                                                                  _daysList[
                                                                          index]
                                                                      .icon,
                                                            ),
                                                          ));
                                                },
                                                child: DayWeather(
                                                  maxHeight:
                                                      constraints.maxHeight,
                                                  maxWidth:
                                                      constraints.maxWidth,
                                                  temp:
                                                      "${double.tryParse(_daysList[index].tempMax).toStringAsFixed(0)} / ${double.tryParse(_daysList[index].tempMax).toStringAsFixed(0)}",
                                                  date: DateFormat('d/M')
                                                      .format(_daysList[index]
                                                          .date),
                                                  icon: _daysList[index].icon,
                                                  day: DateFormat('EEE').format(
                                                      _daysList[index].date),
                                                  weatherDescription:
                                                      _daysList[index]
                                                          .weatherDescription,
                                                )),
                                          );
                                        } else {
                                          return GestureDetector(
                                              onTap: () {
                                                Provider.of<DaysWeatherModel>(
                                                        context,
                                                        listen: false)
                                                    .setListOfHours(
                                                        DateFormat('EEE')
                                                            .format(
                                                                _daysList[index]
                                                                    .date));
                                                List<
                                                    HoursWeather> list = Provider
                                                        .of<DaysWeatherModel>(
                                                            context,
                                                            listen: false)
                                                    .listOfHours;
                                                //Navigator.push(context, MaterialPageRoute(builder: (_){return DetailsScreen(list: list,child: DetailsContainer(temp: _daysList[index].temp,description: _daysList[index].weatherDescription,city: _daysList[index].city,date: _daysList[index].date,tempMax: double.tryParse(data[0].tempMax).toStringAsFixed(0), tempMin: double.tryParse(data[0].tempMin).toStringAsFixed(0),iconImage: _daysList[index].icon,),);}));
                                                Navigator.of(context).pushNamed(
                                                    DetailsScreen.id,
                                                    arguments:
                                                        DetailsScreenArgs(
                                                      list: list,
                                                      child: DetailsContainer(
                                                        maxWidth: constraints
                                                            .maxWidth,
                                                        maxHeight: constraints
                                                            .maxHeight,
                                                        temp: _daysList[index]
                                                            .temp,
                                                        description: _daysList[
                                                                index]
                                                            .weatherDescription,
                                                        city: _daysList[index]
                                                            .city,
                                                        date: _daysList[index]
                                                            .date,
                                                        tempMax: double
                                                                .tryParse(data[
                                                                        0]
                                                                    .tempMax)
                                                            .toStringAsFixed(0),
                                                        tempMin: double
                                                                .tryParse(data[
                                                                        0]
                                                                    .tempMin)
                                                            .toStringAsFixed(0),
                                                        iconImage:
                                                            _daysList[index]
                                                                .icon,
                                                      ),
                                                    ));
                                              },
                                              child: DayWeather(
                                                maxHeight:
                                                    constraints.maxHeight,
                                                maxWidth: constraints.maxWidth,
                                                temp:
                                                    "${double.tryParse(_daysList[index].tempMax).toStringAsFixed(0)} / ${double.tryParse(_daysList[index].tempMax).toStringAsFixed(0)}",
                                                date: DateFormat('d/M').format(
                                                    _daysList[index].date),
                                                icon: _daysList[index].icon,
                                                day: DateFormat('EEE').format(
                                                    _daysList[index].date),
                                                weatherDescription:
                                                    _daysList[index]
                                                        .weatherDescription,
                                              ));
                                        }
                                      }),
                                ),
                              ]),
                        ),
                      ),
                    ],
                  );
      }));
    } else {
      return Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('check the internet',
                style: TextStyle(
                    fontSize:
                        AdaptiveTextSize().getAdaptiveTextSize(context, 20))),
            ElevatedButton(
              onPressed: () {
                getData();
              },
              child: Text('Retry'),
            ),
          ],
        )),
      );
    }
  }
}
