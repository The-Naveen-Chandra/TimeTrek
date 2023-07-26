import 'package:timetrek_app/components/enums.dart';
import 'package:timetrek_app/model/menu_info.dart';

List<MenuInfo> menuItems = [
  MenuInfo(MenuType.clock,
      title: "Clock", imageSource: "assets/images/clock_icon.png"),
  MenuInfo(MenuType.alarm,
      title: "Alarm", imageSource: "assets/images/alarm_icon.png"),
  MenuInfo(MenuType.timer,
      title: "Timer", imageSource: "assets/images/timer_icon.png"),
  MenuInfo(MenuType.stopwatch,
      title: "Stopwatch", imageSource: "assets/images/stopwatch_icon.png"),
];
