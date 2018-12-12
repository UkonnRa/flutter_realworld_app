import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/models/app_state.dart';
import 'package:flutter_realworld_app/pages/login_page.dart';
import 'package:flutter_realworld_app/pages/main_page.dart';
import 'package:flutter_realworld_app/pages/profile_page.dart';
import 'package:flutter_realworld_app/pages/register_page.dart';
import 'package:flutter_realworld_app/pages/setting_page.dart';
import 'package:flutter_redurx/flutter_redurx.dart';

void main() {
  final appState = AppState((b) => b
    ..currentUser = null
    ..currentProfile = null);

  runApp(Provider(store: Store<AppState>(appState), child: RealworldApp()));
}

class RealworldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/main' : (context) => MainPage(),
        '/login' : (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/setting': (context) => SettingPage()
      },
      title: "Realworld Flutter App",
      theme: ThemeData(
          primaryColor: Colors.lightGreen, accentColor: Colors.orange),
      home: MainPage(),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
