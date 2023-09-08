import 'package:alarm/alarm.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../logic/base_logic.dart';
import '../themes.dart';

Widget getmotiv(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(5).w,
    height: 166.h,
    width: 383.w,
    decoration: BoxDecoration(
        border: Border.all(color: primcolor),
        color: primcolor,
        borderRadius: const BorderRadius.all(Radius.circular(16)).w),
    child: FutureBuilder(
        future: getquotes(context.locale.countryCode == 'ru' ? 0 : 1),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == true) {
            return AutoSizeText(
              snapshot.data,
              style: const TextStyle(fontSize: 30),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
  );
}

Widget alarm(BuildContext context) {
  var cart = Provider.of<TimeModel>(context);
  return Padding(
    padding: const EdgeInsets.only(right: 40, left: 40).w,
    child: Row(
      children: [
        GestureDetector(
            onTap: () async {
              final TimeOfDay? result = await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
              if (result != null) {
                cart.addTime(result);
                var aler = AlarmSettings(
                  id: 0,
                  dateTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day + 1, result.hour, result.minute),
                  assetAudioPath: 'assets/music/alarm.mp3',
                  loopAudio: true,
                  vibrate: true,
                  volumeMax: true,
                  fadeDuration: 3.0,
                  notificationTitle: 'Make work',
                  notificationBody: 'This is the work',
                  enableNotificationOnKill: false,
                );
                cart.editalarm(aler);
                await Alarm.set(alarmSettings: aler);
                cart.startalarm(true);
              }
            },
            child: AutoSizeText(
              cart.time.format(context),
              style: TextStyle(fontSize: 20.sp),
            )),
        const Spacer(),
        SizedBox(
          height: 10,
          child: Switch.adaptive(
            value: cart.valuet,
            onChanged: (bool valuet) async {
              if (cart.valuet == true) {
                cart.startalarm(false);
                await Alarm.stop(0);
              } else {
                cart.startalarm(true);
                await Alarm.set(alarmSettings: cart.ala);
              }
            },
          ),
        )
      ],
    ),
  );
}
