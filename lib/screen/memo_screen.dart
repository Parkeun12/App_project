import 'package:app_project/const/colors.dart';
import 'package:flutter/material.dart';

class MemoScreen extends StatelessWidget {
  final int number;

  const MemoScreen({
    required this.number,
    Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // 높이를 80으로 조정
        child: AppBar(
          backgroundColor: MAIN_COLOR,
          title: Text(
            'C언어 스터디',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                print('object');
              },
            ),
          ],

        ),
      ),
    );
  }
}