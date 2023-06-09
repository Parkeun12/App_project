import 'package:app_project/database/drift_database.dart';
import 'package:flutter/material.dart';
import 'package:app_project/component/main_calendar.dart';
import 'package:app_project/component/schedule_card.dart';
import 'package:app_project/component/today.dart';
import 'package:app_project/component/schedule_button.dart';
import 'package:app_project/const/colors.dart';
import 'package:get_it/get_it.dart';

class CalendarScreen extends StatefulWidget {
  final int number;
  const CalendarScreen({required this.number, Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Set elevation to 0 to remove the shadow
        title: Image.asset(
          'lib/asset/logo2.png',
          width: 100,
          height: 100,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MAIN_COLOR,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (_) => ScheduleButtonSheet(
              selectedDate: selectedDate,
            ),
            isScrollControlled: true,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
            SizedBox(height: 8.0),
            Today(
              selectedDate: selectedDate,
              count: 0,
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: StreamBuilder<List<Schedule>>(
                stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Container();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      final schedule = snapshot.data![index];
                      return Dismissible(
                        key: ObjectKey(schedule.id),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (DismissDirection direction){
                          GetIt.I<LocalDatabase>()
                              .removeSchedule(schedule.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, left: 8.0,
                        right: 8.0),

                        child: ScheduleCard(
                          startTime: schedule.startTime,
                          endTime: schedule.endTime,
                          content: schedule.content,
                        ),
                      ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}