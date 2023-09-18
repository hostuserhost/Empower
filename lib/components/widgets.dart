import 'package:alarm/alarm.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
        future: getquotes(context.locale.countryCode == 'US' ? 0 : 1),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == true) {
            return AutoSizeText(
              snapshot.data,
              style: GoogleFonts.getFont('Montserrat',
                  textStyle:
                      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold)),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
  );
}

Widget lnec(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodySmall?.color,
        border: Border.all(
          color: Theme.of(context).textTheme.bodySmall!.color!,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)).w),
    height: 1.h,
    width: 350.w,
  );
}

Widget onchalange(String title, String cont, BuildContext context, Widget ont) {
  return Container(
      // height: 82.h,
      width: 150.w,
      decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).textTheme.bodySmall!.color!, width: 2.w),
          borderRadius: BorderRadius.all(Radius.circular(14.r))),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 0).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              title.tr(),
              style: GoogleFonts.getFont('Montserrat',
                  textStyle: TextStyle(
                      color: primcolor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500)),
            ),
            Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    cont,
                    style: GoogleFonts.getFont('Montserrat',
                        textStyle: TextStyle(
                            fontSize: 13.sp, fontWeight: FontWeight.w500)),
                  ),
                ),
                Transform.scale(scale: 0.7.w, child: ont)
              ],
            )
          ],
        ),
      ));
}

Widget alarm(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 40, left: 40).w,
    child: Row(
      children: [
        Consumer<TimeModel>(
            builder: (_, valcar, __) => GestureDetector(
                onTap: () async {
                  final TimeOfDay? result = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (result != null) {
                    valcar.addTime(result);
                    var aler = AlarmSettings(
                      id: 0,
                      dateTime: DateTime.now().isBefore(DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                                result.hour,
                                result.minute,
                                0,
                                0,
                              )) ==
                              true
                          ? DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                              result.hour,
                              result.minute,
                            )
                          : DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day + 1,
                              result.hour,
                              result.minute,
                            ),
                      assetAudioPath: 'assets/music/alarm.mp3',
                      loopAudio: true,
                      vibrate: true,
                      volumeMax: true,
                      fadeDuration: 3.0,
                      notificationTitle: 'Make work',
                      notificationBody: 'This is the work',
                      enableNotificationOnKill: false,
                    );
                    valcar.editalarm(aler);
                    await Alarm.set(alarmSettings: aler);
                    valcar.startalarm(true);
                  }
                },
                child: AutoSizeText(
                  valcar.time.format(context),
                  style: GoogleFonts.getFont('Montserrat',
                      textStyle: TextStyle(fontSize: 20.sp)),
                ))),
        const Spacer(),
        SizedBox(
          height: 10,
          child: Consumer<TimeModel>(
              builder: (_, valcar, __) => Transform.scale(
                  scale: 1.0.w,
                  child: Switch(
                    value: valcar.valuet,
                    onChanged: (bool value) async {
                      if (valcar.valuet == true) {
                        valcar.startalarm(false);
                        await Alarm.stop(0);
                      } else {
                        valcar.startalarm(true);
                        await Alarm.set(alarmSettings: valcar.ala);
                      }
                    },
                  ))),
        )
      ],
    ),
  );
}
