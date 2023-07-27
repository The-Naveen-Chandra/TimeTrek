import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timetrek_app/components/clock_view.dart';
import 'package:timetrek_app/model/enums.dart';
import 'package:timetrek_app/model/data.dart';
import 'package:timetrek_app/model/menu_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // current time variable
    var now = DateTime.now();

    // formatted time and data variable
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;

    var offSection = '';
    if (timezoneString.startsWith('-')) offSection = '+';

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
                  if (value.menuType != MenuType.clock) {
                    return Container();
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 10,
                    ),
                    alignment: Alignment.center,
                    // color: const Color(0xff2d2f41),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // time trek
                        const Row(
                          children: [
                            Text(
                              "Time",
                              style: TextStyle(
                                  fontFamily: 'avenir',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Trek",
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontFamily: 'avenir',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),

                        // Time text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formattedTime,
                              style: const TextStyle(
                                fontFamily: 'avenir',
                                fontSize: 50,
                              ),
                            ),

                            // Date text
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                fontFamily: 'avenir',
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),

                        // Real time Clock View
                        Flexible(
                          flex: 4,
                          fit: FlexFit.tight,
                          child: Align(
                            alignment: Alignment.center,
                            child: ClockView(
                              size: MediaQuery.of(context).size.height / 4,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 7,
                        ),

                        // timezone
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Timezone",
                              style: TextStyle(
                                fontFamily: 'avenir',
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 5),

                            // timezone
                            Row(
                              children: [
                                const Icon(
                                  Icons.language,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  "UTC$offSection + $timezoneString",
                                  style: const TextStyle(
                                    fontFamily: 'avenir',
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
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
