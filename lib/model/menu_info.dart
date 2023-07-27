import 'package:flutter/material.dart';
import 'package:timetrek_app/model/enums.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String title;
  String imageSource;

  MenuInfo(this.menuType, {required this.title, required this.imageSource});

  updateMenu(MenuInfo menuInfo) {
    menuType = menuInfo.menuType;
    title = menuInfo.title;
    imageSource = menuInfo.imageSource;

    // notify
    notifyListeners();
  }
}
