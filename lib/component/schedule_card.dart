import 'package:app_project/const/colors.dart';
import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final int startTime;
  final int endTime;
  final String content;

  const ScheduleCard({
    required this.startTime,
    required this.endTime,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Padding(
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0),
        child:Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.5,
              color: MAIN_COLOR,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Time(
                      startTime: startTime,
                      endTime: endTime
                  ),
                  SizedBox(width: 16.0),
                  _Content(
                    content: content,
                  ),
                  SizedBox(width: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget{
  final int startTime;
  final int endTime;

  const _Time({
    required this.startTime,
    required this.endTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: MAIN_COLOR,
      fontSize: 23.0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${startTime.toString().padLeft(2, '0')}:00',
          style: textStyle,
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget{
  final String content;

  const _Content({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    );

    return Expanded(
      child: Text(
        content,
        style: textStyle,
      ),
    );
  }
}