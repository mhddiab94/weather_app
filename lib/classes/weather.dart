
class DaysWeather{
  String city;
  DateTime date;
  String weatherDescription;
  String tempMax;
  String tempMin;
  String icon;
  String temp;
  DaysWeather({this.icon,this.date,this.city,this.tempMax,this.tempMin,this.temp,this.weatherDescription});
}

class HoursWeather{
  String icon;
  String hour;
  String weatherDescription;
  double temp;
  HoursWeather({this.temp,this.hour,this.icon,this.weatherDescription});
}