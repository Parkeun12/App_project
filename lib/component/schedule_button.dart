import 'package:flutter/material.dart';
import 'package:app_project/component/schedule_text_filed.dart';
import 'package:app_project/const/colors.dart';

class ScheduleButtonSheet extends StatefulWidget{
  const ScheduleButtonSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleButtonSheet> createState() => ScheduleButtonSheetState();
}

class ScheduleButtonSheetState extends State<ScheduleButtonSheet> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 2 + bottomInset,
        color: WHITE_COLOR,
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: bottomInset),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ScheduleTextField(
                      label: '시작시간',
                      isTime: true,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: ScheduleTextField(
                      label: '종료시간',
                      isTime: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: ScheduleTextField(
                  label: '내용',
                  isTime: false,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onSavePressed,
                  style: ElevatedButton.styleFrom(
                    primary: MAIN_COLOR,
                  ),
                  child: Text('저장'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void onSavePressed(){

  }
}

