import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetrek_app/model/data.dart';
import 'package:timetrek_app/service/notification_service.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  int alarmsCount = alarms.length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  "Ala",
                  style: TextStyle(
                      fontFamily: 'avenir',
                      fontSize: 40,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "rm",
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontFamily: 'avenir',
                      fontSize: 40,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Text(
              "$alarmsCount active alarms",
              style: const TextStyle(color: Colors.grey),
            ),
            Expanded(
              child: ListView(
                children: alarms.map((alarm) {
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade800,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Colors.red.withOpacity(0.4),
                      //       blurRadius: 8,
                      //       spreadRadius: 4,
                      //       offset: Offset(4, 4))
                      // ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.label,
                                  size: 24,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  alarm.description,
                                  style: const TextStyle(
                                    fontFamily: "avenir",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: true,
                              onChanged: (value) {},
                              // activeColor: Colors.white,
                              // thumbColor: Colors.grey,
                              // trackColor: Colors.grey.shade800,
                              activeColor: Colors.redAccent,
                              activeTrackColor:
                                  Colors.redAccent.withOpacity(0.2),
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey.shade800,
                            )
                          ],
                        ),
                        const Text(
                          "Mon - Fri",
                          style: TextStyle(
                            fontFamily: "avenir",
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "07:00 AM",
                              style: TextStyle(
                                fontFamily: "avenir",
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            // NotificationService()
            //     .showNotification(title: "TimeTrek", body: "Hello World");
            var scheduleNotificationDateTime =
                DateTime.now().add(Duration(seconds: 10));
            NotificationService().scheduleNotification(
                scheduleNotificationDateTime: scheduleNotificationDateTime);
          },
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
