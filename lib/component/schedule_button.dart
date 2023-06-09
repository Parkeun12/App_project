import 'package:flutter/material.dart';
import 'package:app_project/component/schedule_text_filed.dart';
import 'package:app_project/const/colors.dart';

import 'package:drift/drift.dart' hide Column;
import 'package:get_it/get_it.dart';
import 'package:app_project/database/drift_database.dart';

class ScheduleButtonSheet extends StatefulWidget{

  final DateTime selectedDate;

  const ScheduleButtonSheet({
    required this.selectedDate,
    Key? key
  }) : super(key: key);

  @override
  State<ScheduleButtonSheet> createState() => ScheduleButtonSheetState();
}

class ScheduleButtonSheetState extends State<ScheduleButtonSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Form(
      key: formKey,
    child: SafeArea(
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
                      onSaved: (String? val){
                        startTime = int.parse(val!);
                      },
                      validator: timeValidator,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: ScheduleTextField(
                      label: '종료시간',
                      isTime: true,
                      onSaved: (String? val){
                        endTime = int.parse(val!);
                      },
                      validator: timeValidator,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: ScheduleTextField(
                  label: '내용',
                  isTime: false,
                  onSaved: (String? val){
                    content = val;
                  },
                  validator: contentValidator,
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
    ),
    );
  }
  void onSavePressed() async{

   if(formKey.currentState!.validate()){
     formKey.currentState!.save();

     await GetIt.I<LocalDatabase>().createSchedule(
       SchedulesCompanion(
         startTime: Value(startTime!),
         endTime: Value(endTime!),
         content: Value(content!),
         date: Value(widget.selectedDate),
       ),
     );

     Navigator.of(context).pop();
   }
  }

  String? timeValidator(String? val) {

    if(val == null) {
      return '값을 입력해주세요';
    }

    int? number;

    try{
      number = int.parse(val);
    } catch (e){
      return '0시부터 24시 사이를 입력해주세요';
    }

    return null;
  }

  String? contentValidator(String? val) {

    if(val == null || val.length == 0){
      return '값을 입력해주세요';
    }

    return null;
  }
}

