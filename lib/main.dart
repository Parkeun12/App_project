import 'package:flutter/material.dart';
import 'package:app_project/navigation_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting();

  runApp(
      MaterialApp(
        home: RootScreen(),
      )
  );
}