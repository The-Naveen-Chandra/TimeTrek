import 'package:timetrek_app/model/alarm_info.dart';
import 'package:timetrek_app/model/enums.dart';
import 'package:timetrek_app/model/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: "Clock", imageSource: "assets/images/clock-with-white-face.png"),
  MenuInfo(MenuType.alarm,
      title: "Alarm", imageSource: "assets/images/alarm-clock.png"),
  MenuInfo(MenuType.timer,
      title: "Timer", imageSource: "assets/images/hourglass.png"),
  MenuInfo(MenuType.stopwatch,
      title: "Stopwatch", imageSource: "assets/images/set-timer-button.png"),
];

List<AlarmInfo> alarms = [
  AlarmInfo(
    alarmDateTime: DateTime.now().add(Duration(hours: 1)),
    description: "Office",
  ),
  AlarmInfo(
    alarmDateTime: DateTime.now().add(Duration(hours: 1)),
    description: "College",
  )
];
