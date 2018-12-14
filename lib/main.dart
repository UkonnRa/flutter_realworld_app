import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/models/app_state.dart';
import 'package:flutter_realworld_app/pages/login_page.dart';
import 'package:flutter_realworld_app/pages/main_page.dart';
import 'package:flutter_realworld_app/pages/new_article_page.dart';
import 'package:flutter_realworld_app/pages/register_page.dart';
import 'package:flutter_realworld_app/pages/search_page.dart';
import 'package:flutter_realworld_app/pages/settings_page.dart';
import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  var appState = AppState((b) => b..currentUser = null);

  try {
    final api = await Api.getInstance();
    final currentUser = await api.authCurrent();
    appState =
        appState.rebuild((b) => b..currentUser = currentUser.toBuilder());
  } catch (e) {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('jwt');
  } finally {
    runApp(Provider(store: Store<AppState>(appState), child: RealworldApp()));
  }
}

class RealworldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/settings': (context) => SettingsPage(),
        '/newArticle': (context) => NewArticlePage(),
        '/search': (context) => SearchPage()
      },
      onGenerateTitle: (context) => S.of(context).appTitle,
      theme: ThemeData(
          primaryColor: Colors.lightGreen, accentColor: Colors.orange),
      home: MainPage(MainPageType.GLOBAL_FEED),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
