import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final VoidCallback onTap;
  final VoidCallback settingsTap;
  final int timeSpent;
  final int timeGoal;
  final bool habitStarted;
  HabitTile(
      {super.key,
      required this.habitName,
      required this.onTap,
      required this.timeSpent,
      required this.settingsTap,
      required this.timeGoal,
      required this.habitStarted});
//CONVRT SECONDS INTO MIN:SEC
  String formatToMinSec(int totalSeconds) {
    String secs = (totalSeconds % 60).toString();
    String mins = (totalSeconds / 60).toStringAsFixed(1);

    if (secs.length == 1) {
      secs = '0' + secs;
    }

    if (mins[1] == '.') {
      mins = mins.substring(0, 1);
    }
    return mins + ' : ' + secs;
  }

  double percenCompleted() {
    return timeSpent / (timeGoal * 60);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: onTap,
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: Stack(
                      children: [
                        Center(
                          child: CircularPercentIndicator(
                            radius: 32,
                            lineWidth: 5.5,
                            percent:
                                percenCompleted() < 1 ? percenCompleted() : 1,
                            progressColor: percenCompleted() > 0.35
                                ? (percenCompleted() > 0.7
                                    ? Color.fromARGB(255, 0, 189, 6)
                                    : Color.fromARGB(255, 255, 166, 0))
                                : const Color.fromARGB(255, 255, 17, 0),
                          ),
                        ),
                        Center(
                          child: Icon(habitStarted
                              ? Icons.pause
                              : Icons.play_arrow_rounded),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      habitName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      formatToMinSec(timeSpent) +
                          ' / ' +
                          timeGoal.toString() +
                          ' = ' +
                          (percenCompleted() * 100).toStringAsFixed(0) +
                          '%',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: settingsTap,
              child: Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
