import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timetrek_app/components/clock_view.dart';

class TimeTrekScreen extends StatefulWidget {
  const TimeTrekScreen({super.key});

  @override
  State<TimeTrekScreen> createState() => _TimeTrekScreenState();
}

class _TimeTrekScreenState extends State<TimeTrekScreen> {
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
  }
}
