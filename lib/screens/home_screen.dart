import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  bool isRuning = false;
  late Timer timer;
  int totalPomodoros = 0;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros += 1;
        totalSeconds = twentyFiveMinutes;
        isRuning = false;
        timer.cancel();
      });
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onStartPressed() {
    isRuning = true;
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }

  void onPausePressed() {
    setState(() {
      isRuning = false;
      timer.cancel();
    });
  }

  void onResetPressed() {
    setState(() {
      isRuning = false;
      totalSeconds = twentyFiveMinutes;
      timer.cancel();
    });
  }

  String toMinutes(int seconds) {
    return (totalSeconds ~/ 60).toString().padLeft(2, '0');
  }

  String toSeconds(int seconds) {
    return (totalSeconds % 60).toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    var cardColor = Theme.of(context).cardColor;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox.expand(
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            toMinutes(totalSeconds),
                            style: TextStyle(
                                color: cardColor,
                                fontSize: 88,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        ':',
                        style: TextStyle(
                            color: cardColor,
                            fontSize: 100,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      child: SizedBox.expand(
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            toSeconds(totalSeconds),
                            style: TextStyle(
                                color: cardColor,
                                fontSize: 88,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      isRuning
                          ? Icons.pause_circle_outline_outlined
                          : Icons.play_circle_outline_outlined,
                      color: cardColor,
                    ),
                    iconSize: 99,
                    onPressed: isRuning ? onPausePressed : onStartPressed,
                  ),
                  IconButton(
                    onPressed: onResetPressed,
                    icon: Icon(
                      Icons.restore_rounded,
                      color: cardColor.withOpacity(0.9),
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(40))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pomodoros',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .color),
                          ),
                          Text(
                            '$totalPomodoros',
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .color),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
