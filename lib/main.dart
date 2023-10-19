// Import the necessary libraries
import 'package:flutter/material.dart';
import 'second.dart';  
import 'third.dart';   

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(), 
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});  

  @override
  _MyAppState createState() => _MyAppState(); 
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;  // A boolean to track if the app is in dark mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),  // Set the app's title
        backgroundColor: isDarkMode ? Colors.black : Colors.blue,  // Customize app bar color based on dark mode
        actions: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 500),
            crossFadeState: isDarkMode
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: _buildIconButton(Icons.light_mode),  // Display light mode button
            secondChild: _buildIconButton(Icons.dark_mode),   // Display dark mode button
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isDarkMode ? Colors.blueGrey : Colors.lightBlue,  // Set background gradient based on dark mode
              isDarkMode ? Colors.black : Colors.white,         // Set background gradient based on dark mode
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildWelcomeText(),          // Display a welcome message with animation
              const SizedBox(height: 20.0),  // Add some spacing
              _buildText('Explore the Latest News'),  // Display a text with style
              const SizedBox(height: 30.0),  // Add some spacing
              _buildElevatedButton('Check News', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecondPage(),  // Navigate to the 'second' page
                  ),
                );
              }),
              const SizedBox(height: 20.0), // Add some spacing
              _buildElevatedButton('About Team', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThirdPage(),  // Navigate to the 'third' page
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Create an IconButton widget for toggling dark mode
  Widget _buildIconButton(IconData icon) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () {
        setState(() {
          isDarkMode = !isDarkMode; // Toggle dark mode state
        });
      },
    );
  }

  // Create a welcome message with animation
  Widget _buildWelcomeText() {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: Text(
              'Welcome to Our App',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.deepOrange : Colors.deepPurple, // Change text color based on dark mode
              ),
            ),
          ),
        );
      },
    );
  }

  // Create a text widget with style
  Widget _buildText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        color: isDarkMode ? Colors.deepPurple : Colors.purple, // Change text color based on dark mode
      ),
    );
  }

  // Create an ElevatedButton with custom style
  Widget _buildElevatedButton(String text, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: isDarkMode ? Colors.teal : Colors.blue, // Change button color based on dark mode
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
