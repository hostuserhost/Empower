import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:motivation_alarm/components/widgets.dart';
import 'package:motivation_alarm/themes.dart';
import 'package:provider/provider.dart';

import '../logic/base_logic.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Stack(children: [
            Align(
              alignment: const Alignment(0.95, -1.01),
              child: ThemeSwitcher.withTheme(
                builder: (_, switcher, theme) {
                  return IconButton(
                    onPressed: () {
                      switcher.changeTheme(
                          theme: theme.brightness == Brightness.light
                              ? ThemeData.dark(useMaterial3: true).copyWith(
                                  scaffoldBackgroundColor: Colors.black,
                                )
                              : ThemeData.light(useMaterial3: true).copyWith(
                                  scaffoldBackgroundColor:
                                      const Color.fromRGBO(217, 217, 217, 1)));
                    },
                    icon: const Icon(Icons.brightness_6, size: 30),
                  );
                },
              ),
            ),
            Column(
              children: [
                Align(
                  alignment: const Alignment(-0.75, 0),
                  child: Text(
                    'JUST DO IT',
                    style: GoogleFonts.getFont('Montserrat',
                        textStyle: TextStyle(
                            fontSize: 30.sp, fontWeight: FontWeight.bold)),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: primcolor,
                      border: Border.all(
                        color: primcolor,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16)).w),
                  height: 7.h,
                  width: 383.w,
                ),
                SizedBox(
                  height: 14.h,
                ),
                getmotiv(context),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                      border: Border.all(
                        color: Theme.of(context).textTheme.bodySmall!.color!,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16)).w),
                  height: 1.h,
                  width: 200.w,
                ),
                SizedBox(
                  height: 43.h,
                ),
                alarm(context),
                Align(
                  alignment: const Alignment(-0.55, 0),
                  child: Text("whilsleep",
                          style: GoogleFonts.getFont('Montserrat',
                              textStyle:
                                  TextStyle(color: primcolor, fontSize: 13.sp)))
                      .tr(),
                ),
                lnec(context),
                SizedBox(
                  height: 286.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(41).w,
                  child: Row(
                    children: [
                      onchalange(
                          "daychalange",
                          "${Random().nextInt(10)}daych".tr(),
                          context,
                          Consumer<Valuetmodel1>(
                              builder: (_, valcar, __) => Switch(
                                    value: valcar.valuet1,
                                    onChanged: (bool value) {
                                      valcar.editchalange(value);
                                    },
                                  ))),
                      const Spacer(),
                      onchalange("newhabit", "sef", context, const Text("data"))
                    ],
                  ),
                ),
                lnec(context),
                Align(
                  alignment: const Alignment(-0.6, 0),
                  child: Text(
                    'powered'.tr(),
                    style: GoogleFonts.getFont('Montserrat',
                        textStyle: TextStyle(
                          fontSize: 15.sp,
                        )),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
