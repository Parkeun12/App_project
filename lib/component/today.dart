import 'package:app_project/const/colors.dart';
import 'package:flutter/material.dart';

class Today extends StatelessWidget{
  final DateTime selectedDate;
  final int count;

  const Today({
    required this.selectedDate,
    required this.count,
    Key? key,
  }): super(key: key);

  @override
  Widget build(BuildContext context){
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: WHITE_COLOR,
    );

    return Container(
      child:Padding(

        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
        child:Container(
          decoration: BoxDecoration(
            color: MAIN_COLOR,
            borderRadius: BorderRadius.circular(8.0),
          ),
          //child: Padding(
          //padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}