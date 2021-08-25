
import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = 'b64e70cc2426ffe61d0bf9b8d2969145';
const String apiUrl = 'https://api.openweathermap.org/data/2.5/forecast?id=292223&units=metric&appid=$apiKey';

class ApiCall{
  Future<Map<String,dynamic>> getWeatherData()async{
    Uri url = Uri.parse(apiUrl);
    http.Response response = await http.get(url);
    if(response.statusCode == 200){
      Map<String,dynamic> data = json.decode(response.body);
      return data;
    }else{
      return Future.error('this is error');
    }
  }
}