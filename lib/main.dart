import 'package:flutter/material.dart';
import 'package:garden_app/presentation/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';

Future<void> main() async {
  runApp(GardenApp(
    router: AppRouter(),
  ));
}

class GardenApp extends StatelessWidget {
  final AppRouter router;

  const GardenApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pl', 'PL'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode &&
              supportedLocale.countryCode == locale?.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
