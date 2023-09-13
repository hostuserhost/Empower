import 'package:alarm/alarm.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivation_alarm/pages/disablealarm.dart';
import 'package:motivation_alarm/pages/home.dart';
import 'package:provider/provider.dart';
import 'logic/base_logic.dart';

void main() async {
  main1(false);
  Alarm.ringStream.stream.listen((_) => main1(true));
}

void main1(bool onalarm) async {
  WidgetsFlutterBinding.ensureInitialized(); // Инициалищирую плагины
  await EasyLocalization
      .ensureInitialized(); // Инициалищирую плагин Easy localization
  await Alarm.init(); // Инициализирую плагин будильника
  runApp(
    // запускает приложение

    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ru', 'RU')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: Initapp(
        onalarmi: onalarm,
      ),
    ),
  );
}

class Initapp extends StatefulWidget {
  final bool onalarmi;

  const Initapp({Key? key, required this.onalarmi}) : super(key: key);

  @override
  State<Initapp> createState() => _InitappState();
}

class _InitappState extends State<Initapp> {
  //инициализирую темы плагин screenutil и animated theme switcher
  @override
  Widget build(BuildContext context) {
    var initheme = MediaQuery.of(context).platformBrightness == Brightness.dark
        ? ThemeData.dark(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: Colors.black,
          )
        : ThemeData.light(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: const Color.fromRGBO(217, 217, 217, 1));
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return ThemeProvider(
              initTheme: initheme,
              builder: (context, myTheme) {
                return MultiProvider(
                    providers: [
                      ChangeNotifierProvider<TimeModel>(
                          create: (_) => TimeModel()),
                      ChangeNotifierProvider<Valuetmodel>(
                          create: (_) => Valuetmodel()),
                      ChangeNotifierProvider<Valuetmodel1>(
                          create: (_) => Valuetmodel1()),
                      ChangeNotifierProvider<Valuetmodel2>(
                          create: (_) => Valuetmodel2()),
                    ],
                    child: MaterialApp(
                        debugShowCheckedModeBanner: false,
                        theme: myTheme,
                        localizationsDelegates: context.localizationDelegates,
                        supportedLocales: context.supportedLocales,
                        locale: context.locale,
                        home: widget.onalarmi == true
                            ? const Disablealarm()
                            : const Home()));
              });
        });
  }
}
