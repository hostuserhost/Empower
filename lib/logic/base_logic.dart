import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:flutter/material.dart';

class TimeModel extends ChangeNotifier {
  TimeOfDay _time = TimeOfDay.now();
  bool _valuet = false;
  AlarmSettings _alarm = AlarmSettings(
    id: 0,
    dateTime: DateTime.now(),
    assetAudioPath: 'assets/music/alarm.mp3',
    loopAudio: true,
    vibrate: true,
    volumeMax: true,
    fadeDuration: 3.0,
    notificationTitle: 'Make work',
    notificationBody: 'This is the work',
    enableNotificationOnKill: false,
  );

  bool get valuet => _valuet;
  AlarmSettings get ala => _alarm;
  TimeOfDay get time => _time;

  void editalarm(AlarmSettings alaedit){
    _alarm = alaedit;
    notifyListeners();
  }
  void startalarm(bool valut) {
    _valuet = valut;
    notifyListeners();
  }

  void addTime(TimeOfDay timesed) {
    _time = timesed;
    notifyListeners();
  }
}

Future<String> getquotes(int lang) async {
  if (lang == 0) {
    var getq = await Dio()
        .get('https://quote-generator-api-six.vercel.app/api/quotes/random');
    return jsonDecode(getq.toString())['quote'];
  } else {
    var getq = await Dio().get('https://citbase.ru/random');
    return parse(getq.data).getElementsByClassName("mb-4").first.text;
  }
}
