import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/classes/weather.dart';
import 'package:weather_app/services/apicall.dart';

///using changeNotifier for provides change data notification
class DaysWeatherModel with ChangeNotifier{
  static List<DaysWeather> _days; ///to store forecast about five days after
  static List<dynamic> _allData; ///to store data from api response
  static List<HoursWeather> _hours; ///to store hourly data about specific day

  List<DaysWeather> get listOfDays{
    return _days;
  }
  List<HoursWeather> get listOfHours{
    return _hours;
  }
  void setListOfHours(String day){
    _hours = [];///to delete duplicaton
    ///using DataFormat from intl package to get day name in this format (mon)
    ///
    /// mapping the items of allData list to get the items thats Check the condition "DateFormat('EEE').format(DateTime.parse(element['dt_txt'])) == day" and store the data to list of HoursWeather
    _hours = _allData.where((element) => DateFormat('EEE').format(DateTime.parse(element['dt_txt'])) == day).toList().map((e) => HoursWeather(hour: DateTime.parse(e['dt_txt']).hour.toString(),icon: e['weather'][0]['icon'],temp: double.parse(e['main']['temp'].toString()),weatherDescription: e['weather'][0]['description'])).toList();
  }
  ///make the api call to get the data and store it in allData list and  store forecast data for five days after in days list
   void setDays()async{
     if(_days == null) {
       _days = [];
       var data = await ApiCall().getWeatherData();
       _allData = data["list"];
       _days.add(DaysWeather(
           date: DateTime.parse(_allData[0]['dt_txt']),icon: _allData[0]['weather'][0]['icon'],
           city: data['city']['name'],
           temp: _allData[0]['main']['temp'].toString(),
           tempMax: _allData[0]['main']['temp_max'].toString(),
           tempMin:_allData[0]['main']['temp_min'].toString(),
           weatherDescription: _allData[0]['weather'][0]['description'])
       );
        for(int i = 1; i<_allData.length;i++){
         if(_days.length != 0 && DateFormat('EEEE').format(
             DateTime.parse(_allData[i]['dt_txt'])) != DateFormat('EEEE').format(_days.last.date)
         ){
           DaysWeather _daysWeather = DaysWeather(
               date: DateTime.parse(_allData[i]['dt_txt']),
               icon: _allData[i]['weather'][0]['icon'],city: data['city']['name'],temp: _allData[i]['main']['temp'].toString(),
               tempMax:_allData[i]['main']['temp_max'].toString(),
               tempMin:_allData[i]['main']['temp_min'].toString(),
               weatherDescription: _allData[i]['weather'][0]['description']
           );
           _days.add(_daysWeather);
         }
       }
       notifyListeners(); ///to notify chenging data state
     }
   }
}

