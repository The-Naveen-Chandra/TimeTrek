import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timetrek_app/components/clock_view.dart';

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
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildMenuButton("Clock", "assets/images/clock_icon.png"),
              buildMenuButton("Alarm", "assets/images/alarm_icon.png"),
              buildMenuButton("Timer", "assets/images/timer_icon.png"),
              buildMenuButton("Stopwatch", "assets/images/stopwatch_icon.png"),
            ],
          ),
          const VerticalDivider(
            color: Colors.white54,
            width: 1,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
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
                  Flexible(
                    flex: 2,
                    child: Column(
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
                  ),

                  // Real time Clock View
                  const Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.center,
                      child: ClockView(),
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
                        // timezone
                        Row(
                          children: [
                            const Icon(
                              Icons.language,
                            ),
                            // const SizedBox(width: 16),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildMenuButton(String title, String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextButton(
        onPressed: () {},
        child: Column(
          children: [
            // assets
            Image.asset(
              image,
              scale: 1.5,
            ),

            const SizedBox(height: 16),

            // text
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'avenir',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
