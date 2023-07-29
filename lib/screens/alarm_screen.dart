import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timetrek_app/model/alarm_info.dart';
import 'package:timetrek_app/model/data.dart';
import 'package:timetrek_app/service/alarm_helper.dart';
import 'package:timetrek_app/service/notification_service.dart';
import 'package:velocity_x/velocity_x.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  // alarm count
  // int alarmsCount = alarms.length;
  final AlarmHelper _alarmHelper = AlarmHelper();

  // alarm time
  DateTime? _alarmTime;
  late String _alarmTimeString;
  bool _isRepeatSelected = false;

  // record
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;

  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      Vx.log("------database initialized");
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

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
            const Text(
              "2 active alarms",
              style: TextStyle(color: Colors.grey),
            ),
            Expanded(
              child: FutureBuilder(
                future: _alarms,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children: snapshot.data!.map<Widget>((alarm) {
                        var alarmTime =
                            DateFormat('hh:mm aa').format(alarm.alarmDateTime!);

                        return GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("You want to delete ?"),
                                  actions: [
                                    TextButton(
                                      child: const Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        "Delete",
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                      onPressed: () {
                                        _alarmHelper.delete(alarm.id!);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade800,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          alarm.title!,
                                          style: const TextStyle(
                                            fontFamily: "avenir",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Switch(
                                      value: false,
                                      onChanged: (bool value) {
                                        value = true;
                                      },
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      alarmTime,
                                      style: const TextStyle(
                                        fontFamily: "avenir",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        "Loading...",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                },
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
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            // alarm configurations
            _alarmTimeString = DateFormat('HH:mm').format(DateTime.now());
            showModalBottomSheet(
              useRootNavigator: true,
              context: context,
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setModalState) {
                    return Container(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () async {
                              var selectedTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                final now = DateTime.now();
                                var selectedDateTime = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    selectedTime.hour,
                                    selectedTime.minute);
                                _alarmTime = selectedDateTime;
                                setModalState(() {
                                  _alarmTimeString = DateFormat('HH:mm')
                                      .format(selectedDateTime);
                                });
                              }
                            },
                            child: Text(
                              _alarmTimeString,
                              style: const TextStyle(fontSize: 32),
                            ),
                          ),
                          ListTile(
                            title: const Text('Repeat'),
                            trailing: Switch(
                              onChanged: (value) {
                                setModalState(() {
                                  _isRepeatSelected = value;
                                });
                              },
                              value: _isRepeatSelected,
                            ),
                          ),
                          const ListTile(
                            title: Text('Sound'),
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                          const ListTile(
                            title: Text('Title'),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                            ),
                          ),
                          FloatingActionButton.extended(
                            onPressed: () async {
                              DateTime? scheduleAlarmDateTime;
                              if (_alarmTime!.isAfter(DateTime.now())) {
                                scheduleAlarmDateTime = _alarmTime;
                              } else {
                                scheduleAlarmDateTime =
                                    _alarmTime!.add(const Duration(days: 1));
                              }

                              var alarmInfo = AlarmInfo(
                                alarmDateTime: scheduleAlarmDateTime,
                                title: "alarm",
                              );

                              _alarmHelper.insertAlarm(alarmInfo);
                            },
                            icon: const Icon(Icons.alarm),
                            label: const Text('Save'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
