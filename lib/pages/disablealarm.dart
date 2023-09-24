import 'package:alarm/alarm.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motivation_alarm/logic/base_logic.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:motivation_alarm/main.dart';
import 'package:motivation_alarm/themes.dart';

class Disablealarm extends StatelessWidget {
  const Disablealarm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 219.h,
          ),
          Text(
            "already",
            style: GoogleFonts.getFont('Montserrat',
                textStyle:
                    TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold)),
          ).tr(),
          const SizedBox(
            height: 56,
          ),
          SizedBox(
            height: 200.h,
            child: AutoSizeText(
              maxLines: 1,
              TimeOfDay.now().format(context),
              style: GoogleFonts.getFont('Montserrat',
                  textStyle: TextStyle(
                      fontSize: 150.sp,
                      color: primcolor,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          AutoSizeText(
            "nowork".tr(),
            style: GoogleFonts.getFont('Montserrat',
                textStyle:
                    TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w400)),
            maxLines: 1,
          ),
          SizedBox(height: 50.h),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20).w,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    await Alarm.stop(0);
                    Provider.of<TimeModel>(context, listen: false)
                        .startalarm(false);
                    main();
                  },
                  child: const SvgPicture(
                      AssetBytesLoader("assets/icon/disable.svg.vec")),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    await Alarm.stop(0);
                    Provider.of<TimeModel>(context, listen: false)
                        .startalarm(false);
                    main();
                  },
                  child: const SvgPicture(
                      AssetBytesLoader("assets/icon/enable.svg.vec")),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20).w,
            child: Row(
              children: [
                SizedBox(
                    width: 100.w,
                    child: Text(
                      'golosetime',
                      style: GoogleFonts.getFont('Montserrat',
                          textStyle: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    ).tr()),
                const Spacer(),
                SizedBox(
                    width: 100.w,
                    child: Text(
                      'startnewday',
                      style: GoogleFonts.getFont('Montserrat',
                          textStyle: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold)),
                    ).tr())
              ],
            ),
          )
        ],
      ),
    ));
  }
}
