import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habitrack/utils/habit_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<List<dynamic>> habitList = [
    //[habitname, habitstarted, timespent, timegoal]
    ['Exercise', false, 0, 2],
    ['Code', false, 0, 1],
    ['Read', false, 0, 3],
  ];

  void habitStarted(int index) {
    var startTime = DateTime.now();
    int elapsedTime = habitList[index][2];
    setState(() {
      habitList[index][1] = !habitList[index][1];
    });
    Timer.periodic(Duration(seconds: 1), (Timer) {
      setState(() {
        if (!habitList[index][1]) {
          Timer.cancel();
        }
        var currentTime = DateTime.now();
        habitList[index][2] = elapsedTime +
            currentTime.second -
            startTime.second +
            60 * (currentTime.minute - startTime.minute) +
            60 * 60 * (currentTime.hour - startTime.hour);
      });
    });
  }

  void settingsOpened(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Settings for ' + habitList[index][0],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('Consistency is the key'),
      ),
      body: ListView.builder(
        itemCount: habitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: habitList[index][0],
            onTap: () {
              habitStarted(index);
            },
            settingsTap: () {
              settingsOpened(index);
            },
            timeSpent: habitList[index][2],
            timeGoal: habitList[index][3],
            habitStarted: habitList[index][1],
          );
        },
      ),
    );
  }
}
