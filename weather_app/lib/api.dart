import 'dart:convert';

import 'package:weather_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/weathermodel.dart';

class WeatherApi{
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

    Future<ApiResponse> getCurrentWeather(String location) async{
        String apiUrl = "$baseUrl?Key=$apiKey&q=$location&alerts=yes";
        try{
          final responce = await http.get(Uri.parse(apiUrl));
          if(responce.statusCode==200){
            return ApiResponse.fromJson(jsonDecode(responce.body));

          }else{
            throw Exception("Failed to load weather");
          }
        }catch(e){
            throw Exception("Failed to load weather");
        }
    }
  }