import 'package:flutter/material.dart';
import 'package:app_project/navigation_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:app_project/screen/loading_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(
    MaterialApp(
      initialRoute: '/loading', // Set the initial route to the LoadingScreen
      routes: {
        '/': (context) => RootScreen(), // Add a route for the RootScreen
        '/loading': (context) => LoadingScreen(), // Add a route for the LoadingScreen
      },
    ),
  );
}