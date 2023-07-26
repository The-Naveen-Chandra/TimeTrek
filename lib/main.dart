import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrek_app/components/enums.dart';
import 'package:timetrek_app/home/home_screen.dart';
import 'package:timetrek_app/model/menu_info.dart';
import 'package:timetrek_app/theme/dark_theme.dart';
import 'package:timetrek_app/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeTrek App',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(
          MenuType.clock,
          imageSource: '',
          title: '',
        ),
        child: const HomeScreen(),
      ),
    );
  }
}
