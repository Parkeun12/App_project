import 'package:flutter/material.dart';

class Splash extends StatefulWidget{
  const Splash({Key? key}) : super(key: key);

  @override
  SplashScreen createState() => SplashScreen();
}

class SplashScreen extends State<Splash>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    'asset/logo.png',
                    width: 200,
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(100.0),
                    ),
                  ),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }

  @override
  void initState(){
    super.initState();
    
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }
}