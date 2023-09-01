import 'package:alarm/alarm.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivation_alarm/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Alarm.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const Initapp(),
    ),
  );
}

class Initapp extends StatefulWidget {
  const Initapp({super.key});

  @override
  State<Initapp> createState() => _InitappState();
}

class _InitappState extends State<Initapp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return DynamicColorBuilder(
              builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            return ThemeProvider(
                initTheme: ThemeData.dark(),
                builder: (context, myTheme) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: myTheme,
                    darkTheme: ThemeData(
                      colorScheme: darkDynamic,
                      useMaterial3: true,
                    ),
                    themeMode: ThemeMode.system,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    home: const Home(),
                  );
                });
          });
        });
  }
}
