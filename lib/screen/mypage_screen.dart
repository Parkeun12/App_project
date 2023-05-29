import 'package:app_project/const/colors.dart';
import 'package:flutter/material.dart';

class MypageScreen extends StatelessWidget {
  final int number;

  const MypageScreen({
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
      body: Column(
        children: [
          SizedBox(height: 30),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              CircleAvatar(
                radius: 70,
                backgroundColor: LIGHT_GREY_COLOR,
              ),
            ],
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  '내 정보',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.arrow_forward),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 1,
            color: DARK_GREY_COLOR,
          ),
          // Add additional content below if needed
        ],
      ),
    );
  }
}
