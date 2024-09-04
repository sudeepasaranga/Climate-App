import 'package:weather_app/constants.dart';
import 'package:http/http.dart' as http;

class WeatherApi{
  final String baseUrl = "http://api.weatherapi.com/v1///current.json";

    getCurrentWeather(String location) async{
        String apiUrl = "$baseUrl?Key=$apiKey&q=$location";
        try{
          final responce = await http.get(Uri.parse(apiUrl));
          if(responce.statusCode==200){
            print(responce.body);

          }else{
            throw Exception("Failed to load weather");
          }
        }catch(e){
            throw Exception("Failed to load weather");
        }
    }
  }