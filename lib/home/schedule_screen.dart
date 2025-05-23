import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

/// Simple data class for events
class CalendarEvent {
  final String title;
  final String time;
  final String location;
  final bool isHoliday;

  const CalendarEvent({
    required this.title,
    required this.time,
    required this.location,
    this.isHoliday = false,
  });

  String get display => isHoliday ? title : '$title\n$time\n$location';
}

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final Map<DateTime, List<CalendarEvent>> _events;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _events = _buildStudentSchedule();
  }

  Map<DateTime, List<CalendarEvent>> _buildStudentSchedule() {
    final start = DateTime(2024, 8, 6);
    final end = DateTime(2025, 5, 23);
    final data = <DateTime, List<CalendarEvent>>{};

    // Populate classes by weekday
    for (var day = start; !day.isAfter(end); day = day.add(const Duration(days: 1))) {
      final key = DateTime(day.year, day.month, day.day);
      switch (day.weekday) {
        case DateTime.monday:
        case DateTime.wednesday:
          data[key] = _mwClasses;
          break;
        case DateTime.tuesday:
        case DateTime.thursday:
          data[key] = _tthClasses;
          break;
        case DateTime.friday:
          data[key] = _fridayClasses;
          break;
        default:
          break;
      }
    }

    // Philippine holidays within term
    final holidays = {
      DateTime(2024, 8, 21): 'Ninoy Aquino Day',
      DateTime(2024, 11, 30): 'Bonifacio Day',
      DateTime(2024, 12, 25): 'Christmas Day',
      DateTime(2025, 1, 1): "New Year's Day",
      DateTime(2025, 2, 25): 'EDSA Revolution Anniversary',
      DateTime(2025, 4, 9): 'Araw ng Kagitingan',
      DateTime(2025, 6, 12): 'Independence Day',
    };
    holidays.forEach((date, name) {
      if (!date.isBefore(start) && !date.isAfter(end)) {
        data[DateTime(date.year, date.month, date.day)] = [
          CalendarEvent(title: name, time: '', location: '', isHoliday: true),
        ];
      }
    });

    return data;
  }

  List<CalendarEvent> get _mwClasses => const [
        CalendarEvent(title: 'PE 4', time: '9:30am - 10:30am', location: 'Gym'),
        CalendarEvent(title: 'SOCSC', time: '11:30am - 12:30pm', location: 'Dumont 02'),
        CalendarEvent(title: 'RE 114', time: '1:30pm - 2:30pm', location: 'Creegan 1004'),
        CalendarEvent(title: 'ENGL', time: '2:30pm - 3:30pm', location: 'Creegan 1014'),
        CalendarEvent(title: 'CPEPC 115', time: '5:30pm - 7:00pm', location: 'Teston 1007'),
      ];

  List<CalendarEvent> get _tthClasses => const [
        CalendarEvent(title: 'EAC 130', time: '10:30am - 12:00pm', location: 'Teston 1003'),
        CalendarEvent(title: 'CPEPC 117', time: '1:00pm - 4:00pm', location: 'Smart Lab'),
        CalendarEvent(title: 'CPEPC 128', time: '5:30pm - 7:00pm', location: 'Room 3001'),
      ];

  List<CalendarEvent> get _fridayClasses => const [
        CalendarEvent(title: 'EAC 100', time: '7:30am - 10:30am', location: 'Omer 1008'),
        CalendarEvent(title: 'SOCSC', time: '11:30am - 12:30pm', location: 'Dumont 02'),
        CalendarEvent(title: 'RE 114', time: '1:30pm - 2:30pm', location: 'Creegan 1004'),
        CalendarEvent(title: 'ENGL', time: '2:30pm - 3:30pm', location: 'Creegan 1014'),
      ];

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return _events[key] ?? [];
  }

  void _addCustomEvent() {
    if (_selectedDay == null) return;
    var title = '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Reminder/Quiz'),
        content: TextField(
          decoration: const InputDecoration(hintText: 'Title'),
          onChanged: (v) => title = v,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')), 
          ElevatedButton(
            onPressed: title.isEmpty ? null : () {
              setState(() {
                final key = DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
                _events[key] = [..._getEventsForDay(key), CalendarEvent(title: title, time: '', location: '')];
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF0097B2), Color(0xFF7ED957)],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: TableCalendar<CalendarEvent>(
                locale: Localizations.localeOf(context).toString(),
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                eventLoader: _getEventsForDay,
                onDaySelected: (selected, focused) {
                  setState(() {
                    _selectedDay = selected;
                    _focusedDay = focused;
                  });
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(color: Color(0xFF0097B2), shape: BoxShape.circle),
                  selectedDecoration: BoxDecoration(color:  Color(0xFF7ED957), shape: BoxShape.circle),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDay != null
                        ? DateFormat.yMMMMEEEEd().format(_selectedDay!)
                        : '',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: _addCustomEvent),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _getEventsForDay(_selectedDay ?? DateTime.now()).isEmpty
                    ? Center(child: Text('No events', style: TextStyle(fontSize: 16, color: theme.disabledColor)))
                    : ListView.builder(
                        itemCount: _getEventsForDay(_selectedDay ?? DateTime.now()).length,
                        itemBuilder: (context, index) {
                          final e = _getEventsForDay(_selectedDay ?? DateTime.now())[index];
                          return Card(
                            color: e.isHoliday ? Colors.red[100] : Colors.grey[200],
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                e.display,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: e.isHoliday ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
