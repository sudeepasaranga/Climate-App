import 'package:flutter/material.dart';
import 'package:weather_app/homepage.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 57, 105, 177), Color(0xFF1976D2)], // Blue gradient
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Weather animation (Replace with your GIF/animation asset)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/logo.png', // Add your weather GIF or animation here
                  height: 150,
                  width: 150,
                ),
              ),
              
              // Welcome text
              const Text(
                "Welcome to Weather App",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // 'Get Started' button with white text
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Homepage and replace the current page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.lightBlueAccent, // Button background color
                  textStyle: const TextStyle(fontSize: 20), // Button text size
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white, // Change the button text color to white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
