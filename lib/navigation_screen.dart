import 'package:flutter/material.dart';
import 'package:app_project/screen/calendar_screen.dart';
import 'package:app_project/screen/memo_screen.dart';
import 'package:app_project/screen/mypage_screen.dart';
import 'package:app_project/screen/search_screen.dart';
import 'package:app_project/const/colors.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);
  @override
  State createState() => _RootScreenState();
}

class _RootScreenState extends State with TickerProviderStateMixin {
  TabController? controller;
  int number = 3;


  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this); // 컨트롤러 초기화
//컨트롤러 속성이 변경될 때 마다 실행할 함수 등록
    controller!.addListener(tabListener);

  }

  tabListener() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: controller, // 컨트롤러 등록하기
        children: rendChildren(),
      ),
      bottomNavigationBar: renderBootomNavigation(),
    );
  }

  List<Widget> rendChildren(){
    return [
      SearchScreen(number: number),
      CalendarScreen(number: number),
      MemoScreen(number: number),
      MypageScreen(number: number),
    /*
      HomeScreen(number: number),
      Edit(number: number),
      */
    ];
  }

  BottomNavigationBar renderBootomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // Add this line
      currentIndex: controller!.index,
      selectedItemColor: MAIN_COLOR,
      unselectedItemColor: MIDLE_GREY_COLOR,
      onTap: (int index) {
        setState(() {
          controller!.animateTo(index);
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
          ),
          label: '검색',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_month,
          ),
          label: '일정',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.toc_rounded,
          ),
          label: '메모',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.people,
          ),
          label: '마이페이지',
        ),
      ],
    );
  }
}