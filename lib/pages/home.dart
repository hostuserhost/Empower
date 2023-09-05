import 'dart:async';
import 'dart:convert';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Color primcolor =
        Colors.blue.harmonizeWith(const ColorScheme.highContrastDark().primary);
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
                            ? ThemeData.dark(useMaterial3: true)
                            : ThemeData.light(useMaterial3: true),
                      );
                    },
                    icon: const Icon(Icons.brightness_6, size: 25),
                  );
                },
              ),
            ),
            Column(
              children: [
                const Align(
                  alignment: Alignment(-0.75, 0),
                  child: Text(
                    'JUST DO IT',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                Container(
                  height: 14.h,
                ),
                Container(
                  padding: const EdgeInsets.all(5).w,
                  height: 166.h,
                  width: 383.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: primcolor),
                      color: primcolor,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16)).w),
                  child: FutureBuilder(
                      future: getquotes(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Response<dynamic>> snapshot) {
                        if (snapshot.hasData == true) {
                          return AutoSizeText(
                            jsonDecode(snapshot.data.toString())['quote'],
                            style: const TextStyle(fontSize: 30),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16)).w),
                  height: 1.h,
                  width: 200.w,
                ),
                SizedBox(height: 43.h,),
                Padding(
                  padding: EdgeInsets.only(left:  41, right: 41),
               child: Row(
                  children: [
                 Text("0:00", style: TextStyle(fontSize: 20.sp),),
                    SizedBox(width: 232.w,),
                    Switch.adaptive(value: true, onChanged: null)
                  ],
                ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:  41, right: 41),
                  child: Row(
                    children: [
                      Text("0:00", style: TextStyle(fontSize: 20.sp),),
                      SizedBox(width: 232.w,),
                      Switch.adaptive(value: true, onChanged: null)
                    ],
                  ),
                ),
                SizedBox(height: 306.h),
                const IconButton(
                  onPressed: null,
                  icon: FaIcon(
                    FontAwesomeIcons.thinCirclePlus,
                    size: 60,
                  ),
                ),
                SizedBox(height: 23.h,),

              ],
            ),
          ]),
        ),
      ),
    );
  }
}

Future<Response> getquotes() async {
  final quot = await Dio().get(
    'https://quote-generator-api-six.vercel.app/api/quotes/random',
  );
  return quot;
}
