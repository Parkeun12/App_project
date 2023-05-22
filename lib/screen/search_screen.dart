import 'package:app_project/const/colors.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final int number;

  const SearchScreen({
    required this.number,
    Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'lib/asset/logo2.png',
          width: 100,
          height: 100,
        ),
        centerTitle: true,
      ),
    );
  }
}