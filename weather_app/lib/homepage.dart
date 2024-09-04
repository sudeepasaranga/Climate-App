import 'package:flutter/material.dart';
import 'package:weather_app/api.dart';
import 'package:weather_app/weathermodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  ApiResponse? response;
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchWidget(),
            const SizedBox(height: 20),
            if(inProgress)
            CircularProgressIndicator() else _buildSearchWidget(),
          ],
        ),
      ),
    ));
  }

   Widget _buildSearchWidget(){
    return SearchBar(
      hintText: "Search any location",
      onSubmitted: (value){
        _getWeatherData(value);
      },
    );
   }

   Widget _buildSearchWidget() {
      if (response == null){
        return Text("Search for the location to get weather data");
      }else{
        return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(
                  Icons.location_on,
                  size: 50,
                  ),
                  Text(
                    response?.location?.name ?? "",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w300,

                    ),
                  ),
                  Text(
                    response?.location?.country ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:Text(
                        (response?.current?.tempC.toString() ?? "")+" °c",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ),
                        
                  Text(
                    (response?.current?.condition?.text.toString() ?? "")+" °c",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
              Center(
                child: SizedBox(
                  height: 200,
                  child:Image.network(
                    "https:${response?.current?.condition?.icon}"
                    .replaceAll("64x64","128x128" ),
                    scale: 0.7,
                  )
                )
              ),

              Card(
                elevation: 4,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _dataAndTitleWidget("title", "data"),
                        _dataAndTitleWidget("title", "data")
                      ],
                    )
                  ],
                ),
              )
      
             ],
        );
      }
   }

   Widget _dataAndTitleWidget(String title,String data){

        return Padding(
          padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text(
                  data,
                  style: const TextStyle(
                    fontSize: 27,
                    color:Colors.black87,
                    fontWeight: FontWeight.w600,

                  ), 
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 27,
                    color:Colors.black87,
                    fontWeight: FontWeight.w600,

                  ), 
                ),
              ],
          ) ,
        );

   }

   _getWeatherData(String location)async{
    setState(() {
      inProgress = true;
    });

    try{

       response = await WeatherApi().getCurrentWeather(location);
    }catch(e){

    }finally{

      setState(() {
        inProgress = false;
      });
    }
      
      
   }
}