import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Color primcolor =
        Colors.blue.harmonizeWith(const ColorScheme.highContrastDark().primary);
    return Scaffold(
        body: SafeArea(
      child: Column(
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
                borderRadius: const BorderRadius.all(Radius.circular(16)).w),
            height: 7.h,
            width: 383.w,
          ),
          Container(
            height: 14.h,
          ),
          GestureDetector(
            child:   Container(
              padding: const EdgeInsets.all(5).w,
              height: 166.h,
              width: 383.w,
              decoration: BoxDecoration(
                  border: Border.all(color: primcolor),
                  color: primcolor,
                  borderRadius: const BorderRadius.all(Radius.circular(16)).w),
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
          ),
          SizedBox(
            width: 25.h,
          ),

        ],
      ),
    ));
  }
}

Future<Response> getquotes() async {
  final quot = await Dio().get(
    'https://quote-generator-api-six.vercel.app/api/quotes/random',
  );
  return quot;
}
