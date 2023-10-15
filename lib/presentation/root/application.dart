import 'package:energy_panel/_all.dart';


class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, localizationState) {
        //context.localizer.changeLanguage(localizationState.locale);

        return MaterialApp(
          theme: ThemeData(fontFamily: 'MontSerrat'),
          locale: localizationState.locale,
          localeResolutionCallback: (Locale? locale, Iterable<Locale> supportedLocales) => locale,
          // localeResolutionCallback: Localizer.getSupportedLocale,
          localizationsDelegates: const [
            Localizer.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routes: {
            HomePage.routeName: (context) => const HomePage(),
            StatisticsPage.routeName: (context) => const StatisticsPage(),
            // SettingsPage.routeName: (context) =>  SettingsPage(),
          },

         // home: LoginPage(email: email, password: password),
         home: const HomePage(),
        );
      },
    );
  }
}
