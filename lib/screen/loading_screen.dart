import 'package:flutter/material.dart';
import 'package:app_project/const/colors.dart';
import 'package:app_project/screen/login_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToRootScreen();
  }

  void _navigateToRootScreen() async {
    await Future.delayed(Duration(seconds: 3)); // Wait for 3 seconds
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Center the logo image and move it up by 10 pixels
          Transform.translate(
            offset: Offset(0, -10),  // move 10 pixels up
            child: Center(
              child: Image.asset(
                'lib/asset/logo.png',
                width: 250,
                height: 250,
              ),
            ),
          ),
          // Position the loading indicator and 'Loading...' text at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(MAIN_COLOR), // Set color to red
                ),
                SizedBox(height: 20),
                Text('Loading...'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}