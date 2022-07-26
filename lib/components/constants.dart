import 'package:flutter/material.dart';


const defaultColor = Colors.deepOrange;

String formattedTime(int time){
  int seconds = time%60;
  time = time ~/ 60;
  int minutes = time%60;
  time = time ~/ 60;
  int hrs = time;

  return [
    if (hrs > 0) hrs < 10 ? "0$hrs" : "$hrs",
    minutes < 10 ? "0$minutes" : "$minutes",
    seconds < 10 ? "0$seconds" : "$seconds",
  ].join(":");
}

String loggedUserID = "";