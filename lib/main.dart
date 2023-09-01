import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motivation_alarm/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

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
            return MaterialApp(
              theme: ThemeData(
                colorScheme: lightDynamic,
                useMaterial3: true,
              ),
              darkTheme: ThemeData(
                colorScheme: darkDynamic,
                useMaterial3: true,
              ),
              themeMode: ThemeMode.dark,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: const Home(),
            );
          });
        });
  }
}
