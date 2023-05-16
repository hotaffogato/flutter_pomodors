import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  static const fiveSec = 5;
  int totalSeconds = fiveSec;
  late Timer timer;
  bool isRunning = false;
  int totalPomodor = 0;
  void onTick(Timer timer){
    if(totalSeconds == 0){
      setState(() {
        totalPomodor = totalPomodor + 1;
        isRunning = false;
        totalSeconds = fiveSec;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1 ;
      });
    }
  }
  void onStartBtn(){
    timer = Timer.periodic(
        const Duration(seconds:1),
        onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPauseBtn(){
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  // void format(int seconds){
  //   var duration = Duration(seconds:seconds);
  //   print(duration);
  //   return '$seconds';
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .colorScheme.background,
        body: Column(
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '$totalSeconds',
                    style: TextStyle(
                        color: Theme
                            .of(context)
                            .cardColor,
                    fontSize: 89,
                    fontWeight: FontWeight.w600),
                  ),
                )
            ),
            Flexible(
                flex: 3,
                child: Center(
                  child: IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning?
                    onPauseBtn :
                    onStartBtn,
                    icon:
                    Icon( isRunning ?
                    Icons.pause_circle_outline :
                    Icons.play_circle_outline),
                  ),
                  ),
            ),
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).cardColor
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pomodors',
                              style: TextStyle(
                                fontSize:20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF232B55),
                            ),
                            ),
                            Text('$totalPomodor',
                              style: TextStyle(
                                fontSize:60,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF232B55),
                              ),
                            ),
                          ],
                      ),
                      ),
                    ),
                  ],
                )
            )
          ],
        )
    );
  }
}