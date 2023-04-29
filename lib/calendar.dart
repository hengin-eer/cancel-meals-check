import 'package:cancel_meals_check/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDay = DateTime(DateTime.now().toLocal().year,
      DateTime.now().toLocal().month, DateTime.now().toLocal().day);
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  Map<DateTime, List<Event>> _eventsList = {};
  List<Event> _selectedEvents = [];
  List<Event> getEvents(DateTime date) {
    return _eventsList[date] ?? [];
  }

  Map<String, List<Event>> _timeStampedEventList = {};

  @override
  void initState() {
    super.initState();

    var nowTime = DateTime.now().toLocal();
    var today = DateTime(nowTime.year, nowTime.month, nowTime.day);

    for (var i = 0; i < 365; i++) {
      var date = DateTime(2023, 4, 1).add(Duration(days: i));
      var meals = [
        Event('朝食', false, date),
        Event('昼食', false, date),
        Event('夕食', true, date),
      ];

      // var timestampedDate = Timestamp.fromDate(date);
      var timestampedDate = date.toString();

      setState(() {
        _eventsList[date] = meals;
        _timeStampedEventList[timestampedDate] = meals;
      });
    }

    _eventsList[today] = [
      Event('朝食', true, DateTime.now()),
      Event('昼食', true, DateTime.now()),
      Event('夕食', true, DateTime.now()),
    ];

    // 選択された日付の予定を取得
    // _selectedEvents = _eventsList[_selectedDay] ?? [];
    _selectedEvents = getEvents(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calendar Page'),
        ),
        body: Column(
          children: [
            TableCalendar(
              focusedDay: _selectedDay,
              firstDay: DateTime(2023, 4, 1),
              lastDay: DateTime(2099, 12, 31),
              availableCalendarFormats: const {
                CalendarFormat.month: "Month",
                CalendarFormat.twoWeeks: "2 weeks",
              },
              calendarFormat: _calendarFormat,
              // eventLoader: (day) => _eventsList[day.toLocal()] ?? [],
              eventLoader: (day) => getEvents(day.toLocal()),
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay.toLocal();
                  _selectedEvents = getEvents(selectedDay.toLocal());
                });
                print(_selectedEvents);
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _selectedDay = focusedDay;
                });
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, e) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: getEvents(date.toLocal())
                        .map((event) => Container(
                              margin: const EdgeInsets.all(1.5),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: event.isChecked
                                    ? Colors.redAccent[400]
                                    : Colors.greenAccent,
                                // Colors.orange,
                              ),
                              width: 8.0,
                              height: 8.0,
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _selectedEvents.length,
                itemBuilder: (context, index) {
                  final event = _selectedEvents[index];
                  return Card(
                    child: CheckboxListTile(
                      title: Text(event.title),
                      subtitle: Text('・メニュー1 ・メニュー2 ・メニュー3'),
                      value: event.isChecked,
                      onChanged: (value) {
                        setState(() {
                          event.isChecked = !event.isChecked;
                        });
                        // FireStoreからのデータの取得
                        FirebaseFirestore.instance
                            .collection('flutterDataCollection')
                            .doc('flutterDataDocument')
                            .get()
                            .then((ref) {
                          print(ref.get("mydata"));
                        });

                        FirebaseFirestore.instance
                            .doc('testCollection/testDocument')
                            .set({
                          '_eventsLists': {
                            'date': event.date,
                            event.title: event.isChecked,
                          }
                        }, SetOptions(merge: true));
                        print(event);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
