import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:motivation_alarm/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [ /*Locale('en', 'US'), Locale('ru', 'RU') */],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child: const Initapp(),
    ),
  );
}

class Initapp extends StatefulWidget {
  const Initapp({ super.key });

  @override
  State<Initapp> createState() => _InitappState();
}

class _InitappState extends State<Initapp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            return home();
          }
      ),
    );
  }
}