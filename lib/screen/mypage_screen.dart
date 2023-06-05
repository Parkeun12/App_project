import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_project/const/colors.dart';

class MypageScreen extends StatefulWidget {
  final int number;

  const MypageScreen({
    required this.number,
    Key? key,
  }) : super(key: key);

  @override
  _MypageScreenState createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen> {
  bool isLoggedIn = false;
  String userEmail = '';
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLogin') ?? false;
      userEmail = prefs.getString('email') ?? '';
    });
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    prefs.remove('email');

    setState(() {
      isLoggedIn = false;
      userEmail = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isLoggedIn) {
          if (currentBackPressTime == null ||
              DateTime.now().difference(currentBackPressTime!) > Duration(seconds: 2)) {
            // Show the message when the back button is pressed once
            currentBackPressTime = DateTime.now();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('한번 더 누르면 앱이 종료됩니다'),
                duration: Duration(seconds: 2),
              ),
            );
            return false;
          } else {
            // Exit the app when the back button is pressed twice
            SystemNavigator.pop();
            return true;
          }
        }
        return true;
      },
      child: Scaffold(
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
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    isLoggedIn ? '로그아웃' : '내 정보',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    isLoggedIn ? Icons.logout : Icons.arrow_forward,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
