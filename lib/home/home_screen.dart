import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timetrek_app/components/clock_view.dart';
import 'package:timetrek_app/components/enums.dart';
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

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: menuItems
                      .map(
                          (currentMenuInfo) => buildMenuButton(currentMenuInfo))
                      .toList()),
            ),
            const VerticalDivider(
              color: Colors.white54,
              width: 1,
            ),
            Expanded(
              child: Consumer<MenuInfo>(
                builder: (context, value, child) {
                  if (value.menuType != MenuType.clock) {
                    return Container();
                  }

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 32),
                    alignment: Alignment.center,
                    // color: const Color(0xff2d2f41),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // time trek
                        const Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            "Time Trek",
                            style: TextStyle(
                              fontFamily: 'avenir',
                              fontSize: 24,
                            ),
                          ),
                        ),

                        // Time text
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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

                        // timezone
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Timezone",
                                style: TextStyle(
                                  fontFamily: 'avenir',
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 10),

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
                        ),
                        SizedBox(
                          height: 20,
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

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
      builder: (context, value, child) {
        return Container(
          height: 105,
          width: 95,
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: currentMenuInfo.menuType == value.menuType
                  ? Colors.grey.shade800
                  : Colors.transparent,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: TextButton(
            onPressed: () {
              var menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.updateMenu(currentMenuInfo);
            },
            child: Column(
              children: [
                // assets
                Image.asset(
                  currentMenuInfo.imageSource,
                  scale: 1.5,
                ),

                const SizedBox(height: 16),

                // text
                Text(
                  currentMenuInfo.title,
                  style: const TextStyle(
                    fontFamily: 'avenir',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
