import 'dart:convert';

import 'package:alarm/alarm.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

savepre(String key, bool ela) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool(key, ela);
}

var pref;

initPrefs() async {
  pref ??= await SharedPreferences.getInstance();
}

class Valuetmodel1 extends ChangeNotifier {
  bool _valuet1 = pref.getBool("valmod1") ?? false;

  bool get valuet1 => _valuet1;

  void editchalange(bool valut) {
    _valuet1 = valut;
    savepre("valmod1", valut);
    notifyListeners();
  }
}

class Valuetmodel2 extends ChangeNotifier {
  bool _valuet2 = pref.getBool("valmod2") ?? false;

  bool get valuet2 => _valuet2;

  void editchalange2(bool valut) {
    _valuet2 = valut;
    savepre("valmod2", valut);
    notifyListeners();
  }
}

class TimeModel extends ChangeNotifier {
  bool _valuet = pref.getBool("valmod") ?? false;

  bool get valuet => _valuet;

  void startalarm(bool valut) {
    _valuet = valut;
    savepre("valmod", valut);
    notifyListeners();
  }

  TimeOfDay _time = TimeOfDay.now();

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

  AlarmSettings get ala => _alarm;

  TimeOfDay get time => _time;

  void editalarm(AlarmSettings alaedit) {
    _alarm = alaedit;
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
