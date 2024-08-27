import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_c11_mon/core/applicition_theme_manager.dart';
import 'package:todo_app_c11_mon/core/page_route_names.dart';
import 'package:todo_app_c11_mon/core/routes_generator.dart';
import 'package:todo_app_c11_mon/core/services/loading_services.dart';

import 'core/widget/setting_prov.dart';
import 'firebase_options.dart';

void main() async {
  //to make sure every await task is done
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => SettingsProvider(), child: const MyApp()));
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context); //singleton
    return MaterialApp(
      themeMode: provider.currentThemeMode,
      // themeMode: ThemeMode.light,
      theme: ApplicitionThemeManager.lightTheme,
      darkTheme: ApplicitionThemeManager.darkTheme,
      // locale: Locale("ar"),
      locale: Locale(provider.currentLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'To Do Project',
      // theme: AppThemeManager.lightTheme,
      initialRoute: PageRouteName.initial,
      onGenerateRoute: RoutesGenerator.onGenerateRoute,
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),
    );
  }
}
