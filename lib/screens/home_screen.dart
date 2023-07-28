import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetrek_app/model/enums.dart';
import 'package:timetrek_app/model/data.dart';
import 'package:timetrek_app/model/menu_info.dart';
import 'package:timetrek_app/screens/alarm_screen.dart';
import 'package:timetrek_app/screens/timetrek_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Create a list of BottomNavigationBarItem from menuItems
    List<BottomNavigationBarItem> bottomNavBarItems = menuItems.map((menuInfo) {
      return BottomNavigationBarItem(
        icon: Image.asset(
          menuInfo.imageSource,
          scale: 20,
          color: Colors.grey.shade800,
        ),
        activeIcon: Image.asset(
          menuInfo.imageSource,
          color: Colors.grey, // Set the selected color to gray
          scale: 20,
        ),
        label: menuInfo.title,
      );
    }).toList();

    return Scaffold(
      // Use the BottomNavigationBar widget here
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade800, // Add your desired color here
              width: 1, // Add your desired width here
            ),
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor:
                Colors.transparent, // Set the splash color to transparent
            highlightColor:
                Colors.transparent, // Set the highlight color to transparent
            splashFactory: NoSplash
                .splashFactory, // Set the splash factory to disable splash
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: bottomNavBarItems,
            currentIndex: menuItems.indexWhere(
              (menuInfo) =>
                  menuInfo.menuType == Provider.of<MenuInfo>(context).menuType,
            ),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,

            // unselectedLabelStyle: const TextStyle(
            //     fontSize: 12), // Set the label font size for unselected items
            // selectedLabelStyle: const TextStyle(
            //   fontSize: 12,
            // ),

            onTap: (index) {
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenu(
                menuItems[index],
              );
            },
          ),
        ),
      ),

      // body safe area
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Consumer<MenuInfo>(
                builder: (context, value, child) {
                  if (value.menuType == MenuType.clock) {
                    return TimeTrekScreen();
                  } else if (value.menuType == MenuType.alarm) {
                    return AlarmScreen();
                  }
                  return Container(
                    child: Center(
                      child: Text("To be developed..."),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildMenuButton(MenuInfo currentMenuInfo) {
  //   return Consumer<MenuInfo>(
  //     builder: (context, value, child) {
  //       return Container(
  //         height: 105,
  //         width: 95,
  //         margin: const EdgeInsets.symmetric(vertical: 10),
  //         decoration: BoxDecoration(
  //           color: currentMenuInfo.menuType == value.menuType
  //               ? Colors.grey.shade800
  //               : Colors.transparent,
  //           borderRadius: const BorderRadius.only(
  //             topRight: Radius.circular(30),
  //             bottomLeft: Radius.circular(30),
  //           ),
  //         ),
  //         child: TextButton(
  //           onPressed: () {
  //             var menuInfo = Provider.of<MenuInfo>(context, listen: false);
  //             menuInfo.updateMenu(currentMenuInfo);
  //           },
  //           child: Column(
  //             children: [
  //               // assets
  //               Image.asset(
  //                 currentMenuInfo.imageSource,
  //                 scale: 1.5,
  //               ),

  //               const SizedBox(height: 16),

  //               // text
  //               Text(
  //                 currentMenuInfo.title,
  //                 style: const TextStyle(
  //                   fontFamily: 'avenir',
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
