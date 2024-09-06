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
  String message = "Search for the location to get weather data";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color.fromARGB(255, 57, 105, 177), Color(0xFF1976D2)],
                ),
              ),
              child: Column(
                children: [
                  _buildSearchWidget(),
                  const SizedBox(height: 20),
                  if (inProgress)
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  else
                    Expanded(
                      child: SingleChildScrollView(child: _buildWeatherWidget(constraints)),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return SearchBar(
      hintText: "Search any location",
      onSubmitted: (value) {
        _getWeatherData(value);
      },
    );
  }

  Widget _buildWeatherWidget(BoxConstraints constraints) {
    if (response == null) {
      return Text(
        message,
        style: const TextStyle(color: Colors.white),
      );
    } else {
      double fontSizeFactor = constraints.maxWidth / 400; // Adjust font sizes based on width

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                Icons.location_on,
                size: 50,
                color: Colors.white,
              ),
              Flexible(
                child: Text(
                  response?.location?.name ?? "",
                  style: TextStyle(
                    fontSize: 40 * fontSizeFactor, // Dynamic font size
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                  overflow: TextOverflow.ellipsis, // Handle overflow for smaller screens
                ),
              ),
              Flexible(
                child: Text(
                  response?.location?.country ?? "",
                  style: TextStyle(
                    fontSize: 20 * fontSizeFactor, // Dynamic font size
                    fontWeight: FontWeight.w300,
                    color: Colors.white70,
                    fontFamily: 'Poppins',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  (response?.current?.tempC.toString() ?? "") + " °C",
                  style: TextStyle(
                    fontSize: 60 * fontSizeFactor, // Adjust temperature size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  response?.current?.condition?.text.toString() ?? "",
                  style: TextStyle(
                    fontSize: 20 * fontSizeFactor,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                    fontFamily: 'Poppins',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              height: 200 * fontSizeFactor, // Dynamically scale image size
              child: Image.network(
                "https:${response?.current?.condition?.icon}"
                    .replaceAll("64x64", "128x128"),
                scale: 0.7,
              ),
            ),
          ),
          Card(
            elevation: 4,
            color: Colors.white70,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("Humidity", response?.current?.humidity?.toString() ?? "", fontSizeFactor),
                    _dataAndTitleWidget("Wind Speed", "${response?.current?.windKph?.toString() ?? ""} km/h", fontSizeFactor),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("UV", response?.current?.uv?.toString() ?? "", fontSizeFactor),
                    _dataAndTitleWidget("Precipitation", "${response?.current?.precipMm?.toString() ?? ""} mm", fontSizeFactor),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("Local Time", response?.location?.localtime?.split(" ").last ?? "", fontSizeFactor),
                    _dataAndTitleWidget("Local Date", response?.location?.localtime?.split(" ").first ?? "", fontSizeFactor),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildAlertWidget(), // Add alert widget
        ],
      );
    }
  }

  Widget _dataAndTitleWidget(String title, String data, double fontSizeFactor) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            data,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 18 * fontSizeFactor, // Responsive font size
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 27 * fontSizeFactor,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertWidget() {
    if (response?.alerts?.alert == null || response!.alerts!.alert!.isEmpty) {
      return Container();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Weather Alerts:',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          ...response!.alerts!.alert!.map((alert) {
            return Card(
              color: Colors.red[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert.headline ?? "Alert",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      alert.desc ?? "",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Severity: ${alert.severity ?? ""}, Urgency: ${alert.urgency ?? ""}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Effective: ${alert.effective ?? ""}, Expires: ${alert.expires ?? ""}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      );
    }
  }

  _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });

    try {
      response = await WeatherApi().getCurrentWeather(location);
    } catch (e) {
      setState(() {
        message = "Failed to get weather";
        response = null;
      });
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
